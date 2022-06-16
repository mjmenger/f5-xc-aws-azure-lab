include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../modules/tgw-apps"
}

dependencies {
  paths = ["../alt-tgw-site","../alt-workload1"]
}

dependency "workloads" {
  config_path = "../alt-workload1"
  mock_outputs = {
    workload_ip = ""
    workload_ip2 = ""
  }
}

inputs = {
    workload_ip  = dependency.workloads.outputs.workload_ip
    workload_ip2 = dependency.workloads.outputs.workload_ip2
}
