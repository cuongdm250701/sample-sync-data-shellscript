
source $(dirname "$0")/../connect-db.sh
connection_db

TABLE_NAME="monthly_holiday"

echo "store_code,type,year,january,february,march,april,may,june,july,august,september,october,november,december,created_at,updated_at" > "$(dirname "$0")/../output/monthly-holiday/test.csv"

csv_files=$(ls $(dirname "$0")/../master-data/monthly-holiday/)
current_year=$(date +'%Y')
created_at=$(date +'%Y-%m-%d')

for csv_file in $csv_files; do
  echo "Processing file: $csv_file"
  store_code=$(echo "$csv_file" | sed 's/_.*//')
  type=1
  while IFS=',' read -r label january february march april may june july august september october november december
  do
    DATA="$store_code,$type,$current_year,$january,$february,$march,$april,$may,$june,$july,$august,$september,$october,$november,$december"
    ITEM1="${DATA},$created_at,$created_at"
    echo ${ITEM1} | tr -d '\r' >>"$(dirname "$0")/../output/monthly-holiday/test.csv"
  ((type++)) 
  done < <(tail -n +2 "$(dirname "$0")/../master-data/monthly-holiday/$csv_file")
done
# wait

# ITEM1="${ITEM},123,456"
# echo ${ITEM1} | tr -d '\r'

psql -h "${database_host}" -p "${database_port}" -d "${database_name}" -U "${database_user}" -c "\COPY $TABLE_NAME FROM '$(dirname "$0")/../output/monthly-holiday/test.csv' delimiter ',' csv header;"

