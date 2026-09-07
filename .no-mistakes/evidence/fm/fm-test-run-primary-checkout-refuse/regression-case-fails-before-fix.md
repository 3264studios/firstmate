# New regression case run against the BASE commit runner (1533f47, no guard) with the target commit test file + tests/lib.sh overlaid
$ (cd <base-tree> && bash tests/fm-test-run.test.sh)
   > ok - exact suite coverage: --all lists every tests/*.test.sh once
   > ok - family selection returns a proper subset of the suite
   > ok - single-script selection lists exactly that path
   > ok - changed-file selection stays conservative (never silent full suite)
   > not ok - the runner must refuse the primary checkout under a task marker
   exit=1
