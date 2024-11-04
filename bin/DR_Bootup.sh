#!/bin/bash

id=$(task add +b.CST_MTG proj:mtg.cust.nucleus.blocker sched:sod+8.5h unt:sched+1h "$(date +%Y-%m-%d) - Nucleus Blocker" | grep -Po '\d+')
task add proj:org.time eff:1m depends:$id "$(date +%Y-%m-%d) - Nucleus Blocker INC"
task add +b.CST_MTG proj:mtg.cust.jtf sched:sod+10.75h unt:sched+1h "$(date +%Y-%m-%d) - JTF"
id=$(task add +b.CST_MTG proj:mtg.cust.nucleus.scrum sched:sod+13h unt:sched+1h "$(date +%Y-%m-%d) - Nucleus Scrum" | grep -Po '\d+')
task add proj:org.time eff:1m depends:$id "$(date +%Y-%m-%d) - Nucleus Scrum INC"
task add proj:org.time eff: 5m sched:sod+8h unt:sched+12h "$(date +%Y-%m-%d) - Enter timesheet"
task add proj:org.DR eff:1m sched:sod+8h unt:sched+8h "$(date +%Y-%m-%d) - Add all other meetings to task list"
task add proj:org.DR eff:5m sched:sod+8h unt:sched+8h "Review WAITING taks. Have any blockers cleared?"
task add proj:org.DR eff:5m sched:sod+8h unt:sched+8h "Assign proper projects to anything in the inbox"
task add proj:org.DR eff:1m sched:sod+8h unt:sched+8h "Review \"On My Radar\" list"
task add proj:org.DR eff:1m sched:sod+8h unt:sched+8h "$(date +%Y-%m-%d) - Transfer notes from phone list"
task add +b.RPTS proj:org.DR eff:30m sched:sod+8h unt:sched+8h "$(date +%Y-%m-%d) - Daily Review"
task add proj:org.email sched:sod+8h unt:sched+8h "Review TCS Email"
task add +b.EMAIL proj:org.email sched:sod+8h unt:sched+8h "$(date +%Y-%m-%d) - Email 0"
