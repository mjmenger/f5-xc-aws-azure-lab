include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../modules/tgw-workload"
    before_hook "pre-check" {
        commands = ["apply","plan"]
        execute  = ["./pre-check.sh"]
    }

}


dependencies {
  paths = ["../alt-aws-base2","../alt-tgw-site2", "../alt-site-mesh-group"]
}

dependency "infrastructure" {
  config_path = "../alt-aws-base2"
  mock_outputs = {
    spokeExternalSubnets= {
      "az1" = {
        "id" = "1"
      }
    }
    spokeWorkloadSubnets = {
      "az1" = {
        "id" = "1"
      }
    }
    spokeSecurityGroup = {
      "az1" = {
        "id" = "1"
      }
    }
    spoke2ExternalSubnets= {
      "az1" = {
        "id" = "1"
      }
    }
    spoke2WorkloadSubnets = {
      "az1" = {
        "id" = "1"
      }
    }
    spoke2SecurityGroup = {
      "az1" = {
        "id" = "1"
      }
    }
  }
}

inputs = {
  instanceSuffix        = "2"
  awsRegion             = "us-west-2"
  spokeExternalSubnets  = dependency.infrastructure.outputs.spokeExternalSubnets
  spokeWorkloadSubnets  = dependency.infrastructure.outputs.spokeWorkloadSubnets
  spokeSecurityGroup    = dependency.infrastructure.outputs.spokeSecurityGroup
  spoke2ExternalSubnets = dependency.infrastructure.outputs.spoke2ExternalSubnets
  spoke2WorkloadSubnets = dependency.infrastructure.outputs.spoke2WorkloadSubnets
  spoke2SecurityGroup   = dependency.infrastructure.outputs.spoke2SecurityGroup
}
