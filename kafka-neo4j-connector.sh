#!/bin/bash

echo "🚀 [Step 1] Applying Kafka → Neo4j connector deployment"
kubectl apply -f kafka-neo4j-connector.yaml

echo "⏳ [Step 2] Waiting for Kafka Connect pod to become ready (up to 300 seconds)..."
kubectl wait --for=condition=ready pod -l app=kafka-neo4j-connector --timeout=300s

echo "📜 [Step 3] Streaming logs from Kafka Connect pod"
kubectl logs -f $(kubectl get pods -l app=kafka-neo4j-connector -o jsonpath="{.items[0].metadata.name}")
