#!/bin/bash

export UPF_DEPLOY_PATH=$(cd `dirname $0`; pwd)

if [ "$1" == "smu" ]; then
    kubectl get daemonsets.apps -n upf upf-c-a > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-c-deploy.yaml
    fi
elif [ "$1" == "lbu" ]; then
    kubectl get daemonsets.apps -n upf upf-lb-a > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-loadbalancer.yaml
    fi
elif [ "$1" == "fpu" ]; then
    kubectl get deployments.apps -n upf upf-u > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-u-deploy.yaml
    fi
elif [ "$1" == "all" ]; then
    kubectl get daemonsets.apps -n upf upf-c-a > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-c-deploy.yaml
    fi
    kubectl get daemonsets.apps -n upf upf-lb-a > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-loadbalancer.yaml
    fi
    kubectl get deployments.apps -n upf upf-u > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-u-deploy.yaml
    fi

    kubectl get configmaps -n upf upf-config > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        kubectl delete -f $UPF_DEPLOY_PATH/upf-configmap.yaml
    fi
else
    echo "E.g. $0 smu|lbu|fpu|all"
fi
