# Cloud Z CP Provisioning

[Hashcorp Terraform](https://www.terraform.io/) 을 이용하여 Cloud Z CP 를 Provisioning 합니다.
아래를 Provisioning 합니다.

* IKS(IBM Kubernetes Service) Cluster
* IKS Worker Pools
* IKS Worker Nodes
  * Edge Node(Optional)
  * Management Node(Required)
  * Logging Node(Optional)
  * ZCP Shared Worker Node(Optional)
  * ZCP Dedicated Worker Node(Optional)
  * ZDB Worker Node(Optional)

## Before you begin

1. private VLAN 생성
2. provisioning 을 하기 위한 계정에 Default Resource Group 또는 생성한 Resource Group 에 권한 할당

### Install Terraform

아래 링크를 참고해서 Terraform 를 설치하세요.

https://www.terraform.io/intro/getting-started/install.html

### Install IBM Cloud Provider

아래 링크를 참고해서 IBM Cloud Provider 를 설치하세요.

https://ibm-cloud.github.io/tf-ibm-docs/index.html#using-terraform-with-the-ibm-cloud-provider

### Install IBM Cloud CLI

아래 링크를 참고해서 IBM Cloud CLI 를 설치하세요.

```
curl -sL https://ibm.biz/idt-installer | bash
```
https://console.bluemix.net/docs/cli/index.html#overview

## Change the variables

```
$ cp example.tfvars terraform.tfvars
```

* Bluemix API Key : https://console.bluemix.net/docs/iam/userid_keys.html#userapikey
* Softlayer Username : 
* Softlayer API Key : 


## Init, plan, apply

```
$ terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "helm" (0.6.2)...
- Downloading plugin for provider "kubernetes" (1.3.0)...
- Downloading plugin for provider "template" (1.0.0)...
- Downloading plugin for provider "null" (1.0.0)...
...
```

```
$ terraform plan
```

```
$ terraform apply

...
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
...
```

## Destroy

```
terraform destroy
```

## Variables Documentation

https://github.com/segmentio/terraform-docs

```
$ brew install terraform-docs
```

```
$ terraform-docs --no-sort md variables.tf > variables.md
```

## Troubleshooting

1. 아래와 같은 에러 발생했을 경우
```
* ibm_container_cluster.zcp-cluster: 1 error(s) occurred:
* ibm_container_cluster.zcp-cluster: Error occured while configuring MCCP service: "ServiceEndpointDoesnotExist: UAA endpoint doesn't exist for region: \"jp-tok\""
```
IBM Cloud Provider 인증 시 사용하는 API Endpoint 가 jp-tok 에는 없어서 발생하는 에러
관련 소스코드 : https://github.com/IBM-Cloud/bluemix-go/blob/master/endpoints/endpoints.go

```hcl-terraform
provider "ibm" {
  bluemix_api_key    = "${var.ibm_bluemix_api_key}"
  softlayer_username = "${var.ibm_softlayer_username}"
  softlayer_api_key  = "${var.ibm_softlayer_api_key}"
//  region             = "jp-tok"
}
```

2. Resource Group 권한이 없으면 crash 발생

https://console.bluemix.net/docs/resources/resourcegroups.html#rgs

관련 소스코드 https://github.com/IBM-Cloud/terraform-provider-ibm/blob/master/ibm/resource_ibm_container_bind_service.go