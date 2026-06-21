# Define variables for Root Module
variable "tools" {
  default = {
    workstation = {
      instance_type = "t3.medium"
      ports = {
        ssh = 22
        http = 80
        https = 443
      }
      volume_size = 30
      policy_name = [
      # define multiple policy objects here
        {
          name = "AdministratorAccess"
          arm  = "arn:aws:iam::aws:policy/AdministratorAccess"
        },
        {
          name = "AmazonS3FullAccess"
          arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
        },
        # add up more polices here
      ]
    }
    # you can add up more tools here - github runner - vault
  }
}

variable "key_pair" {
  type = string
  default = "ec2-B3key"
}