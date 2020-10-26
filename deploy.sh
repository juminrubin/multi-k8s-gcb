docker build -t jr17/multi-client:latest -t jr17/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jr17/multi-server:latest -t jr17/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jr17/multi-worker:latest -t jr17/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jr17/multi-client:latest
docker push jr17/multi-server:latest
docker push jr17/multi-worker:latest

docker push jr17/multi-client:$SHA
docker push jr17/multi-server:$SHA
docker push jr17/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jr17/multi-client:$SHA
kubectl set image deployments/server-deployment server=jr17/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jr17/multi-worker:$SHA
