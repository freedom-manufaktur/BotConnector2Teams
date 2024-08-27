#              ReleaseName
helm uninstall bot-connector-to-teams
kubectl delete -n default pod bot-connector-to-teams-bot-connector-to-teams-test-connection --ignore-not-found=true