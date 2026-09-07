# fm-spawn.sh FM_TASK_ID pane export: manual transcript
# Each case drives the real bin/fm-spawn.sh with a fake tmux that logs pane payloads in send order,
# a fake 'codex' harness that prints the FM_TASK_ID it inherits, and launch-env-allowlist enabled.

## ship spawn (trace context off): fm-spawn.sh ship-z1
$ fm-spawn.sh ship-z1 <tmp>/ship/project --harness codex --backend tmux --mode no-mistakes --yolo off 
   > warning: <tmp>/ship/home/data/ship-z1/launch-brief.md records no delivery contract line (scaffolded before ship briefs recorded one); launching on the explicit --mode no-mistakes - confirm its definition of done matches
   > spawned ship-z1 harness=codex kind=ship mode=no-mistakes yolo=off window=firstmate:fm-ship-z1 worktree=<tmp>/ship/wt
   spawn exit=0
   pane payloads in send order (fake tmux log):
          1	treehouse get
          2	export GOTMPDIR=/tmp/fm-ship-z1/gotmp
          3	export FM_TASK_ID=ship-z1
          4	/usr/bin/env -i ${HOME+"HOME=$HOME"} ${PATH+"PATH=$PATH"} ${USER+"USER=$USER"} ${LOGNAME+"LOGNAME=$LOGNAME"} ${SHELL+"SHELL=$SHELL"} ${TERM+"TERM=$TERM"} ${COLORTERM+"COLORTERM=$COLORTERM"} ${LANG+"LANG=$LANG"} ${LC_ALL+"LC_ALL=$LC_ALL"} ${LC_CTYPE+"LC_CTYPE=$LC_CTYPE"} ${TMPDIR+"TMPDIR=$TMPDIR"} ${TMP+"TMP=$TMP"} ${TEMP+"TEMP=$TEMP"} ${GOTMPDIR+"GOTMPDIR=$GOTMPDIR"} ${TMUX+"TMUX=$TMUX"} ${TMUX_PANE+"TMUX_PANE=$TMUX_PANE"} ${HERDR_ENV+"HERDR_ENV=$HERDR_ENV"} ${HERDR_SESSION+"HERDR_SESSION=$HERDR_SESSION"} ${HERDR_SOCKET_PATH+"HERDR_SOCKET_PATH=$HERDR_SOCKET_PATH"} ${HERDR_PANE_ID+"HERDR_PANE_ID=$HERDR_PANE_ID"} ${CMUX_WORKSPACE_ID+"CMUX_WORKSPACE_ID=$CMUX_WORKSPACE_ID"} ${CMUX_SURFACE_ID+"CMUX_SURFACE_ID=$CMUX_SURFACE_ID"} ${CMUX_TAB_ID+"CMUX_TAB_ID=$CMUX_TAB_ID"} ${CMUX_PANEL_ID+"CMUX_PANEL_ID=$CMUX_PANEL_ID"} ${CMUX_SOCKET_PATH+"CMUX_SOCKET_PATH=$CMUX_SOCKET_PATH"} ${ZELLIJ+"ZELLIJ=$ZELLIJ"} ${ZELLIJ_SESSION_NAME+"ZELLIJ_SESSION_NAME=$ZELLIJ_SESSION_NAME"} ${ZELLIJ_PANE_ID+"ZELLIJ_PANE_ID=$ZELLIJ_PANE_ID"} ${FM_ZELLIJ_SESSION+"FM_ZELLIJ_SESSION=$FM_ZELLIJ_SESSION"} ${FM_TASK_ID+"FM_TASK_ID=$FM_TASK_ID"} ${FM_TEST_ALLOWED+"FM_TEST_ALLOWED=$FM_TEST_ALLOWED"} /bin/sh -c 'env -u CURSOR_AGENT -u CURSOR_INVOKED_AS -u GEMINI_CLI codex --dangerously-bypass-approvals-and-sandbox -c "notify=[\"bash\",\"-c\",\"touch '\''<tmp>/ship/home/state/ship-z1.turn-ended'\''\"]" "$('\''/Users/talon/.no-mistakes/worktrees/9b0bfac143a1/01M1WXEKZ6SED7F8CWQ95EZMSB/bin/fm-operational-input.sh'\'' encode launch-brief < '\''<tmp>/ship/home/data/ship-z1/launch-brief.md'\'')"'
   task record marker line: kind=ship 
   replaying the pane in /bin/sh (env -i HOME PATH TERM TMUX + FM_TEST_ALLOWED + an unrelated AMBIENT_SECRET):
     codex probe sees: FM_TASK_ID=ship-z1 GOTMPDIR=/tmp/fm-ship-z1/gotmp AMBIENT_SECRET=unset
   control: same replay WITHOUT the FM_TASK_ID export line (what a pre-fix spawn sent):
     codex probe sees: FM_TASK_ID=unset GOTMPDIR=/tmp/fm-ship-z1/gotmp AMBIENT_SECRET=unset

