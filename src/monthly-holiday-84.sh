#!/bin/bash

source $(dirname "$0")/../connect-db.sh
connection_db

###### DOING #######
csv_files=$(ls $(dirname "$0")/../master-data/monthly-holiday/)
current_year=$(date +'%Y')

for csv_file in $csv_files; do
  echo "Processing file: $csv_file"
  store_code=$(echo "$csv_file" | sed 's/_.*//')
  type=1
  while IFS=',' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13
  do
     psql -h ${database_host} -U ${database_user} -p ${database_port} -d ${database_name} -c "
        INSERT INTO monthly_holiday 
            (store_code, type, year, january, february, march, april, may, june, july, august, september, october, november, december) 
        VALUES 
            ('$store_code', '$type', '$current_year', '$col2', '$col3', '$col4', '$col5', '$col6', '$col7', '$col8', '$col9', '$col10',
              '$col11', '$col12', '$col13'
            );
        "
  ((type++)) 
  done < <(tail -n +2 "$(dirname "$0")/../master-data/monthly-holiday/$csv_file")
done
##### DOING #######
