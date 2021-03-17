# eks-terraform
Resources required for deployment of AWS EKS clusters using terraform Infrastructure as code

## Requirement
--------------------------
terraform v0.12, aws-iam-authenticator, python-pydot, python-pydot-ng and graphviz for resource graph visualization

AWS provider version auto installed from terrafrom init and set to versoon "~2.0"

1. Installing terraform provider [manual] (https://learn.hashicorp.com/terraform/getting-started/install.html)
   - To install terraform, find the right package for your system from [downloads] (https://www.terraform.io/downloads.html). Select the right package, right click and copy link    location
   - download the package using wget or curl: wget `paste link location`
   - unzip the package: unzip terraform.zip
   - terraform runs as a single binary. any other files in the package can be safely removed and terraform will still function. Move the terraform binary to one of the locations    like /usr/bin or /usr/local/bin and include PATH.
   - mv ~/terraform /usr/local/bin/teraform
   - set PATH to reflect the binary. Refer to link in step 1 for installation and setup binary
   - verify the installation: terraform -h

2. Installing aws-iam-authenticator for [Linux] (https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

3. Installing python-pydot,python-pydot-ng and graphviz for graph visualization:
   - sudo apt install python-pydot python-pydot-ng graphviz


## Usage
-----------------------------------

1. Use aws configure to load your api access keys to default  credentials file at "~/.aws/credentials" with profiles dev and prod. Loading through shared credentials file is not recommended, however a good approach is to get temporary STS credentials. 

2. terraform variables will be defaulted to region=us-west-2 and profile=dev if not specified during the terraform plan

3. All the code related to eks, vpc, storage will be under modules and for each environments for dev and prod can be created under environments directory. Always run from the envirnments main directory for terraform plan, apply, destroy and pull modules for code reusability  

4. Terraform flow:

```
1. Initialize the plugins for the provider and sync the terraform backend
   - terraform init

2. To validate the syntax for terraform config files
   - terraform validate

3. To output the terraform resource config out to an output plan file before applying changes.
   - terraform plan -out=tfplan

4. Apply changes to the terraform plan
   - terraform apply tfplan

5. View resources.
   - terraform show

6. Destroy changes to the resources or tear down the infrastructure.
   - terraform destroy -auto-approve

```


## Resource graph
--------------------------------
Resource graph of the terraform plan. Use graphviz to analyze plan

sudo apt install -y python-pydot python-pydot-ng graphviz

terraform graph | dot -Tsvg > images/resource-graph.svg

![](images/resource-graph.svg)


## Output
-----------------------------------------------------
```
Apply complete! Resources: 33 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate


tl-dev-terraform-IGW = igw-031d081a7b416705c

tl-dev-terraform-dynamodb_name = tl-eks-dev-terraformstate

tl-dev-terraform-eks-clusterSecuritygroup = tf-tl-eks-cluster

tl-dev-terraform-eks-endpoint = https://B19BF0FE0520390101CA88F1981AE46C.gr7.us-west-2.eks.amazonaws.com

tl-dev-terraform-eks-kubeconfig-cert-authority-data = LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01EVXhPREEyTkRFek1sb1hEVE13TURVeE5qQTJOREV6TWxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT0R2CjlBT1I5V1Byb2NZb29iWjg4c0Q3dUFBOVZ2UkhrOGoxbmIrWFJSMjI5SXZ1eUdVUFE2SmJaN0pxQTRsc0QrMkcKVHJTeDBpTlBQcUxSeDdjYjRKSEtCZ2YrRkhGNUM2cXQzRWV4dGsrTHZScERrTGdHZktlOGVhc0ZEK2pKdXNTQgpuS0lOYlJkUmZJWUx1SnJhU3BLTjlocEpDbDJHR0RqSndiUGRSZkplVEh1TEwvQXZaNWJibW0vVDFLZUR0Z0lkCnRQQWNhN242OVI1NCtVcmJFVFMzTnMxYk5jYWcxc1NuNWFCZW8wY3R3UFRDOE5JUjI0RkdWV09DVFpGWWdoN1EKWVBldmoyWGNNVUxRZnRYWXRKVFppQ1g4dEE1MC85bEVCcFVVYmx4SVY4VVhjZTRtWUdISklSbHorUCtUZFpySgp2NU0zcXZldWUvQmZTRk1qcHJNQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFHbEZFeXBFVXVjVkIyV0ludTNCUHdGT2VQbUQKTXFDQ2N2ZkMvSnB0MlhFWmJrcTlGYVRSS1dEOUpwOURjVWcrUVEwK0NrTUxzbDg0eHpQTi82dUN1UlY3SGMwZwo4QUJ2bWxsYUtvcklKV1Mwemg5cDFCazJqa09Sb284eTRBTjRsYjJKMkVid1lpS3pyb2VqalhDNlFJeDlWL1FuCnlPOVlUdWJ6b1VvWFZIMGVqMnBzcWN4dmdabHlmVFlndlJmMEttbC9YZ3dKQ3BYZ2R3aGUxMllBcVhKT0JLYVQKdURFNUoyeFFTcGIzV1EvK2xEQkZqQXc5bkJpclNBU25kUWxQWXhhQzc5NncyTHg5bVUrdE4zY2VLWTFoWWxJUwpqcVBEYk05TGtKdndTYWxzeWE1VUxnd3FXbVpqSTQzekJ6VjVRZXRPalZRVW1qUTh1SVhIR0hjZHF6Yz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=

tl-dev-terraform-eks-workernodesecuritygroup = tf-tl-eks-nodegroup

tl-dev-terraform-natGW = 52.34.227.104

tl-dev-terraform-privatesubnets = [
  "subnet-0d0ee7cf55ed1253d",
  "subnet-0e5f335c6d4a3b851",
]

tl-dev-terraform-publicsubnets = [
  "subnet-0dc6ef0e3d1a6d783",
  "subnet-0888f3492d5c91bef",
]

tl-dev-terraform-vpc = vpc-05ad72d1d7c3608ab

tl-dev-terraformbucket_name = arn:aws:s3:::tl-eks-dev-terraformstate

```

## Access EKS endpoint
------------------------------------------------------
```
root@ramu-VirtualBox:~# aws eks list-clusters --region us-west-2 --profile dev
{
    "clusters": [
        "terraform-tl-eks-test"
    ]
}

root@ramu-VirtualBox:~# aws eks --region us-west-2 update-kubeconfig --profile dev --name terraform-tl-eks-test
Updated context arn:aws:eks:us-west-2:644808427317:cluster/terraform-tl-eks-test in /root/.kube/config

root@ramu-VirtualBox:~# kubectl get po --all-namespaces
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE
kube-system   aws-node-dg8fm             1/1     Running   0          51m
kube-system   coredns-86d5cbb4bd-5wz45   1/1     Running   0          56m
kube-system   coredns-86d5cbb4bd-6q844   1/1     Running   0          56m
kube-system   kube-proxy-phlk6           1/1     Running   0          51m

root@ramu-VirtualBox:~# kubectl get nodes
NAME                                          STATUS   ROLES    AGE   VERSION
ip-10-123-30-127.us-west-2.compute.internal   Ready    <none>   51m   v1.15.11-eks-af3caf
root@ramu-VirtualBox:~# 

root@ramu-VirtualBox:~# kubectl get deploy --all-namespaces
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   coredns   2/2     2            2           68m

root@ramu-VirtualBox:~# kubectl get ds --all-namespaces
NAMESPACE     NAME         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   aws-node     1         1         1       1            1           <none>          68m
kube-system   kube-proxy   1         1         1       1            1           <none>          68m

root@ramu-VirtualBox:~# kubectl get svc --all-namespaces
NAMESPACE     NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)         AGE
default       kubernetes   ClusterIP   172.20.0.1    <none>        443/TCP         68m
kube-system   kube-dns     ClusterIP   172.20.0.10   <none>        53/UDP,53/TCP   68m
root@ramu-VirtualBox:~# 

```
