#!/usr/bin/env bash
# Manual E2E demo: away mode + busy pane past FM_BUSY_TURN_MAX_SECS + declared `paused:`
# wait, with a fake tmux whose harness footer ticks on EVERY capture-pane.
# Runs one watcher launch, then 5 re-arms (what the daemon does after each handled
# wake), printing per round what the daemon would see. Usage: demo.sh <repo-root> <label>
set -u
ROOT_DIR=$1; LABEL=$2
. "$ROOT_DIR/tests/.fm-watch-triage-defs.sh"   # test fixtures (make_case, wait_poll_cycle, ack_stopped_cycle, ...)
dir=$(make_case "demo-$LABEL"); state="$dir/state"; fakebin="$dir/fakebin"
out="$dir/watch.out"; window="demo:fm-afk-ticking-scout"; ticks="$dir/ticks"
statusf="$state/afk-ticking-scout.status"
cat > "$fakebin/tmux" <<'SH'
#!/usr/bin/env bash
set -u
case "${1:-}" in
  list-windows) [ -n "${FM_FAKE_TMUX_WINDOW:-}" ] && printf '%s\n' "${FM_FAKE_TMUX_WINDOW#*:}"; exit 0 ;;
  capture-pane)
    n=$(( $(cat "$FM_FAKE_TMUX_TICKS" 2>/dev/null || echo 0) + 1 )); echo "$n" > "$FM_FAKE_TMUX_TICKS"
    printf 'Working... (%d.%ds) lavish-axi poll' "$(( 7200 + n ))" "$(( n % 10 ))"; exit 0 ;;
  display-message) case "$*" in *pane_current_command*) printf '%s\n' "${FM_FAKE_TMUX_CURRENT_COMMAND:-}"; exit 0 ;; esac ;;
esac
exit 1
SH
chmod +x "$fakebin/tmux"
printf 'window=%s\nkind=scout\nharness=pi\n' "$window" > "$state/afk-ticking-scout.meta"
record_pi_busy "$state" afk-ticking-scout
printf 'paused: hosting the Lavish review, awaiting captain feedback\n' > "$statusf"
printf '%s' "$(seen_sig "$statusf")" > "$state/.seen-afk-ticking-scout_status"
key=$(printf '%s' "$window" | tr ':/.' '___')
touch -t 200001010000 "$state/afk-ticking-scout.meta"     # spawn record far past the bound
date '+%s' > "$state/.afk"                                   # away mode active
echo "## $LABEL: watcher = $ROOT_DIR/bin/fm-watch.sh"
echo "## fixture: afk active, pi harness busy, status='$(cat "$statusf")', footer ticks every capture"
wakes=0
for round in 1 2 3 4 5 6; do
  prev_hash=$(cat "$state/.hash-$key" 2>/dev/null || echo '-'); prev_ticks=$(cat "$ticks" 2>/dev/null || echo 0)
  : > "$out"
  PATH="$fakebin:$PATH" FM_FAKE_TMUX_WINDOW="$window" FM_FAKE_TMUX_TICKS="$ticks" \
    FM_STATE_OVERRIDE="$state" FM_CREW_STATE_BIN="$fakebin/fm-crew-state.sh" \
    FM_FAKE_CREW_STATE='state: working · source: pane · harness busy (pi-ext)' \
    FM_BUSY_TURN_MAX_SECS=1 FM_STALE_ESCALATE_SECS=1 FM_PAUSE_RESURFACE_SECS=999 \
    FM_POLL=0.2 FM_SIGNAL_GRACE=1 FM_CHECK_INTERVAL=999999 FM_HEARTBEAT=999999 \
    "$ROOT_DIR/bin/fm-watch.sh" > "$out" &
  pid=$!
  if wait_poll_cycle "$state" "$pid"; then verdict="silent (watcher still polling after a full cycle)"; reap "$pid"
  else verdict="WAKE -> watcher exited"; fi
  cur_hash=$(cat "$state/.hash-$key" 2>/dev/null || echo '-'); cur_ticks=$(cat "$ticks" 2>/dev/null || echo 0)
  [ -s "$out" ] && wakes=$((wakes + 1))
  printf 'round %d (%s): captures %s->%s, pane hash %s -> %s | %s\n' "$round" \
    "$([ "$round" = 1 ] && echo 'first launch' || echo 're-arm')" "$prev_ticks" "$cur_ticks" \
    "${prev_hash:0:12}" "${cur_hash:0:12}" "$verdict"
  printf '   watcher stdout: %s\n' "$([ -s "$out" ] && cat "$out" || echo '<empty>')"
  printf '   .stale-%s = %s\n' "$key" "$(cat "$state/.stale-$key" 2>/dev/null || echo '<absent>')"
  printf '   wedge timer: %s | escalations: %s | normal-mode .paused marker: %s\n' \
    "$([ -e "$state/.stale-since-$key" ] && echo present || echo absent)" \
    "$(cat "$state/.wedge-escalations-$key" 2>/dev/null || echo none)" \
    "$([ -e "$state/.paused-$key" ] && echo present || echo absent)"
  ack_stopped_cycle "$state" >/dev/null 2>&1 || true
done
echo "## $LABEL result: $wakes wake(s) across 6 watcher launches (1 launch + 5 re-arms)"
