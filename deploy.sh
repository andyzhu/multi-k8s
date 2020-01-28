docker build -t awesomens/multi-k8s-client:latest -t awesomens/multi-k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t awesomens/multi-k8s-server:latest -t awesomens/multi-k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t awesomens/multi-k8s-worker:latest -t awesomens/multi-k8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push awesomens/multi-k8s-client:latest
docker push awesomens/multi-k8s-client:$SHA
docker push awesomens/multi-k8s-server:latest
docker push awesomens/multi-k8s-server:$SHA
docker push awesomens/multi-k8s-worker:latest
docker push awesomens/multi-k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=awesomens/multi-k8s-server:$SHA
kubectl set image deployments/client-deployment client=awesomens/multi-k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=awesomens/multi-k8s-worker:$SHA