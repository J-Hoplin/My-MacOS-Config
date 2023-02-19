#!/bin/zsh

version='1.25.1'

if [ ! -z $1 ]
then
    version=$1
fi

curl -Lo minikube https://github.com/kubernetes/minikube/releases/download/v$version/minikube-darwin-arm64 \
  && chmod +x minikube

minikube start --driver=docker

brew install kubectl