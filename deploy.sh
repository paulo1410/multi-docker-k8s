docker build -t paulo1410/multi-client:latest -t paulo1410/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paulo1410/multi-server:latest -t paulo1410/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paulo1410/multi-worker:latest -t paulo1410/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paulo1410/multi-client:latest
docker push paulo1410/multi-server:latest
docker push paulo1410/multi-worker:latest

docker push paulo1410/multi-client:$SHA
docker push paulo1410/multi-server:$SHA
docker push paulo1410/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=paulo1410/multi-server:$SHA
kubectl set image deployments/client-deployment client=paulo1410/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paulo1410/multi-worker:$SHA
