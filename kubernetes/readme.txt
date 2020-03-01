to deploy the docker images stored in the container repostory( in this case Docker hub) run the configurations like this:

kubectl apply -f .
      (or)
kubectl apply -f ./deployment.yaml

kubectl apply -f ./services.yaml

now, container is deployed in kubernetes cluster and a load balancer is created, so that the application can be accessed through web.
