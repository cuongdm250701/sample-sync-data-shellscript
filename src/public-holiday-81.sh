#!/bin/bash
# source $(dirname "$0")/../connect-db.sh
# connection_db

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

get_date=$(getDate $year $month $target_day $target_week)
echo "$get_date"




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

### DOING ###
### Type holiday ###
TYPE_HOLIDAY_1='祝日'
TYPE_HOLIDAY_2='行事'
### Name table ###
TABLE_NAME='public_holiday'
### List columns in database's table ###
columns="id,type,date,month,year,event_details,holiday,store_code,created_at,updated_at"
### Create file contain store's list data monthly ### 
path="$(dirname "$0")/../output/public-holiday/test.csv"
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
      # if [ $type_holiday = $TYPE_HOLIDAY_1 ]; then
      #   echo "1"
      # elif [ $type_holiday = $TYPE_HOLIDAY_2 ]; then
      #   echo "2"
      # fi
      # GET MONTH
       month=$(echo "$month_holiday" | sed 's/月//')
      #  echo "$month"
      # GET DATE
      case "${date_holiday}_${month_holiday}" in 
        "第２月曜日_１月") echo "thứ 2 tuần thứ 2 tháng 1";;
        "第２日曜日_５月") echo "chủ nhật tuần thứ 2 tháng 5";;
        "第３日曜日_６月") echo "chủ nhật tuần thứ 3 tháng 6";;
        "第３月曜日_７月") echo "thứ 2 tuần thứ 3 tháng 7";;
        "第３月曜日_９月") echo "thứ 2 tuần thứ 3 tháng 9";;
        "第２月曜日_１０月") echo "thứ 2 tuần thứ 2 tháng 10";;
        *)
        echo "$date_holiday" | sed 's/日//';;
      esac
  done < <(iconv -f SHIFT-JIS -t UTF-8 "$(dirname "$0")/../master-data/public-holiday/$csv_file" | tail -n +2)
done


## Hoir laij case ngay va thang o file 283