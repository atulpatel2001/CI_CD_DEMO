#!/bin/bash
set -euo pipefail

SERVICE=$1
ENV=$2
NAMESPACE=$3

VALUES_FILE="./infra/helm-charts/enviroment/${ENV}/${SERVICE}/values.yaml"
CHART_PATH="./services/${SERVICE}/helm/helm-chart"

# 🧠 Sanity checks
if [ ! -f "$VALUES_FILE" ]; then
  echo "[❌ ERROR] Missing values file: $VALUES_FILE"
  exit 1
fi

if [ ! -d "$CHART_PATH" ]; then
  echo "[❌ ERROR] Helm chart not found at path: $CHART_PATH"
  exit 1
fi

cd "$CHART_PATH"

# 🔄 Build chart dependencies
echo "[🔄] Running helm dependency build..."
helm dependency build

# ✅ Pre-flight check
echo "[🔍] Linting chart..."
helm lint .

echo "[🧪] Validating template render..."
helm template "$SERVICE" . -f "$VALUES_FILE" --namespace "$NAMESPACE"

# 🚀 Install or Upgrade
if helm status "$SERVICE" -n "$NAMESPACE" > /dev/null 2>&1; then
  echo "[⬆️  INFO] Upgrading $SERVICE in $NAMESPACE..."
  helm upgrade "$SERVICE" . -f "$VALUES_FILE" -n "$NAMESPACE" --wait --timeout=5m
else
  echo "[🚀 INFO] Installing $SERVICE in $NAMESPACE..."
  helm install "$SERVICE" . -f "$VALUES_FILE" -n "$NAMESPACE" --create-namespace --wait --timeout=5m
fi

echo "[✅ SUCCESS] $SERVICE deployed to $NAMESPACE"


