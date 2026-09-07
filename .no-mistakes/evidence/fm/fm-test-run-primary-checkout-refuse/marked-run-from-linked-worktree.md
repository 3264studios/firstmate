# Post-merge scenario: a ship worker (FM_TASK_ID set) runs the fixed runner from its LINKED task worktree
# runner checkout git dir : /Users/talon/.no-mistakes/repos/9b0bfac143a1.git/worktrees/01M1WXEKZ6SED7F8CWQ95EZMSB
# repository common dir   : /Users/talon/.no-mistakes/repos/9b0bfac143a1.git
# (git dir != common dir: a linked worktree, not the primary, so the guard must let it run)

$ FM_TASK_ID=task-z1 bin/fm-test-run.sh --list tests/fm-test-run.test.sh
   > tests/fm-test-run.test.sh
   exit=0

# The suite below builds git-init fixture primaries and runs a copied runner inside them.
# tests/lib.sh clears the inherited marker so those fixture runs are not refused; the new case sets FM_TASK_ID=probe-task itself.
$ FM_TASK_ID=task-z1 bin/fm-test-run.sh tests/fm-test-run.test.sh
   > FM_TEST_BEGIN 2026-09-07T03:24:27Z tests/fm-test-run.test.sh family=pure-contract-unit expected_gate_skip=none
   > ok - exact suite coverage: --all lists every tests/*.test.sh once
   > ok - family selection returns a proper subset of the suite
   > ok - single-script selection lists exactly that path
   > ok - changed-file selection stays conservative (never silent full suite)
   > ok - a task marker refuses execution in the primary checkout and leaves worktrees and inspection alone
   > ok - runner and its documentation surfaces select their curated family, not just their contract owners
   > ok - shell line-ending policy selects runner coverage
   > fm-test-run: no tests selected for changes vs HEAD (map is conservative; use --all for the complete suite)
   > ok - changed selection covers dependents, fails closed for live unmapped source, and accepts retired unconsumed source
   > ok - a bin reference selects the referencing scripts, and consumers still select their curated families
   > ok - changed defaults to bounded automatic scheduling with serial override
   > ok - Windows emulation exempts only synthetic POSIX modes
   > ok - a plain script list defaults to bounded automatic concurrency without an automatic timeout
   > ok - family proofs run concurrently only within separate family phases
   > ok - empty changed selection emits deterministic text and JSON summaries
   > ok - timing markers and JSON artifact are valid
   > ok - aggregate exit reflects any script failure
   > ok - gate-skip accounting is honest and non-failing
   > ok - fail-on-gate-skip converts herdr-not-found into a hard failure
   > ok - exclude-family drops the named primary family after selection
   > ok - portable shard union, disjointness, and coverage guard hold
   > ok - portable serial shards are a deterministic disjoint cover of the serial lane
   > ok - coverage guard reports and bounds the unmeasured portable serial share
   > ok - portable serial shard lanes refuse mismatched, out-of-range, and countless names
   > ok - --jobs refuses non-proven / stateful selections
   > ok - --jobs admits and schedules a family with a recorded concurrent proof
   > ok - an unclassified new test stays serial while the proven residual family runs concurrently
   > ok - a concurrent run starts the longest-hint script first
   > ok - --per-script-timeout-secs turns a hung script into a bounded failure
   > ok - --max-wall-ms fails an over-budget run and refuses a malformed budget
   > ok - jobs scheduler runs proven scripts; failure propagates; non-proven refused
   > ok - Herdr CI family-run step times out at 20 min under a 75 min job backstop
   > ok - aggregate-json merges lane timing artifacts
   > FM_TEST_END 2026-09-07T03:26:00Z tests/fm-test-run.test.sh exit=0 duration_ms=93197 gate_skip=false
   > FM_TEST_SUMMARY total=1 failed=0 skipped_gate=0 duration_ms=93277
   > FM_TEST_SUMMARY_FAMILY family=pure-contract-unit count=1 duration_ms=93197 failed=0
   > FM_TEST_SLOWEST rank=1 script=tests/fm-test-run.test.sh duration_ms=93197
   exit=0

