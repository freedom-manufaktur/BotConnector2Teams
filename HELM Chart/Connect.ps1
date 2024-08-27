#                                                                           ReleaseName                             ReleaseName
$POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=bot-connector-to-teams,app.kubernetes.io/instance=bot-connector-to-teams" -o jsonpath="{.items[0].metadata.name}")
$CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
echo "Application:  http://localhost:8100"
echo "Health check: http://localhost:8100/healthcheck"
kubectl --namespace default port-forward $POD_NAME 8100:$CONTAINER_PORT