docker build -t cygnetops/multi-client:latest -t cygnetops/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cygnetops/multi-server-10-14-22:latest -t cygnetops/multi-server-10-14-22:$SHA ./server/Dockerfile ./server
docker build -t cygnetops/multi-worker-10-14-22:latest -t cygnetops/multi-worker-10-14-22:$SHA ./worker/Dockerfile ./worker
docker push cygnetops/multi-client:latest
docker push cygnetops/multi-server-10-14-22:latest
docker push cygnetops/multi-worker-10-14-22:latest

docker push cygnetops/multi-client:$SHA
docker push cygnetops/multi-server-10-14-22:$SHA
docker push cygnetops/multi-worker-10-14-22:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=cygnetops/multi-server-10-14-22:$SHA
kubectl set image deployment/client-deployment client=cygnetops/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=cygnetops/multi-worker-10-14-22:$SHA

