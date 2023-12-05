# Install HELM https://helm.sh/docs/intro/install/
winget install helm.helm

# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
# ■ Deploy and test application ■

#            ReleaseName Folder
helm upgrade bot-connector . --install
# Combine value file (excluded from source control)
helm upgrade bot-connector . --install --values values.yaml --values values.yaml.user
# Test the application
helm test bot-connector

# ■■■■■■■■■■■■■■■■■■■■■■■■■
# ■ Uninstall application ■

#              ReleaseName
helm uninstall bot-connector
kubectl delete -n default pod bot-connector-bot-connector-to-teams-test-connection