#!/bin/bash

# VirtualBox settings
cpus=4
memory=8192

function wait_for_minikube_readiness() {
    printf "\n---- Waiting for local cluster to be ready ----\n"
    until ping -c1 $(minikube ip) &>/dev/null; do :; done
    printf "Minikube is ready.\nExecute [minikube dashboard] to open the Kubernetes dashboard. \n"
}

function apply_descriptor() {
    for var in "$@"
    do
        printf "\n---- Applying descriptor [${var}] ----\n"
        IP=$(minikube ip)
        cat ${var} | sed s/192.168.99.100/${IP}/ | kubectl apply -f -
    done
}

printf "\n---- Starting local Kubernetes cluster ----\n"
printf "Starting VM with $cpus cpus and $memory memory...\n"
printf "If needed, change these settings in [./kubernetes/start-minikube.sh]\n"
minikube start --memory=${memory} --cpus=${cpus} --vm-driver=virtualbox
wait_for_minikube_readiness
apply_descriptor traefik.yml namespaces/tools.yml namespaces/prod.yml