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