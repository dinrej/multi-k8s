docker build -t dinrej/multi-client:latest -t  dinrej/multi-client:$SHA -f ./client
docker build -t dinrej/multi-server:latest -t  dinrej/multi-server:$SHA -f ./server
docker build -t dinrej/multi-worker:latest -t  dinrej/multi-worker:$SHA -f ./worker

docker push dinrej/multi-client:latest
docker push dinrej/multi-server:latest
docker push dinrej/multi-worker:latest
docker push dinrej/multi-client:$SHA
docker push dinrej/multi-server:$SHA
docker push dinrej/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dinrej/multi-server:$SHA
kubectl set image deployments/client-deployment client=dinrej/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dinrej/multi-server:$SHA

