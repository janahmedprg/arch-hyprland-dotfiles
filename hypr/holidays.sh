#!/bin/bash

ICS_URL="<add_your_url>"

now_epoch=$(date +%s)
one_month_epoch=$(date -d "+1 month" +%s)

# Parse ICS, convert to epoch, include all-day handling
events=$(curl -s "$ICS_URL" |
awk '
BEGIN { in_event=0 }
/^BEGIN:VEVENT/ { in_event=1; summary=""; start=""; allday=0 }
/^END:VEVENT/ {
  if (start != "" && summary != "") {
    print start "|" summary "|" allday
  }
  in_event=0
}
in_event && /^DTSTART/ {
  if ($0 ~ /VALUE=DATE/) {
    gsub(/DTSTART;VALUE=DATE:/, "")
    start=$0 "T000000"
    allday=1
  } else {
    sub(/DTSTART[^:]*:/, "")
    start=$0
  }
}
in_event && /^SUMMARY/ {
  sub(/SUMMARY:/, "")
  summary=$0
}
' |
while IFS="|" read -r dt title allday; do
  epoch=$(date -d "${dt:0:8} ${dt:9:2}:${dt:11:2}" +%s 2>/dev/null)
  [ -n "$epoch" ] && echo "$epoch|$dt|$title|$allday"
done |
sort -n |
awk -v now="$now_epoch" -v limit="$one_month_epoch" -F"|" '$1 >= now && $1 <= limit' |
head -n 3
)

if [ -z "$events" ]; then
  echo "📅 No upcoming holidays"
else
  echo "$events" |
  while IFS="|" read -r epoch dt title allday; do
    if [ "$allday" = "1" ]; then
      time=$(date -d "${dt:0:8}" +"%a (All day)")
    else
      time=$(date -d "${dt:0:8} ${dt:9:2}:${dt:11:2}" +"%a %H:%M")
    fi
    echo "📅 $time — $title"
  done
fi
