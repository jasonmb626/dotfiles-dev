#!/bin/bash

task add proj:meeting.cust_meeting.nucleus.blocker sched:sod+8.5h unt:sched+1h $(date +%Y-%m-%d) - Nucleus Blocker
task add proj:org.time sched:sod+9h $(date +%Y-%m-%d) - Nucleus Blocker INC
task add proj:meeting.cust_meeting.jtf sched:sod+10.75h unt:sched+1h $(date +%Y-%m-%d) - JTF
task add proj:meeting.cust_meeting.nucleus.scrum sched:sod+13h unt:sched+1h $(date +%Y-%m-%d) - Nucleus Scrum
task add proj:org.time sched:sod+13.5h $(date +%Y-%m-%d) - Nucleus Scrum INC
task add proj:org.time sched:sod+8h unt:sched+12h $(date +%Y-%m-%d) - Enter timesheet
id=$(task add proj:org.task_management sched:sod+8h unt:sched+8h $(date +%Y-%m-%d) - Add all other meetings to task list | grep -Po '\d+')
dep_ids="$id"
id=$(task add proj:org.task_management sched:sod+8h unt:sched+8h Review BLOCKED taks. Have any blockers cleared? | grep -Po '\d+')
dep_ids="$dep_ids,$id"
id=$(task add proj:org.task_management sched:sod+8h unt:sched+8h Assign proper projects to anything in the inbox | grep -Po '\d+')
dep_ids="$dep_ids,$id"
id=$(task add proj:org.task_management sched:sod+8h unt:sched+8h Review "On My Radar" list | grep -Po '\d+')
dep_ids="$dep_ids,$id"
id=$(task add proj:org.task_management sched:sod+8h unt:sched+8h Choose top 3 projects for the day | grep -Po '\d+')
dep_ids="$dep_ids,$id"
task add proj:org.task_management sched:sod+8h unt:sched+8h dep:$dep_ids $(date +%Y-%m-%d) - Daily taks review | grep -Po '\d+'
task add proj:org.email sched:sod+8h unt:sched+8h $(date +%Y-%m-%d) - Email 0
