# Argo Workflow Example

This repo demonstrates the basic AI/ML pipeline to train a prediction model using Argo Workflows.

It uses following components.

## MicroK8S

MicroK8S runs local kubernetes cluster inside VM. You can read more about it and setup at https://microk8s.io/#install-microk8s. You can use any other local kubernets cluster tool such as minikube, k9s or kind etc..


## ArgoCD

This project is not using ArgoCD. It can be ignored for the purpose of this demo. It was deployed initially to explore integration with Argo workflows.

Install ArgoCD using ArgoCD documentation on the local cluster and port forward to access UI.
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Access the ArgoCD using http://localhost:8080

## Argo Worlflows

It uses Argo Workflows to run AI/ML pipelines.

Intall Argo Workflows using documentation and port forward to access UI.
```
kubectl -n argo port-forward service/argo-server 2746:2746
```

Access the Argo Workflow using http://localhost:2746

## Minio

It uses Minio to upload data sets and artifacts.

Intall Minio on the cluster using provided minio.yaml.
```
microk8s kubectl apply -f minio.yaml

kubectl -n default port-forward service/minio 9000:9000
```

## Hera

Hera is the python library that makes the engine work smoothly. https://hera-workflows.readthedocs.io/en/latest/ it makes workflow pipeline run with almost no yaml management.

## Docker Registry

It uses personal docker registry to store tagged images to run workflows.

To upload local dataset to the minio bucket, run following command.
```
make add-data
```
To run the workflow pipeline, run the following command.
```
make run
```

## Files

- Inside assets folder, you can find the dataset used by the model.
- Inside ds_blog folder, you can find the files that basically does the same thing but using different stages.
    * a1_ file is basically the first draft of the code to run the model.
    * a2_ file adds some structure to the code using functions.
    * a3a_ file is using the functions to make it into workflow form.
    * a3b_ file will produce the yaml for the workflow.

### Note:
This repo uses some secret tokens and passwords to run fully. Those are created/stored locally and not a part of this repo.