kubectl apply -f mysql.yaml

kubectl exec -it mysql-0 -- /bin/bash -c 'mysql -u root  -p'

CREATE USER 'temporal' IDENTIFIED BY 'temporal.123';

grant all privileges on *.* to 'temporal'@'%' with grant option;

kubectl -n namespace exec -i my_sql_pod_name -- mysql -u user -ppassword < my_local_dump.sql

create database temporal;

create database temporal_visibility;

