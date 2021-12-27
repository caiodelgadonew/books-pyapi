# Deploy in AWS with Terraform

There's many ways of deploying the terraform code. For all of them you need Terraform CLI version `~> 1.0.0`, which stands for allowing only the _rightmost_ version increment.

> This version constraint is set because of an existing bug of Terraform CLI that affects versions `v1.1.0` and `1.1.1`, the [changelog for version 1.1.2](https://github.com/hashicorp/terraform/releases/tag/v1.1.2) says that it was fixed but the problem is still there and a issue is opened for it [#30266](https://github.com/hashicorp/terraform/issues/30266).


1. Install [terraform v1.0.11](https://releases.hashicorp.com/terraform/1.0.11/) or any version that satisfies the constraints.
2. Configure your aws credentials, refer to the [AWS Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) or [AWS Provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)

**_[WIP]_** The structure of this infra folder consist of multiple folders, each one deploying in a different way.
- `ec2`
- [WIP]

## Basic Deployment

To create the infrastructure, go to the `book-pyapi/infra/<DEPLOY>` folder and issue the following commands:
```bash
$ terraform init
$ terraform apply 
```

The default region is set as `eu-central-1`, if you want to deploy in a different version you can issue the command `terraform apply -var="region=us-east-1"` for example if you want to deploy in `us-east-1`, or change it into the `variable.tf` file.

> **WARNING:** Resources running on AWS costs money, be sure to remove them if you dont need it anymore with the command `terraform destroy`

### EC2 Deployment

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFI7XG4gICAgQVtVc2VyXVxuICAgIEJbTG9hZCBCYWxhbmNlcl1cbiAgICBDW1RhcmdldCBHcm91cF1cbiAgICBEW0VDMl1cbiAgICBBLS0gcG9ydDo4MCAtLT5CO1xuICAgIEItLSBodHRwIGxpc3RlbmVyIC0tPkM7XG4gICAgQy0tIHBvcnQ6OTAwMCAtLT5EOyIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)](https://mermaid.live/edit/#eyJjb2RlIjoiZ3JhcGggTFI7XG4gICAgQVtVc2VyXVxuICAgIEJbTG9hZCBCYWxhbmNlcl1cbiAgICBDW1RhcmdldCBHcm91cF1cbiAgICBEW0VDMl1cbiAgICBBLS0gcG9ydDo4MCAtLT5CO1xuICAgIEItLSBodHRwIGxpc3RlbmVyIC0tPkM7XG4gICAgQy0tIHBvcnQ6OTAwMCAtLT5EOyIsIm1lcm1haWQiOiJ7XG4gIFwidGhlbWVcIjogXCJkZWZhdWx0XCJcbn0iLCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9)

The endpoints are protected to security groups enabling access only to the ports needed by the loadbalacer and application.

When the ec2 application inits, it bootstraps the instalation of Docker and the `books-pyapi` into a docker-compose that get the application alive.

> Please note that the application can take some time to became ready since there's healthchecks for the target group and also containers.

Apply the code through terraform, at the end a message will be shown with the endpoint of the application in the following format:

```
aws_lb = "books-api-alb-<10_DIGITS>.<AWS_REGION>.elb.amazonaws.com"
```
As soon as the application is ready you should be able to access it through the address above.


#### Troubleshooting

If any troubleshooting is needed, you can connect into the ec2 instance through the AWS `ssm` at the amazon console.

> This is the only way to access the ec2 instance. There was not added a public port for `SSH` because of security measures.
