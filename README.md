# EKS cluster with 2 node groups using Terraform

#### I have used terraform modules that are created and managed by Hashicorp
```
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

```

### To provision an EKS cluster with 2 node pools
#### Run the following commands
```
terraform init

terraform plan

terraform apply
```

#### It will take 10-15 minutes for cluster provisioning
#### After the cluster is ready, you can deploy required components (Helm, Ingress Controller, cert-manager etc.)
#### To access the cluster kubeconfig file is currently stored in same location of your TF code
```
KUBECONFIG=./kubeconfig_{cluster_name} kubectl get nodes

export KUBECONFIG="${PWD}/kubeconfig_{cluster_name}"
```

