#!/bin/bash
kubectl delete -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/deployment/galaxy_rc.yaml
kubectl delete -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/deployment/galaxy_svc.yaml
kubectl delete -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/persistent_volumes_examples/galaxy-pvc.yaml
kubectl delete -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/persistent_volumes_examples/pv_hostpath_minikube_internal.yaml
echo "The uninstallation of PhenoMeNal Workflow has been completed."