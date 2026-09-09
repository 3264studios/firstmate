#!/usr/bin/env bash
# Manual end-user transcript for the Pi --start-dir contract.
# Drives the real bin/fm-spawn.sh against the test suite's fake tmux/treehouse
# and a capturing fake Pi, then executes the delivered launch command so the
# process cwd Pi actually starts in is observed, not inferred.
set -u
ROOT_WT=${1:?worktree root}
. "$ROOT_WT/tests/fixtures.sh"
TMP_ROOT=$(fm_test_tmproot start-dir-demo)
CASE="$TMP_ROOT/demo"; HOME_DIR="$CASE/home"; PROJ="$CASE/project"; WT="$CASE/wt"
FAKEBIN=$(fm_test_make_spawn_fakebin "$CASE/fake")
fm_test_spawn_home "$HOME_DIR" pi
fm_git_worktree "$PROJ" "$WT" wt-demo
for id in demo typo codex; do fm_test_spawn_brief "$HOME_DIR" "$id"; done
mkdir -p "$WT/games/demo"
# Fake Pi: answers the version probe, and when launched records cwd + argv.
cat > "$FAKEBIN/pi" <<'SH'
#!/bin/sh
if [ "${1:-}" = --help ]; then printf '%s\n' 'Pi 0.85.1' 'Options: --help --tui-mode <mode>'; exit 0; fi
echo "[fake pi] started in: $(pwd -P)"
echo "[fake pi] argv: $*"
SH
chmod +x "$FAKEBIN/pi"
# Log window kills and treehouse calls so slot retirement is visible.
export FM_RETIRE_LOG="$CASE/retire.log"; : > "$FM_RETIRE_LOG"
mv "$FAKEBIN/tmux" "$FAKEBIN/tmux-unlogged"
cat > "$FAKEBIN/tmux" <<'SH'
#!/bin/bash
[ "${1:-}" != kill-window ] || printf '  [backend] tmux %s\n' "$*" >> "$FM_RETIRE_LOG"
exec "$(dirname "$0")/tmux-unlogged" "$@"
SH
cat > "$FAKEBIN/treehouse" <<'SH'
#!/bin/bash
printf '  [backend] treehouse %s (cwd %s)\n' "$*" "$(pwd -P)" >> "$FM_RETIRE_LOG"
SH
chmod +x "$FAKEBIN/tmux" "$FAKEBIN/treehouse"

spawn() {  # [fm-spawn args...]
  local launchlog="$CASE/launch.log"
  FM_FAKE_LAUNCH_LOG="$launchlog" FM_FAKE_PI_VERSION=0.85.1 GROK_HOME="$HOME_DIR/grok-home" \
    fm_test_run_spawn "$HOME_DIR" "$WT" "$FAKEBIN" "$@"
}
show() { printf '\n$ %s\n' "$*"; }
run_launch() {  # execute the delivered launch command as the endpoint shell would
  local launch; launch=$(tail -n 1 "$CASE/launch.log")
  echo "delivered launch command (tail of the fake tmux send-keys log):"
  printf '  %s\n' "$launch" | cut -c1-400
  echo "executing it from the worktree root:"
  (cd "$WT" && sh -c "$launch" 2>&1; echo "[endpoint shell] still in: $(pwd -P)") | sed 's/^/  /'
}

echo "worktree root: $WT"
echo "project:       $PROJ"

show "fm-spawn.sh demo <project> --mode no-mistakes --yolo off --harness pi --model codex-native/gpt-6-astra --effort high --start-dir games/demo"
spawn demo "$PROJ" --mode no-mistakes --yolo off --harness pi --model codex-native/gpt-6-astra --effort high --start-dir games/demo; echo "exit=$?"
echo "persisted task record (state/demo.meta, lifecycle-relevant fields):"
grep -E '^(worktree|start_dir|harness|model|effort|kind|spawn_gen)=' "$HOME_DIR/state/demo.meta" | sed 's/^/  /'
run_launch

show "fm-spawn.sh demo --relaunch   (ordinary recovery: recorded start_dir is reused)"
mv "$FAKEBIN/tmux" "$FAKEBIN/tmux-base"
cat > "$FAKEBIN/tmux" <<'TMUX'
#!/bin/bash
case "$*" in
  *'#{pane_current_command}'*) echo zsh; exit 0 ;;
  'list-windows '*) printf '%s\n' "fm-demo"; exit 0 ;;
esac
exec "$(dirname "$0")/tmux-base" "$@"
TMUX
chmod +x "$FAKEBIN/tmux"
spawn demo --relaunch; echo "exit=$?"
grep -E '^(worktree|start_dir|spawn_gen)=' "$HOME_DIR/state/demo.meta" | sed 's/^/  /'
run_launch

show "fm-spawn.sh demo --relaunch --start-dir games/other   (override refused)"
spawn demo --relaunch --start-dir games/other; echo "exit=$?"

show "fm-spawn.sh demo --relaunch --harness codex   (unsupported profile switch refused, record untouched)"
spawn demo --relaunch --harness codex; echo "exit=$?"
grep -E '^(worktree|start_dir|harness)=' "$HOME_DIR/state/demo.meta" | sed 's/^/  /'

show "mv games/demo games/renamed; then run the previously delivered launch command (launch-time guard)"
mv "$WT/games/demo" "$WT/games/renamed"
run_launch
mv "$WT/games/renamed" "$WT/games/demo"
mv "$FAKEBIN/tmux-base" "$FAKEBIN/tmux"

show "fm-spawn.sh typo <project> --mode no-mistakes --yolo off --harness pi --start-dir games/dmeo   (typo: refused after allocation, fresh slot retired)"
: > "$FM_RETIRE_LOG"
spawn typo "$PROJ" --mode no-mistakes --yolo off --harness pi --start-dir games/dmeo; echo "exit=$?"
echo "backend calls made by the refusal:"; cat "$FM_RETIRE_LOG"
[ -f "$HOME_DIR/state/typo.meta" ] && echo "task record published: YES (unexpected)" || echo "task record published: no"

show "fm-spawn.sh codex <project> --mode no-mistakes --yolo off --harness codex --start-dir games/demo   (unsupported harness refused)"
spawn codex "$PROJ" --mode no-mistakes --yolo off --harness codex --start-dir games/demo; echo "exit=$?"

show "fm-spawn.sh codex <project> --mode no-mistakes --yolo off --harness pi --start-dir ../outside   (escape refused before any allocation)"
: > "$FM_RETIRE_LOG"
spawn codex "$PROJ" --mode no-mistakes --yolo off --harness pi --start-dir ../outside; echo "exit=$?"
echo "backend calls made: $(wc -l < "$FM_RETIRE_LOG" | tr -d ' ')"

show "fm-spawn.sh codex <project> --mode no-mistakes --yolo off --harness pi   (no --start-dir: legacy root startup unchanged)"
spawn codex "$PROJ" --mode no-mistakes --yolo off --harness pi; echo "exit=$?"
grep -c '^start_dir=' "$HOME_DIR/state/codex.meta" | sed 's/^/  start_dir lines in record: /'
run_launch
