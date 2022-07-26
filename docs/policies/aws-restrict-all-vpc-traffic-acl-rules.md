#  Ensure the default security group of every VPC restricts all traffic
This policy enforces recommendations for configuring security-related aspects of the default Virtual Private Cloud (VPC) in AWS and ensures that the default security group of every VPC restricts all traffic. Configuring all VPC default security groups to restrict all traffic will encourage least privilege security group development and mindful placement of AWS resources into security groups which in-turn will reduce the exposure of those resources.

## Parameters
This policy does not contain parameter declarations.

## Policy
```sentinel
import "tfplan/v2" as tfplan

allDefaultNetworkACLs = filter tfplan.resource_changes as _, resource_changes {
	resource_changes.mode is "managed" and
		resource_changes.type is "aws_default_network_acl" and
		(resource_changes.change.actions contains "create" or
			resource_changes.change.actions is ["update"])
}

print("CIS 4.3: Ensure the default security group of every VPC restricts all traffic")

deny_undefined_ingress_configuration = rule {
	all allDefaultNetworkACLs as _, acls {
		keys(acls.change.after) contains "ingress"
	}
}

deny_all_vpc_inbound_acls = rule when deny_undefined_ingress_configuration is true {
	all allDefaultNetworkACLs as _, acls {
		length(acls.change.after.ingress) == 0
	}
}

deny_undefined_egress_configuration = rule {
	all allDefaultNetworkACLs as _, acls {
		keys(acls.change.after) contains "egress"
	}
}

deny_all_vpc_outbound_acls = rule when deny_undefined_egress_configuration is true {
	all allDefaultNetworkACLs as _, acls {
		length(acls.change.after.egress) == 0
	}
}

main = rule {
	deny_undefined_ingress_configuration and
	deny_undefined_egress_configuration and
	deny_all_vpc_inbound_acls and
	deny_all_vpc_outbound_acls
}
```
