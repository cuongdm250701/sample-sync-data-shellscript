#!/bin/bash

### Test connection database ###
source $(dirname "$0")/../connect-db.sh
connection_db

### Name table ###
TABLE_NAME="monthly_holiday"
### List columns in database's table ###
columns="store_code,type,year,january,february,march,april,may,june,july,august,september,october,november,december,created_at,updated_at"
### Create file contain store's list data monthly ### 
path="$(dirname "$0")/../output/monthly-holiday/monthly-holiday.csv"
echo "${columns}" > "${path}"
### Handle get data synthesis to file monthly-holiday.csv ###
csv_files=$(ls $(dirname "$0")/../master-data/monthly-holiday/)
current_year=$(date +'%Y')
date_time=$(date +'%Y-%m-%d')
for csv_file in $csv_files; do
  echo "Processing file: $csv_file"
  store_code=$(echo "$csv_file" | sed 's/_.*//')
  type=1
  while IFS=',' read -r label january february march april may june july august september october november december
  do
    DATA_CSV="$store_code,$type,$current_year,$january,$february,$march,$april,$may,$june,$july,$august,$september,$october,$november,$december"
    DATA_INSERT="${DATA_CSV},$date_time,$date_time"
    echo ${DATA_INSERT} | tr -d '\r' >>"$(dirname "$0")/../output/monthly-holiday/monthly-holiday.csv"
  ((type++)) 
  done < <(tail -n +2 "$(dirname "$0")/../master-data/monthly-holiday/$csv_file")
done

### Copy data to file monthly-holiday.csv from database ###
psql -h "${database_host}" -p "${database_port}" -d "${database_name}" -U "${database_user}" -c "\COPY $TABLE_NAME FROM '${path}' delimiter ',' csv header;"

