#!/bin/bash

# source $(dirname "$0")/../connect-db.sh
# connection_db

# TABLE_NAME="monthly_holiday"

# echo "store_code,type,year,january,february,march,april,may,june,july,august,september,october,november,december,created_at,updated_at" > "$(dirname "$0")/../output/monthly-holiday/test.csv"

# csv_files=$(ls $(dirname "$0")/../master-data/monthly-holiday/)
# current_year=$(date +'%Y')
# created_at=$(date +'%Y-%m-%d')

# for csv_file in $csv_files; do
#   echo "Processing file: $csv_file"
#   store_code=$(echo "$csv_file" | sed 's/_.*//')
#   type=1
#   while IFS=',' read -r label january february march april may june july august september october november december
#   do
#     DATA="$store_code,$type,$current_year,$january,$february,$march,$april,$may,$june,$july,$august,$september,$october,$november,$december"
#     ITEM1="${DATA},$created_at,$created_at"
#     echo ${ITEM1} | tr -d '\r' >>"$(dirname "$0")/../output/monthly-holiday/test.csv"
#   ((type++)) 
#   done < <(tail -n +2 "$(dirname "$0")/../master-data/monthly-holiday/$csv_file")
# done
# # wait

# # ITEM1="${ITEM},123,456"
# # echo ${ITEM1} | tr -d '\r'

# psql -h "${database_host}" -p "${database_port}" -d "${database_name}" -U "${database_user}" -c "\COPY $TABLE_NAME FROM '$(dirname "$0")/../output/monthly-holiday/test.csv' delimiter ',' csv header;"


######## DOING PUBLIC HOLIDAY ###########


source $(dirname "$0")/../connect-db.sh
connection_db

HOLIDAY_MONTH_1_6="第２月曜日"
HOLIDAY_MONTH_5="第２日曜日"
HOLIDAY_MONTH_6="第３日曜日"
HOLIDAY_MONTH_7_9="第３月曜日"

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
# FRUIT="kiwi"

# case "$FRUIT" in
#    "apple") echo "Apple pie is quite tasty." 
#    ;;
#    "banana") echo "I like banana nut bread." 
#    ;;
#    "kiwi") echo "New Zealand is famous for kiwi." 
#    ;;
# esac

HOLIDAY=${HOLIDAY_MONTH_5}
case "$HOLIDAY" in "第２日曜日") echo "apple is tasty";;
"banana") echo "I like banana";;
"kiwi") echo "Newzeland is famous for kiwi";;
*)
echo "default case";;
esac