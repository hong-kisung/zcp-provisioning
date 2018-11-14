## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ibm\_bluemix\_api\_key | IBM Cloud Authentication variables | string | - | yes |
| ibm\_softlayer\_username | - | string | - | yes |
| ibm\_softlayer\_api\_key | - | string | - | yes |
| region | Cluster variables | string | `jp-tok` | no |
| datacenter | - | string | `seo01` | no |
| resource\_group\_name | - | string | `Default` | no |
| private\_vlan | - | map | `<map>` | no |
| public\_vlan | - | map | `<map>` | no |
| cluster\_name | - | string | - | yes |
| billing | - | string | `hourly` | no |
| kube\_version | - | string | - | yes |
| no\_subnet | - | string | `true` | no |
| zone | - | string | `seo01` | no |
| zone\_private\_vlan | - | map | `<map>` | no |
| zone\_public\_vlan | - | map | `<map>` | no |
| edge | - | map | - | yes |
| edge\_zones | - | list | - | yes |
| management | - | map | - | yes |
| management\_zones | - | list | - | yes |
| logging | - | map | - | yes |
| logging\_zones | - | list | - | yes |
| zcp\_shared | - | map | - | yes |
| zcp\_shared\_zones | - | list | - | yes |
| zcp\_dedicated | - | map | - | yes |
| zcp\_dedicated\_zones | - | list | - | yes |
| zdb\_shared | - | map | - | yes |
| zdb\_shared\_zones | - | list | - | yes |