## ship spawn (trace context on): fm-spawn.sh shiptrace-z1
$ fm-spawn.sh shiptrace-z1 <tmp>/shiptrace/project --harness codex --backend tmux --mode no-mistakes --yolo off 
   > warning: <tmp>/shiptrace/home/data/shiptrace-z1/launch-brief.md records no delivery contract line (scaffolded before ship briefs recorded one); launching on the explicit --mode no-mistakes - confirm its definition of done matches
   > spawned shiptrace-z1 harness=codex kind=ship mode=no-mistakes yolo=off window=firstmate:fm-shiptrace-z1 worktree=<tmp>/shiptrace/wt
   spawn exit=0
   pane payloads in send order (fake tmux log):
          1	treehouse get
          2	export GOTMPDIR=/tmp/fm-shiptrace-z1/gotmp
          3	export FM_TASK_ID=shiptrace-z1
          4	export TRACEPARENT=00-e8b4ef02d5b11f612b19da68f849ef85-5cce89325e359f55-01
          5	/usr/bin/env -i ${HOME+"HOME=$HOME"} ${PATH+"PATH=$PATH"} ${USER+"USER=$USER"} ${LOGNAME+"LOGNAME=$LOGNAME"} ${SHELL+"SHELL=$SHELL"} ${TERM+"TERM=$TERM"} ${COLORTERM+"COLORTERM=$COLORTERM"} ${LANG+"LANG=$LANG"} ${LC_ALL+"LC_ALL=$LC_ALL"} ${LC_CTYPE+"LC_CTYPE=$LC_CTYPE"} ${TMPDIR+"TMPDIR=$TMPDIR"} ${TMP+"TMP=$TMP"} ${TEMP+"TEMP=$TEMP"} ${GOTMPDIR+"GOTMPDIR=$GOTMPDIR"} ${TMUX+"TMUX=$TMUX"} ${TMUX_PANE+"TMUX_PANE=$TMUX_PANE"} ${HERDR_ENV+"HERDR_ENV=$HERDR_ENV"} ${HERDR_SESSION+"HERDR_SESSION=$HERDR_SESSION"} ${HERDR_SOCKET_PATH+"HERDR_SOCKET_PATH=$HERDR_SOCKET_PATH"} ${HERDR_PANE_ID+"HERDR_PANE_ID=$HERDR_PANE_ID"} ${CMUX_WORKSPACE_ID+"CMUX_WORKSPACE_ID=$CMUX_WORKSPACE_ID"} ${CMUX_SURFACE_ID+"CMUX_SURFACE_ID=$CMUX_SURFACE_ID"} ${CMUX_TAB_ID+"CMUX_TAB_ID=$CMUX_TAB_ID"} ${CMUX_PANEL_ID+"CMUX_PANEL_ID=$CMUX_PANEL_ID"} ${CMUX_SOCKET_PATH+"CMUX_SOCKET_PATH=$CMUX_SOCKET_PATH"} ${ZELLIJ+"ZELLIJ=$ZELLIJ"} ${ZELLIJ_SESSION_NAME+"ZELLIJ_SESSION_NAME=$ZELLIJ_SESSION_NAME"} ${ZELLIJ_PANE_ID+"ZELLIJ_PANE_ID=$ZELLIJ_PANE_ID"} ${FM_ZELLIJ_SESSION+"FM_ZELLIJ_SESSION=$FM_ZELLIJ_SESSION"} ${FM_TASK_ID+"FM_TASK_ID=$FM_TASK_ID"} ${FM_TEST_ALLOWED+"FM_TEST_ALLOWED=$FM_TEST_ALLOWED"} ${TRACEPARENT+"TRACEPARENT=$TRACEPARENT"} /bin/sh -c 'env -u CURSOR_AGENT -u CURSOR_INVOKED_AS -u GEMINI_CLI codex --dangerously-bypass-approvals-and-sandbox -c "notify=[\"bash\",\"-c\",\"touch '\''<tmp>/shiptrace/home/state/shiptrace-z1.turn-ended'\''\"]" "$('\''/Users/talon/.no-mistakes/worktrees/9b0bfac143a1/01M1WXEKZ6SED7F8CWQ95EZMSB/bin/fm-operational-input.sh'\'' encode launch-brief < '\''<tmp>/shiptrace/home/data/shiptrace-z1/launch-brief.md'\'')"'
   task record marker line: kind=ship 
   replaying the pane in /bin/sh (env -i HOME PATH TERM TMUX + FM_TEST_ALLOWED + an unrelated AMBIENT_SECRET):
     codex probe sees: FM_TASK_ID=shiptrace-z1 GOTMPDIR=/tmp/fm-shiptrace-z1/gotmp AMBIENT_SECRET=unset
   control: same replay WITHOUT the FM_TASK_ID export line (what a pre-fix spawn sent):
     codex probe sees: FM_TASK_ID=unset GOTMPDIR=/tmp/fm-shiptrace-z1/gotmp AMBIENT_SECRET=unset

