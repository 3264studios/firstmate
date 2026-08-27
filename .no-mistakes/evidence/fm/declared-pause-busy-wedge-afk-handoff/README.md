# Away-mode busy declared-pause handoff: before/after evidence

Scenario (all runs): away mode active (.afk), pi harness busy, spawn record past FM_BUSY_TURN_MAX_SECS,
status log declares 'paused: hosting the Lavish review, awaiting captain feedback', fake tmux renders a
fresh harness footer on EVERY capture-pane. One watcher launch + 5 re-arms (what the daemon does after each handled wake).

| commit | wakes / 6 launches | wake payload | wedge bookkeeping |
|---|---|---|---|
| base 60bedde (bug) | 3 | `stale: <win> (idle Ns, possible wedge, escalation N ...)` climbing to demand-deep-inspection | timer + escalation count climb |
| 09293e8 (hash-keyed one-shot) | 6 | plain `stale: <win>` on EVERY re-arm (wake loop) | clean |
| target 2a46b89 | 1 | plain `stale: <win>` once; .stale-<key> = declared:<status sig>; silent on 5 re-arms while the hash moves | clean |

## ticking-demo-base.txt
```
## base-60bedde: watcher = /tmp/fm-afk-busy-test.iQQ0ze/base/bin/fm-watch.sh
## fixture: afk active, pi harness busy, status='paused: hosting the Lavish review, awaiting captain feedback', footer ticks every capture
round 1 (first launch): captures 0->1, pane hash - -> aebccbdb14dd | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = <absent>
   wedge timer: present | escalations: none | normal-mode .paused marker: absent
round 2 (re-arm): captures 1->2, pane hash aebccbdb14dd -> 1ebcf2477027 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout (idle 3s, possible wedge, escalation 1)
   .stale-demo_fm-afk-ticking-scout = <absent>
   wedge timer: absent | escalations: 1 | normal-mode .paused marker: absent
round 3 (re-arm): captures 2->3, pane hash 1ebcf2477027 -> 17524d6eeacc | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = <absent>
   wedge timer: present | escalations: 1 | normal-mode .paused marker: absent
round 4 (re-arm): captures 3->4, pane hash 17524d6eeacc -> 0893b03cb830 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout (idle 2s, possible wedge, escalation 2)
   .stale-demo_fm-afk-ticking-scout = <absent>
   wedge timer: absent | escalations: 2 | normal-mode .paused marker: absent
round 5 (re-arm): captures 4->5, pane hash 0893b03cb830 -> 65da6f2775e9 | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = <absent>
   wedge timer: present | escalations: 2 | normal-mode .paused marker: absent
round 6 (re-arm): captures 5->6, pane hash 65da6f2775e9 -> a5a0491b1681 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout (idle 3s, possible wedge, escalation 3, demand-deep-inspection: same pane has wedge-escalated 3 times in a row - do not re-absorb on the run-step/pane state alone)
   .stale-demo_fm-afk-ticking-scout = <absent>
   wedge timer: absent | escalations: 3 | normal-mode .paused marker: absent
## base-60bedde result: 3 wake(s) across 6 watcher launches (1 launch + 5 re-arms)
```

## ticking-demo-hashkeyed.txt
```
## hash-keyed-09293e8: watcher = /tmp/fm-afk-busy-test.iQQ0ze/hashkeyed/bin/fm-watch.sh
## fixture: afk active, pi harness busy, status='paused: hosting the Lavish review, awaiting captain feedback', footer ticks every capture
round 1 (first launch): captures 0->1, pane hash - -> aebccbdb14dd | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = aebccbdb14ddd078e092db47951a1ae1
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 2 (re-arm): captures 1->2, pane hash aebccbdb14dd -> 1ebcf2477027 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = 1ebcf2477027d4cbc928aeef0a2e5f06
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 3 (re-arm): captures 2->3, pane hash 1ebcf2477027 -> 17524d6eeacc | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = 17524d6eeacc1b473bb7a3e8faa073b4
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 4 (re-arm): captures 3->4, pane hash 17524d6eeacc -> 0893b03cb830 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = 0893b03cb8308ee9708b9d6613e1eafd
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 5 (re-arm): captures 4->5, pane hash 0893b03cb830 -> 65da6f2775e9 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = 65da6f2775e9a089896bec3e452c3239
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 6 (re-arm): captures 5->6, pane hash 65da6f2775e9 -> a5a0491b1681 | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = a5a0491b16816f1e3b2dd527d2bb3dc6
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
## hash-keyed-09293e8 result: 6 wake(s) across 6 watcher launches (1 launch + 5 re-arms)
```

