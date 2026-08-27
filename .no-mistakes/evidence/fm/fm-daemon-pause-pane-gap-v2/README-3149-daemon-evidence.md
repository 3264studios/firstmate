# Test evidence: daemon half of firstmate#3149 (base 524994c -> target f08d273)

Two kinds of evidence, both produced outside the worktree with `git archive` copies of the
base and target commits, so "before" is the pristine upstream daemon and "after" is this change.

## 1. Before/after regression tests (`before-after-focused-daemon-tests.txt`)

The NEW `tests/fm-daemon.test.sh` was run one test at a time against both trees.

| test | pristine 524994c daemon | f08d273 daemon |
|---|---|---|
| `test_housekeeping_busy_declared_wait_matures_its_window` (new) | FAIL: "paused busy declared wait produced 0 escalations past its window, expected exactly one" | pass |
| `test_enriched_wedge_under_declared_wait_uses_pause_cadence` (new) | FAIL: 4 wedge escalations inside one PAUSE_RESURFACE_SECS window (escalation 2..5, demand-deep-inspection) | pass |
| `test_stale_diagnostic_wedge_survives_busy_housekeeping` (flipped `paused` case) | FAIL: "paused enriched wedge escalated instead of routing to the pause cadence" | pass |
| `test_housekeeping_paused_resumed_cleared` (rewritten fixture, inverse guard) | pass | pass |

The full `tests/fm-daemon.test.sh` script (105 cases) also passes on the target tree.

## 2. End-to-end: real `bin/fm-supervise-daemon.sh` driving the real `bin/fm-watch.sh`

`e2e-<scenario>-<tree>.txt` are transcripts from spawning the real daemon process on a
throwaway state root, with the test harness's fake tmux (`tests/wake-helpers.sh`) standing in
for the terminal so the digest the daemon types into the captain's pane is logged verbatim.
Cadences were shortened so several windows fit in 30 s: `FM_PAUSE_RESURFACE_SECS=4`,
`FM_HOUSEKEEPING_TICK=1`, `FM_POLL=1`. One crew `audit-w7` with status log
`working: dispatching the long audit` / `paused: the audit engine is running to completion`.

### Defect 1 - busy declared wait in away mode (`e2e-busy-*.txt`)
Away mode from the start; the pane is genuinely busy (pi-ext busy event, the same fixture the
unit tests use) and past `FM_BUSY_TURN_MAX_SECS`, so the watcher hands the declared wait to the
daemon exactly once per declaration (PR #3147 behaviour, visible in the daemon log as a single
`self-handle (paused): stale: sess:fm-audit-w7`).

| | pristine 524994c | f08d273 |
|---|---|---|
| declared-wait rechecks delivered to the captain over ~6 windows | **0** | **6** (one per window) |
| possible-wedge escalations delivered | 0 | 0 |

Before the fix the busy verdict retired the marker every window and `migrate_watcher_pause_markers`
recreated it fresh, so the captain never heard about the wait again.

### Defect 2 - enriched wedge under a declared wait (`e2e-wedge-*.txt`)
The crew reads `working · source: run-step` (the classify-lib's `FM_CREW_STATE_BIN` stub seam;
the daemon's own `classify_stale` never reads it), so the watcher's normal-mode wedge timer
("provably working after a declared pause") decorates every wake as
`idle Ns, possible wedge, escalation N`. That timer only runs in the watcher's normal-mode triage,
so the daemon ran with afk off for 30 s (a supported state: it buffers and defers injection), then
afk was switched on so the buffered digest flushed to the captain's pane.

| | pristine 524994c | f08d273 |
|---|---|---|
| enriched wedge wakes the daemon received from the watcher | 4 | 4 |
| of those escalated as wedges (daemon log `escalate:`) | **4** (climbing to demand-deep-inspection) | **0** |
| of those self-handled as the declared pause | 0 | **4** |
| possible-wedge escalations delivered to the captain | **4** (2 demand-deep-inspection) | **0** |
| declared-wait rechecks delivered to the captain | 7 | 6 (one per window, the bounded recheck the intent promises) |

Each transcript carries the fixture, the exact digest lines typed into the captain's pane, the
counts, the daemon log, and the watcher's triage log.