## scout spawn (trace context off): fm-spawn.sh scout-z1
$ fm-spawn.sh scout-z1 <tmp>/scout/project --harness codex --backend tmux --scout 
   > spawned scout-z1 harness=codex kind=scout window=firstmate:fm-scout-z1 worktree=<tmp>/scout/wt
   spawn exit=0
   pane payloads in send order (fake tmux log):
          1	treehouse get
          2	export GOTMPDIR=/tmp/fm-scout-z1/gotmp
          3	export FM_TASK_ID=scout-z1
          4	/usr/bin/env -i ${HOME+"HOME=$HOME"} ${PATH+"PATH=$PATH"} ${USER+"USER=$USER"} ${LOGNAME+"LOGNAME=$LOGNAME"} ${SHELL+"SHELL=$SHELL"} ${TERM+"TERM=$TERM"} ${COLORTERM+"COLORTERM=$COLORTERM"} ${LANG+"LANG=$LANG"} ${LC_ALL+"LC_ALL=$LC_ALL"} ${LC_CTYPE+"LC_CTYPE=$LC_CTYPE"} ${TMPDIR+"TMPDIR=$TMPDIR"} ${TMP+"TMP=$TMP"} ${TEMP+"TEMP=$TEMP"} ${GOTMPDIR+"GOTMPDIR=$GOTMPDIR"} ${TMUX+"TMUX=$TMUX"} ${TMUX_PANE+"TMUX_PANE=$TMUX_PANE"} ${HERDR_ENV+"HERDR_ENV=$HERDR_ENV"} ${HERDR_SESSION+"HERDR_SESSION=$HERDR_SESSION"} ${HERDR_SOCKET_PATH+"HERDR_SOCKET_PATH=$HERDR_SOCKET_PATH"} ${HERDR_PANE_ID+"HERDR_PANE_ID=$HERDR_PANE_ID"} ${CMUX_WORKSPACE_ID+"CMUX_WORKSPACE_ID=$CMUX_WORKSPACE_ID"} ${CMUX_SURFACE_ID+"CMUX_SURFACE_ID=$CMUX_SURFACE_ID"} ${CMUX_TAB_ID+"CMUX_TAB_ID=$CMUX_TAB_ID"} ${CMUX_PANEL_ID+"CMUX_PANEL_ID=$CMUX_PANEL_ID"} ${CMUX_SOCKET_PATH+"CMUX_SOCKET_PATH=$CMUX_SOCKET_PATH"} ${ZELLIJ+"ZELLIJ=$ZELLIJ"} ${ZELLIJ_SESSION_NAME+"ZELLIJ_SESSION_NAME=$ZELLIJ_SESSION_NAME"} ${ZELLIJ_PANE_ID+"ZELLIJ_PANE_ID=$ZELLIJ_PANE_ID"} ${FM_ZELLIJ_SESSION+"FM_ZELLIJ_SESSION=$FM_ZELLIJ_SESSION"} ${FM_TASK_ID+"FM_TASK_ID=$FM_TASK_ID"} ${FM_TEST_ALLOWED+"FM_TEST_ALLOWED=$FM_TEST_ALLOWED"} /bin/sh -c 'env -u CURSOR_AGENT -u CURSOR_INVOKED_AS -u GEMINI_CLI codex --dangerously-bypass-approvals-and-sandbox -c "notify=[\"bash\",\"-c\",\"touch '\''<tmp>/scout/home/state/scout-z1.turn-ended'\''\"]" "$('\''/Users/talon/.no-mistakes/worktrees/9b0bfac143a1/01M1WXEKZ6SED7F8CWQ95EZMSB/bin/fm-operational-input.sh'\'' encode launch-brief < '\''<tmp>/scout/home/data/scout-z1/launch-brief.md'\'')"'
   task record marker line: kind=scout 
   replaying the pane in /bin/sh (env -i HOME PATH TERM TMUX + FM_TEST_ALLOWED + an unrelated AMBIENT_SECRET):
     codex probe sees: FM_TASK_ID=scout-z1 GOTMPDIR=/tmp/fm-scout-z1/gotmp AMBIENT_SECRET=unset
   control: same replay WITHOUT the FM_TASK_ID export line (what a pre-fix spawn sent):
     codex probe sees: FM_TASK_ID=unset GOTMPDIR=/tmp/fm-scout-z1/gotmp AMBIENT_SECRET=unset

