kubectl apply -f mysql.yaml

kubectl exec -it mysql-0 -- /bin/bash -c 'mysql -u root  -p'