## ticking-demo-target.txt
```
## target-2a46b89: watcher = /Users/talon/.no-mistakes/worktrees/9b0bfac143a1/01M10ASF2Z826A1E2TV9AEX0E0/bin/fm-watch.sh
## fixture: afk active, pi harness busy, status='paused: hosting the Lavish review, awaiting captain feedback', footer ticks every capture
round 1 (first launch): captures 0->1, pane hash - -> aebccbdb14dd | WAKE -> watcher exited
   watcher stdout: stale: demo:fm-afk-ticking-scout
   .stale-demo_fm-afk-ticking-scout = declared:61:1787792128.337380565
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 2 (re-arm): captures 1->2, pane hash aebccbdb14dd -> 1ebcf2477027 | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = declared:61:1787792128.337380565
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 3 (re-arm): captures 2->3, pane hash 1ebcf2477027 -> 17524d6eeacc | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = declared:61:1787792128.337380565
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 4 (re-arm): captures 3->4, pane hash 17524d6eeacc -> 0893b03cb830 | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = declared:61:1787792128.337380565
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 5 (re-arm): captures 4->5, pane hash 0893b03cb830 -> 65da6f2775e9 | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = declared:61:1787792128.337380565
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
round 6 (re-arm): captures 5->6, pane hash 65da6f2775e9 -> a5a0491b1681 | silent (watcher still polling after a full cycle)
   watcher stdout: <empty>
   .stale-demo_fm-afk-ticking-scout = declared:61:1787792128.337380565
   wedge timer: absent | escalations: none | normal-mode .paused marker: absent
## target-2a46b89 result: 1 wake(s) across 6 watcher launches (1 launch + 5 re-arms)
```

## New regression tests against base (expected to fail before the fix)
```
=== test_afk_busy_declared_pause_hands_off_plain_stale
not ok - the away-mode busy-turn bound did not hand off the plain window identity: stale: test:fm-afk-review-scout (idle 1s, possible wedge, escalation 1)
=== test_afk_busy_declared_pause_ticking_pane_hands_off_once
not ok - the away-mode busy-turn bound did not hand off the plain window identity for a ticking pane: stale: test:fm-afk-ticking-scout (idle 501s, possible wedge, escalation 3, demand-deep-inspection: same pane has wedge-escalated 3 times in a row - do not re-absorb on the run-step/pane state alone)
```

## New regression tests against the hash-keyed intermediate 09293e8
```
=== test_afk_busy_declared_pause_hands_off_plain_stale
ok - away mode hands a busy declared pause to the daemon as a plain stale, and lifting the declaration restores the wedge escalation
=== all targeted cases passed
=== test_afk_busy_declared_pause_ticking_pane_hands_off_once
not ok - the away-mode handoff left the undeclared phase's wedge timer in place
```

## Targeted tests on target 2a46b89 (run from the worktree)
```
=== test_afk_busy_declared_pause_hands_off_plain_stale
ok - away mode hands a busy declared pause to the daemon as a plain stale, and lifting the declaration restores the wedge escalation
=== test_afk_busy_declared_pause_ticking_pane_hands_off_once
ok - away mode wakes the daemon once per declaration for a busy pane whose footer ticks on every capture
=== test_busy_declared_pause_is_rechecked_not_wedge_escalated
ok - a busy pane under a declared pause is rechecked on the long cadence, and lifting the pause restores the wedge escalation
=== test_afk_paused_changed_pane_hands_off_plain_stale
ok - AFK changed paused panes hand off plain stale identities for daemon-owned pause triage
=== test_afk_present_reverts_watcher_to_one_shot
ok - with .afk present the watcher reverts to one-shot so the daemon owns triage (no double-triage)
=== test_busy_pane_changing_hash_escalates_past_turn_age_bound
ok - a busy worker whose pane hash changes every poll still escalates once its completed-turn age reaches the bound
=== test_busy_pane_stable_hash_escalates_past_turn_age_bound
ok - a busy worker with a stable pane hash still escalates once its completed-turn age reaches the bound
=== test_secondmate_captain_held_resurfaces_in_normal_mode
ok - a captain-held secondmate re-surfaces on the bounded normal-mode cadence
=== test_nonterminal_stale_paused_absorbed_then_resurfaced
ok - a declared pause is absorbed on first sight, then re-surfaced as a recheck past the threshold, never wedge-escalated
=== all targeted cases passed
```
