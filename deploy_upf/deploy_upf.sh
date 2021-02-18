#!/bin/bash

export UPF_DEPLOY_PATH=$(cd `dirname $0`; pwd)

kubectl get configmaps -n upf upf-config > /dev/null 2>&1
if [ $? -ne 0 ]; then
    kubectl create -f $UPF_DEPLOY_PATH/upf-configmap.yaml
fi

if [ "$1" == "smu" ]; then
    kubectl create -f $UPF_DEPLOY_PATH/upf-c-deploy.yaml
elif [ "$1" == "lbu" ]; then
    kubectl create -f $UPF_DEPLOY_PATH/upf-loadbalancer.yaml
elif [ "$1" == "fpu" ]; then
    kubectl create -f $UPF_DEPLOY_PATH/upf-u-deploy.yaml
elif [ "$1" == "all" ]; then
    kubectl create -f $UPF_DEPLOY_PATH/upf-loadbalancer.yaml
    kubectl create -f $UPF_DEPLOY_PATH/upf-c-deploy.yaml
    kubectl create -f $UPF_DEPLOY_PATH/upf-u-deploy.yaml
else
    echo "E.g. $0 smu|lbu|fpu|all"
fi
