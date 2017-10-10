Kubernetes minikube meetup
==========================

This repo has a pre-configured Kubernetes minikube environment which will be used during the meetup 
[Workshop Continuous Deployment naar Kubernetes](https://www.meetup.com/nl-NL/Technical-Test-Experts-Nederland/events/243333191/).

# General

## Supported OS
During this meetup we supports the following Operating Systems:
* OS X/macOS
* Linux

***Note:*** Windows might also work but is not tested. If trying, at least use a normal shell that can run `sh` files.

## Kubernetes
Kubernetes is a powerful production ready system for deploying, managing and scaling containerized applications. It is 
build on the same design principle as Google uses to manage millions of containerized applications. See the 
[Kubernetes website](https://kubernetes.io/) for more information.

## Minikube
Minikube is a single node Kubernetes cluster which makes it possible to run Kubernetes locally. See the
[minikube website](https://kubernetes.io/docs/getting-started-guides/minikube/) for more information.

## Kubectl
Kubectl is a command line interface to interact with a Kubernetes cluster. See the 
[cheat sheet](https://kubernetes.io/docs/user-guide/kubectl-cheatsheet/) for handy commands.

# Getting started

## 1) Preparation
Before you spin up the pre-configured minikube environment make sure you have installed the following:
* [Docker](https://www.docker.com/)
* [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [VirtualBox](https://www.virtualbox.org/)

## 2) Install pre-configured environment
You can install the pre-configured Kubernetes environment by running `./minikube.sh install` located in the root of this 
project (follow the command line interface). Installation might take a while depending on your internet connection.

After installation you will have:
* A locally running single node Kubernetes cluster
* A custom Jenkins configuration running on minikube
* Gitlab for source control running on minikube

The custom Jenkins configuration will support the following:
* docker-cli (for running sibling containers; DooD)
* kubectl
* node
* npm
* google-chrome-stable

***Note:*** minikube is configured to start a virtual machine on VirtualBox with `4 cpus` and `8192` memory. Adjust to 
your own will if needed by changing the mentioned settings in [start-minikube.sh](./kubernetes/start-minikube.sh)

## 3) Open the Kubernetes dashboard
Use the command `minikube dashboard` or start it by running `./minikube.sh` located in the root of this project.

## 4) Open Jenkins
To open Jenkins go to `http://<minikube-ip>/jenkins`

***Notes:*** 
* You can get the minikube ip by running the command `minikube ip`
* Installation may take a while, so don't worry if it does not load immediately after installation

## 5) Open Gitlab
To open Gitlab go to `http://<minikube-ip>/gitlab`

***Notes:*** 
* You can get the minikube ip by running the command `minikube ip`
* Installation may take a while, so don't worry if it does not load immediately after installation

## 6) Start, stop and delete
Minikube consumes lots of power. Make sure to stop minikube after you stop working with it. Otherwise it will drain your 
battery. You can use the `./minikube.sh` script or just run `minikube stop` and `minikube start` to stop and start the 
minikube virtual machine. After startup, the virtual machine will have the same state as you left it.

If for some reason you decide to completely delete the minikube virtual machine, use the `./minikube.sh` script or just
run  `minikube delete`. **Beware: all files will be gone!**

## 7) Switch to minikube docker daemon
In order to see all docker images and containers present on minikube, one must switch to the minikube docker daemon. You
can do this by running the command: 
```
eval $(minikube docker-env)
```
