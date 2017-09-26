#!/bin/bash

function usage() {
  printf "Usage: $0 {install|start|dashboard|ip|stop|delete|help}\n\n"
  printf "Options:\n"
  printf "  dashboard      show minikube dashboard\n"
  printf "  delete         remove the minikube machine\n"
  printf "  help           show help\n"
  printf "  install        start & install minikube and dev-platform\n"
  printf "  ip             get minikube ip\n"
  printf "  start          start minikube\n"
  printf "  stop           stop minikube\n\n"
  exit 1
}

function apply_descriptor() {
    for var in "$@"
    do
        printf "\n---- Applying descriptor [${var}] ----\n"
        IP=$(minikube ip)
        cat ${var} | sed s/192.168.99.100/${IP}/ | kubectl apply -f -
    done
}

function run() {
  ACTION="$@"
    case "${ACTION}" in
        install)
            DIR=$(pwd)
            cd ${DIR}/kubernetes && sh start-minikube.sh
            cd ${DIR}/dev-platform && sh deploy-dev-platform.sh
            cd ${DIR}
            ;;
        start)
            minikube start
            echo "re-applying base descriptors in case minikube ip has changed..."
            DIR=$(pwd)
            apply_descriptor ${DIR}/kubernetes/ingress.yml \
                ${DIR}/dev-platform/gitlab/kubernetes/gitlab.yml \
                ${DIR}/dev-platform/jenkins/kubernetes/jenkins.yml
            ;;
        dashboard)
            minikube dashboard
            ;;
        ip)
            minikube ip
            ;;
        stop)
            minikube stop
            ;;
        delete)
            minikube delete
            ;;
        help)
            usage
            ;;
        *)
            echo "Unknown option: [${ACTION}]"
            usage
            ;;
    esac
}

run $@