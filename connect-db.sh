#!/bin/bash

connection_db() {
      database_password='cuongdm250701'
      database_port=5432
      database_host='localhost'
      database_user='postgres'
      database_name='kasumi'

      # setting password
      export PGPASSWORD=${database_password}

      # excute connection
      query=$(psql -h ${database_host} -U ${database_user} -p ${database_port} -d ${database_name} -c "select 1;" 2>/dev/null)

      # Check connection
      if [ $? -eq 0 ]; then
            echo "Connect database ok"
      else
            echo "Connect database fail"
      fi
}
