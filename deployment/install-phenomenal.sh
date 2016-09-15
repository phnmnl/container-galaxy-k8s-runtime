#!/bin/bash
kubectl create -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/persistent_volumes_examples/pv_hostpath_minikube_internal.yaml
kubectl create -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/persistent_volumes_examples/galaxy-pvc.yaml
kubectl create -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/deployment/galaxy_svc.yaml
kubectl create -f https://raw.githubusercontent.com/phnmnl/docker-galaxy-k8s-runtime/master/deployment/galaxy_rc.yaml
echo "Please wait several minutes then visit PhenoMeNal Workflow using the IP address below"
kubectl cluster-info | grep master | awk '{ print $6 }' | sed s/https/http/ | sed 's/\(http:[^:]*\):.*/\1:30700/'
