#!/bin/bash

function build_docker_image() {
    printf "\n---- Changing to minikube docker deamon and building docker image [${1}] ----\n"
    eval $(minikube docker-env) && docker build -t ${1} ${2}
}

function apply_descriptor() {
    for var in "$@"
    do
        printf "\n---- Applying deployment descriptor [${var}] ----\n"
        kubectl apply -n tools -f ${var}
    done
}

build_docker_image jenkins/jenkins-custom:latest ./jenkins
build_docker_image gitlab/gitlab-custom:latest ./gitlab
apply_descriptor jenkins/kubernetes/jenkins.yml gitlab/kubernetes/gitlab.yml

printf "\n==================================================="
printf "\n  Now wait for the dev-tools to be up and running."
printf "\n  Status can be viewed in the Kubernetes dashboard."
printf "\n  Run [minikube dashboard] to open the dashboard."
printf "\n===================================================\n"
