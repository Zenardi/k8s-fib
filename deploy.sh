docker build -t eduardozenardi/multi-client:latest -t eduardozenardi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eduardozenardi/multi-server:latest -t eduardozenardi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eduardozenardi/multi-worker:latest -t eduardozenardi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eduardozenardi/multi-client:latest
docker push eduardozenardi/multi-server:latest
docker push eduardozenardi/multi-worker:latest

docker push eduardozenardi/multi-client:$SHA
docker push eduardozenardi/multi-server:$SHA
docker push eduardozenardi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eduardozenardi/multi-server:$SHA
kubectl set image deployments/client-deployment client=eduardozenardi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eduardozenardi/multi-worker:$SHA