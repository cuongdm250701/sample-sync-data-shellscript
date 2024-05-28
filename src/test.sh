
source $(dirname "$0")/../connect-db.sh
connection_db

TABLE_NAME="monthly_holiday"

echo "store_code,type,year,january,february,march,april,may,june,july,august,september,october,november,december,created_at,updated_at" > "$(dirname "$0")/../output/monthly-holiday/test.csv"

csv_files=$(ls $(dirname "$0")/../master-data/monthly-holiday/)
current_year=$(date +'%Y')

for csv_file in $csv_files; do
  echo "Processing file: $csv_file"
  store_code=$(echo "$csv_file" | sed 's/_.*//')
  type=1
  while IFS=',' read -r col1 january february march april may june july august september october november december
  do
     store_code="$store_code"
     type="$type"
     year="$current_year"
     january="$january"
     february="$february"
     march="$march"
     april="$april"
     may="$may"
     june="$june"
     july="$july"
     august="$august"
     september="$september"
     october="$october"
     november="$november"
     december="$december"
     created_at='2024-05-29'
     updated_at='2024-05-29'
     echo "$store_code,$type,$year,$january,$february,$march,$april,$may,$june,$july,$august,$september,$october,$november,$december,$created_at,$updated_at">>"$(dirname "$0")/../output/monthly-holiday/test.csv"
  ((type++)) 
  done < <(tail -n +2 "$(dirname "$0")/../master-data/monthly-holiday/$csv_file")
done



psql -h "${database_host}" -p "${database_port}" -d "${database_name}" -U "${database_user}" -c "\COPY $TABLE_NAME FROM '$(dirname "$0")/../output/monthly-holiday/test.csv' delimiter ',' csv header;"

