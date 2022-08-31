docker build -t kuberizal/multi-client:latest -t kuberizal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kuberizal/multi-server:latest -t kuberizal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kuberizal/multi-worker:latest -t kuberizal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kuberizal/multi-client:latest
docker push kuberizal/multi-server:latest
docker push kuberizal/multi-worker:latest

docker push kuberizal/multi-client:$SHA
docker push kuberizal/multi-server:$SHA
docker push kuberizal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kuberizal/multi-server:$SHA
kubectl set image deployments/client-deployment client=kuberizal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kuberizal/multi-worker:$SHA
