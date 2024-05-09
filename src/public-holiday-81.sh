#!/bin/bash
source $(dirname "$0")/../connect-db.sh
connection_db

getDate() {
  local year=$1
  local month=$2
  local target_day=$3
  local target_week=$4

  first_day_of_month=$(date -d "$year-$month-01" +%u)
  offset=$((target_day - first_day_of_month))
  if [ $offset -lt 0 ]; then
    offset=$((offset + 7))
  fi
  target_date=$((1 + offset + (target_week - 1) * 7))

  echo "$target_date"
}

# Run function
year=2024
month=10
target_day=1
target_week=2

getDate $year $month $target_day $target_week




# holiday='祝日'
# while IFS=',' read -r col1 col2 col3 col4
  # do
    ####### Handle get type holiday #######
    # if [ $col1 = $holiday ]; then
    #   echo "1"
    # else
    #   echo "2"
    # fi

    ###### Handle get month #########
    # month=$(echo "$col2" | sed 's/月//')
    # echo "$month"

    ##### Handle get day ######

# done < <(tail -n +2 "$(dirname "$0")/../master-data/public-holiday/171_MD1.csv" | iconv -f SHIFT-JIS -t UTF-8)


######################### SWITCH CASE ################################
############ Use for generate date holiday ####################
# fruit = "kiwi"
# case $"fruit" in "apple") echo "apple is tasty";;
# "banana") echo "I like banana";;
# "kiwi") echo "Newzeland is famous for kiwi";;
# *)
# echo "default case";;
# esac
