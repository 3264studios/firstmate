# fm-test-run.sh primary-checkout refusal: manual transcript
# fixture: <tmp>/repo is the primary checkout (branch main); <tmp>/linked is a linked worktree (branch task-z1)
# <tmp>/repo-alias is a symlink to the primary, so the same primary is reachable by a different top-level path
   git dir of primary : /private<tmp>/repo/.git
   common dir         : /private<tmp>/repo/.git
   git dir of linked  : /private<tmp>/repo/.git/worktrees/linked
   primary branch: main | probe ran in primary: no | probe ran in linked: no

=== BEFORE the fix (runner from base commit 1533f47 copied into the primary) ===

## base runner, task marker set, primary checkout: the hazard from #3848 (suite runs and moves the primary's branch)
$ FM_TASK_ID=task-z1 <tmp>/repo/bin/fm-test-run.sh tests/probe.test.sh 
   > FM_TEST_BEGIN 2026-09-07T03:18:40Z tests/probe.test.sh family=unclassified expected_gate_skip=none
   > ok - probe suite ran in /private<tmp>/repo and switched to probe-stray
   > FM_TEST_END 2026-09-07T03:18:40Z tests/probe.test.sh exit=0 duration_ms=51 gate_skip=false
   > FM_TEST_SUMMARY total=1 failed=0 skipped_gate=0 duration_ms=125
   > FM_TEST_SUMMARY_FAMILY family=unclassified count=1 duration_ms=51 failed=0
   > FM_TEST_SLOWEST rank=1 script=tests/probe.test.sh duration_ms=51
   exit=0
   primary branch: probe-stray | probe ran in primary: yes | probe ran in linked: no

=== AFTER the fix (runner from target commit 51a3279) ===

## task marker set, primary checkout, explicit suite: refused before any suite runs
$ FM_TASK_ID=task-z1 <tmp>/repo/bin/fm-test-run.sh tests/probe.test.sh 
   > fm-test-run: refusing to run in the repository primary checkout /private<tmp>/repo while FM_TASK_ID=task-z1 is set; run from the assigned task worktree instead
   exit=2
   primary branch: main | probe ran in primary: no | probe ran in linked: no

## task marker set, primary checkout, --all: refused before selection
$ FM_TASK_ID=task-z1 <tmp>/repo/bin/fm-test-run.sh --all 
   > fm-test-run: refusing to run in the repository primary checkout /private<tmp>/repo while FM_TASK_ID=task-z1 is set; run from the assigned task worktree instead
   exit=2
   primary branch: main | probe ran in primary: no | probe ran in linked: no

## task marker set, primary reached through a different path (symlink alias): still refused, remediation names the resolved primary
$ FM_TASK_ID=task-z1 <tmp>/repo-alias/bin/fm-test-run.sh tests/probe.test.sh 
   > fm-test-run: refusing to run in the repository primary checkout /private<tmp>/repo while FM_TASK_ID=task-z1 is set; run from the assigned task worktree instead
   exit=2
   primary branch: main | probe ran in primary: no | probe ran in linked: no

## task marker set, linked task worktree (the assigned placement): runs
$ FM_TASK_ID=task-z1 <tmp>/linked/bin/fm-test-run.sh tests/probe.test.sh 
   > FM_TEST_BEGIN 2026-09-07T03:18:40Z tests/probe.test.sh family=unclassified expected_gate_skip=none
   > ok - probe suite ran in /private<tmp>/linked and switched to probe-stray
   > FM_TEST_END 2026-09-07T03:18:40Z tests/probe.test.sh exit=0 duration_ms=53 gate_skip=false
   > FM_TEST_SUMMARY total=1 failed=0 skipped_gate=0 duration_ms=193
   > FM_TEST_SUMMARY_FAMILY family=unclassified count=1 duration_ms=53 failed=0
   > FM_TEST_SLOWEST rank=1 script=tests/probe.test.sh duration_ms=53
   exit=0
   primary branch: main | probe ran in primary: no | probe ran in linked: yes

## no task marker, primary checkout (a person in their own checkout): unchanged, runs
$ <tmp>/repo/bin/fm-test-run.sh tests/probe.test.sh 
   > FM_TEST_BEGIN 2026-09-07T03:18:41Z tests/probe.test.sh family=unclassified expected_gate_skip=none
   > ok - probe suite ran in /private<tmp>/repo and switched to probe-stray
   > FM_TEST_END 2026-09-07T03:18:41Z tests/probe.test.sh exit=0 duration_ms=50 gate_skip=false
   > FM_TEST_SUMMARY total=1 failed=0 skipped_gate=0 duration_ms=133
   > FM_TEST_SUMMARY_FAMILY family=unclassified count=1 duration_ms=50 failed=0
   > FM_TEST_SLOWEST rank=1 script=tests/probe.test.sh duration_ms=50
   exit=0
   primary branch: probe-stray | probe ran in primary: yes | probe ran in linked: no

## task marker set, primary checkout, inspection --list: still available, executes nothing
$ FM_TASK_ID=task-z1 <tmp>/repo/bin/fm-test-run.sh --list tests/probe.test.sh 
   > tests/probe.test.sh
   exit=0
   primary branch: main | probe ran in primary: no | probe ran in linked: no

## task marker set, primary checkout, inspection --list-families: still available
$ FM_TASK_ID=task-z1 <tmp>/repo/bin/fm-test-run.sh --list-families 
   > pure-contract-unit
   > watcher-wake-lock
   > real-herdr-gated
   > secondmate
   > session-bootstrap
   > live-harness-optin
   > backend-dispatch
   > pr-forge
   > afk
   > snapshot-bearings
   > cmux
   > zellij
   > orca
   > standalone
   > unclassified
   exit=0
   primary branch: main | probe ran in primary: no | probe ran in linked: no

## task marker set, primary checkout, no selection mode: usage error wins (not the refusal)
$ FM_TASK_ID=task-z1 <tmp>/repo/bin/fm-test-run.sh 
   > fm-test-run: select with --all, --family <name>, --lane <name>, --proven-isolated, --changed, or one or more script paths (see --help)
   exit=2
   primary branch: main | probe ran in primary: no | probe ran in linked: no
