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

# Test function
# year=2025
# month=1
# target_day=1
# target_week=2

# get_date=$(getDate $year $month $target_day $target_week)
# echo "$get_date"


### DOING ###
current_year=$(date +'%Y')
### Type holiday ###
TYPE_HOLIDAY_1='祝日'
TYPE_HOLIDAY_2='行事'
### Name table ###
TABLE_NAME='public_holiday'
### List columns in database's table ###
columns="id,type,date,month,year,event_details,holiday,store_code,created_at,updated_at"
### Create file contain store's list data monthly ### 
path="$(dirname "$0")/../output/public-holiday.csv"
echo "${columns}" > "${path}"
### Handle get data ###
csv_files=$(ls $(dirname "$0")/../master-data/public-holiday/)
for csv_file in $csv_files; do
  echo "Processing file: $csv_file"
  store_code=$(echo "$csv_file" | sed 's/_.*//')
  # echo "$store_code"
  while IFS=',' read -r type_holiday month_holiday date_holiday event_details_holiday
  do
      # GET "$type_holiday"
      if [ $type_holiday = $TYPE_HOLIDAY_1 ]; then
        type=1
      elif [ $type_holiday = $TYPE_HOLIDAY_2 ]; then
        type=2
      fi
      # GET MONTH
       month=$(echo "$month_holiday" | sed 's/月//')
      #  echo "$month"
      # GET DATE
      case "${date_holiday}_${month_holiday}" in 
        "第２月曜日_１月") date=$(getDate $current_year 1 1 2);; # echo "thứ 2 tuần thứ 2 tháng 1"
        "第２日曜日_５月") date=$(getDate $current_year 5 0 2);; # echo "chủ nhật tuần thứ 2 tháng 5"
        "第３日曜日_６月") date=$(getDate $current_year 6 0 3);; # echo "chủ nhật tuần thứ 3 tháng 6"
        "第３月曜日_７月") date=$(getDate $current_year 7 1 3);; # echo "thứ 2 tuần thứ 3 tháng 7"
        "第３月曜日_９月") date=$(getDate $current_year 9 1 3);; # echo "thứ 2 tuần thứ 3 tháng 9"
        "第２月曜日_１０月") date=$(getDate $current_year 10 1 2);; # echo "thứ 2 tuần thứ 2 tháng 10"
        *)
        echo "$date_holiday" | sed 's/日//';;
      esac
      ## Hanlde Synthetic data write to csv
      ## doing something ....##
  done < <(iconv -f SHIFT-JIS -t UTF-8 "$(dirname "$0")/../master-data/public-holiday/$csv_file" | tail -n +2)
done
