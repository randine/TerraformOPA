provider "aws" {
  version = ">= 2.28.1"
  region  = "ap-southeast-2"
}

resource "aws_config_config_rule" "ConfigRule" {
  name        = "rds-cluster-deletion-protection-enabled"
  description = "A config rule that checks if an Amazon Relational Database Service (Amazon RDS) cluster has deletion protection enabled. This rule is NON_COMPLIANT if an RDS cluster does not have deletion protection enabled."

  source {
    owner = "AWS"
    source_identifier = "RDS_CLUSTER_DELETION_PROTECTION_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBCluster"]
  }
}
