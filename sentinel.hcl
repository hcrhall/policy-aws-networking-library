policy "aws-deny-public-rdp-acl-rules" {
  source = "./policies/aws-deny-public-rdp-acl-rules/aws-deny-public-rdp-acl-rules.sentinel"
}

policy "aws-deny-public-ssh-acl-rules" {
  source = "./policies/aws-deny-public-ssh-acl-rules/aws-deny-public-ssh-acl-rules.sentinel"
}

policy "aws-restrict-all-vpc-traffic-acl-rules" {
  source = "./policies/aws-restrict-all-vpc-traffic-acl-rules/aws-restrict-all-vpc-traffic-acl-rules.sentinel"
}
