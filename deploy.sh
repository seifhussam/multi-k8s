docker build -t seifhussam/multi-client:latest -t seifhussam/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t seifhussam/multi-server:latest -t seifhussam/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t seifhussam/multi-worker:latest -t seifhussam/multi-worker:$SHA -f ./worker/Dockerfile ./worker  
docker push seifhussam/multi-client:latest
docker push seifhussam/multi-server:latest
docker push seifhussam/multi-worker:latest
docker push seifhussam/multi-client:$SHA
docker push seifhussam/multi-server:$SHA
docker push seifhussam/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=seifhussam/multi-server:$SHA 
kubectl set image deployments/client-deployment client=seifhussam/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=seifhussam/multi-worker:$SHA 