#!/bin/bash

if [[ "$1" == "-l" ]]; then
  echo "
                                          Incident | #INC
              Request (Service Request/Work Order) | #REQ
                                 Change (CRQ work) | #CRQ
                                 Problem (PBI/PKE) | #PBI
               Major Incident/Command Center Calls | #CCC
                                          Training | #TRA
 Other Activities/Shoulder Taps/Specify in Remarks | #OTH
                 Monitor/Health Check/Call Support | #MON
               Email Support/Miscellaneious emails | #EML
           Automation/scripting Specify in remarks | #SCR
                                           Reports | #RPT
                                 Customer Meetings | #CST
                                  Team Meetings/HR | #TCS
                                          PTO/Sick | #PTO
"
  exit
fi

num_entered_today=$(task "$(date +%Y-%m-%d) -- Daily Entries Added" count 2>/dev/null)
if [[ $num_entered_today -eq 0 ]]; then
    id=$(task add "$(date +%Y-%m-%d) - Daily Entries Added" | grep -Po '\d+')
    task $id done
    task add proj:org.time pri:H eff:1 unt:sched+4h "$(date +%Y-%m-%d) - Take Blood Pressure"
    task add proj:org.time pri:H eff: 5 unt:sched+12h +TOD "$(date +%Y-%m-%d) - Enter timesheet"
    task add proj:org.DR pri:H eff:1 unt:sched+4h +TOD "$(date +%Y-%m-%d) - Add today's non-recurring meetings to task list"
    task add proj:org.email pri:H unt:sched+8h +TOD "Review TCS Email"
    task add proj:org.DR eff:5 unt:sched+8h "Review WAITING taks. Have any blockers cleared?"
    task add proj:org.DR eff:5 unt:sched+8h "Assign proper projects to anything in the inbox"
    task add proj:org.DR eff:1 unt:sched+8h "Review \"On My Radar\" list"
    task add proj:org.DR eff:1 unt:sched+8h "$(date +%Y-%m-%d) - Transfer notes from phone list"
    task add +\#EML proj:org.email sched:sod+8h unt:sched+8h "$(date +%Y-%m-%d) - Email 0"
else
    echo "Already added today"
fi
