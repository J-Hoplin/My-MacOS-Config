#!/bin/zsh

version='1.25.1'

if [ ! -z $1 ]
then
    version=$1
fi


brew install minikube

minikube start --driver=docker

brew install kubectl