## secondmate spawn (trace context off): fm-spawn.sh sm-z1
$ fm-spawn.sh sm-z1 <tmp>/sm/secondmate-home --harness codex --backend tmux --secondmate 
   > warning: secondmate sm-z1 sync skipped before launch: primary default-branch commit cannot be resolved
   > spawned sm-z1 harness=codex kind=secondmate mode=secondmate yolo=off window=firstmate:fm-sm-z1 worktree=<tmp>/sm/secondmate-home
   spawn exit=0
   pane payloads in send order (fake tmux log):
          1	export GOTMPDIR=/tmp/fm-sm-z1/gotmp
          2	/usr/bin/env -i ${HOME+"HOME=$HOME"} ${PATH+"PATH=$PATH"} ${USER+"USER=$USER"} ${LOGNAME+"LOGNAME=$LOGNAME"} ${SHELL+"SHELL=$SHELL"} ${TERM+"TERM=$TERM"} ${COLORTERM+"COLORTERM=$COLORTERM"} ${LANG+"LANG=$LANG"} ${LC_ALL+"LC_ALL=$LC_ALL"} ${LC_CTYPE+"LC_CTYPE=$LC_CTYPE"} ${TMPDIR+"TMPDIR=$TMPDIR"} ${TMP+"TMP=$TMP"} ${TEMP+"TEMP=$TEMP"} ${GOTMPDIR+"GOTMPDIR=$GOTMPDIR"} ${TMUX+"TMUX=$TMUX"} ${TMUX_PANE+"TMUX_PANE=$TMUX_PANE"} ${HERDR_ENV+"HERDR_ENV=$HERDR_ENV"} ${HERDR_SESSION+"HERDR_SESSION=$HERDR_SESSION"} ${HERDR_SOCKET_PATH+"HERDR_SOCKET_PATH=$HERDR_SOCKET_PATH"} ${HERDR_PANE_ID+"HERDR_PANE_ID=$HERDR_PANE_ID"} ${CMUX_WORKSPACE_ID+"CMUX_WORKSPACE_ID=$CMUX_WORKSPACE_ID"} ${CMUX_SURFACE_ID+"CMUX_SURFACE_ID=$CMUX_SURFACE_ID"} ${CMUX_TAB_ID+"CMUX_TAB_ID=$CMUX_TAB_ID"} ${CMUX_PANEL_ID+"CMUX_PANEL_ID=$CMUX_PANEL_ID"} ${CMUX_SOCKET_PATH+"CMUX_SOCKET_PATH=$CMUX_SOCKET_PATH"} ${ZELLIJ+"ZELLIJ=$ZELLIJ"} ${ZELLIJ_SESSION_NAME+"ZELLIJ_SESSION_NAME=$ZELLIJ_SESSION_NAME"} ${ZELLIJ_PANE_ID+"ZELLIJ_PANE_ID=$ZELLIJ_PANE_ID"} ${FM_ZELLIJ_SESSION+"FM_ZELLIJ_SESSION=$FM_ZELLIJ_SESSION"} ${FM_TASK_ID+"FM_TASK_ID=$FM_TASK_ID"} ${FM_TEST_ALLOWED+"FM_TEST_ALLOWED=$FM_TEST_ALLOWED"} /bin/sh -c 'FM_ROOT_OVERRIDE= FM_STATE_OVERRIDE= FM_DATA_OVERRIDE= FM_PROJECTS_OVERRIDE= FM_CONFIG_OVERRIDE= FM_PUBLIC_FOLLOWUP_PRIMARY_HOME='\''<tmp>/sm/home'\'' FM_HOME='\''<tmp>/sm/secondmate-home'\'' FM_TRACE_CONTEXT=off FM_SUPERVISION_MODEL=persistent env -u CURSOR_AGENT -u CURSOR_INVOKED_AS -u GEMINI_CLI codex --dangerously-bypass-approvals-and-sandbox "$('\''/Users/talon/.no-mistakes/worktrees/9b0bfac143a1/01M1WXEKZ6SED7F8CWQ95EZMSB/bin/fm-operational-input.sh'\'' encode launch-brief < '\''<tmp>/sm/secondmate-home/data/charter.md'\'')"'
   task record marker line: kind=secondmate 
