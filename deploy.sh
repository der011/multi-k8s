docker build -t der011/multi-client:latest -t der011/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t der011/multi-server:latest -t der011/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t der011/multi-worker:latest -t der011/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push der011/multi-client:latest
docker push der011/multi-server:latest
docker push der011/multi-worker:latest

docker push der011/multi-client:$SHA
docker push der011/multi-server:$SHA
docker push der011/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=der011/multi-client:$SHA
kubectl set image deployments/server-deployment server=der011/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=der011/multi-worker:$SHA


