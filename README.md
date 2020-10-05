# This is a POC to use OPA to evaluate a Terraform file to see if it can create subnets in AWS

You need to have AWS CLI installed and configured so you have your credentials stored in ~/.aws/credentials
'''
aws configure
'''
Once AWS is configured you can then use Terraform.
This main.tf aims to create a VPC and 2 subnets in AWS. 

Initialize Terraform and ask it to calculate what changes it will make and store the output in plan.binary.

terraform init
terraform plan --out tfplan.binary

OPA needs the input file in Json format to evaluate the Terraform plan
We then convernt the Terraform plan into JSON

terraform show -json tfplan.binary > tfplan.json

Next we evaluate the tfplan.json with the OPA rego file. 
The file is looking changes with AWS subnets (change, Delete, modify) and adds a score against the plan. A blast radius of 5 has been set and a weight of 10 to create a new subnet. The 

opa eval --format pretty --data test.rego --input tfplan.json "data.terraform.analysis.score"

Output: 20

opa eval --format pretty --data terraform.rego --input tfplan.json "data.terraform.analysis.authz"

Output: false

So it failed the test. 

If you edit the blast radius score in the terraform.rego file to be above 20, then it will give a 'true' value which would then let the subnets be created. 

