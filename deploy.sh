docker build -t awilderink/multi-client:latest -t awilderink/multi-client:$COMMIT -f ./client/Dockerfile ./client
docker build -t awilderink/multi-server:latest -t awilderink/multi-server:$COMMIT -f ./server/Dockerfile ./server
docker build -t awilderink/multi-worker:latest -t awilderink/multi-worker:$COMMIT -f ./worker/Dockerfile ./worker

docker push awilderink/multi-client:latest
docker push awilderink/multi-server:latest
docker push awilderink/multi-worker:latest

docker push awilderink/multi-client:$COMMIT
docker push awilderink/multi-server:$COMMIT
docker push awilderink/multi-worker:$COMMIT

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=awilderink/multi-client:$COMMIT
kubectl set image deployments/server-deployment server=awilderink/multi-server:$COMMIT
kubectl set image deployments/worker-deployment worker=awilderink/multi-worker:$COMMIT