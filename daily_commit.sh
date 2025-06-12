#!/bin/bash

cd /home/sagittarius/daily-commits || exit

echo "Crono reporting for duty at $(date '+%Y-%m-%d %H:%M:%S')" >> crono.log

# Your GitHub identity
export GIT_AUTHOR_NAME="ibish23"
export GIT_COMMITTER_NAME="ibish23"
export GIT_AUTHOR_EMAIL="oluwatobiibraheem262@gmail.com"
export GIT_COMMITTER_EMAIL="oluwatobiibraheem262@gmail.com"

# TODAY
today=$(date +%Y-%m-%d)

# Last commit date
last_commit=$(git log -1 --format=%cd --date=format:'%Y-%m-%d')

if [ -z "$last_commit" ]; then
  last_commit="$today"
fi

# Loop from day after last commit to today
current_date=$(date -I -d "$last_commit + 1 day")
while [ "$current_date" \< "$today" ] || [ "$current_date" = "$today" ]; do
  echo "Backfilling commit for $current_date" >> crono.log
  echo "Committed on $current_date" >> daily-log.txt

  GIT_AUTHOR_DATE="$current_date 09:00:00" \
  GIT_COMMITTER_DATE="$current_date 09:00:00" \
  git commit -a -m "Backfilled commit for $current_date" --quiet

  current_date=$(date -I -d "$current_date + 1 day")
done

git push origin main

