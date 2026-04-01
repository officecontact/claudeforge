---
name: kubernetes
description: K8s operations. Triggers on kubernetes, k8s, helm, kubectl, pod.
---

## Kubernetes
**Resources:** Deployment (replicas), Service (expose), Ingress (HTTP), ConfigMap, Secret, HPA.
**Checklist:** Resource limits, probes, PDB, specific tags (not latest), secrets from Secret resource.
**Debug:** get pods > describe > logs -f > exec -it > top pods > get events.
