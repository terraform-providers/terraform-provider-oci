# Do not alter this file.

data "oci_identity_compartments" "compartment" {
	compartment_id = "${var.tenancy_ocid}"
	filter {
		name = "name"
		values = [ "${var.build_env["compartment"]}" ]
	}
}

data "oci_identity_availability_domains" "ad" {
	compartment_id = "${var.tenancy_ocid}"
	filter {
		name = "name"
		values = [ "\\w*-${upper(var.build_env["ad"])}" ]
		regex = true
	}
}

data "oci_core_virtual_networks" "vcn" {
	compartment_id = "${data.oci_identity_compartments.compartment.compartments.0.id}"
	filter {
		name = "display_name"
		values = [ "${var.build_env["vcn"]}" ]
	}
}

data "oci_core_subnets" "subnet" {
	compartment_id = "${data.oci_identity_compartments.compartment.compartments.0.id}"
	vcn_id = "${data.oci_core_virtual_networks.vcn.virtual_networks.0.id}"
	filter {
		name = "display_name"
		values = [ "${var.build_env["subnet"]}" ]
	}

}

data "oci_core_images" "image" {
	compartment_id = "${data.oci_identity_compartments.compartment.compartments.0.id}"
	display_name = "${var.ipxe_instance["image"]}"
}

data "external" "ipxe_gen" {
	program = [ "/bin/bash", "./ipxe_gen.sh"]
	query = {
		tenancy_ocid         = "${var.tenancy_ocid}"
  		user_ocid            = "${var.user_ocid}"
 		private_key_path     = "${var.private_key_path}"
		private_key_password = "${var.private_key_password}"
		region               = "${var.region}"
		ssh_public_key		 = "${var.ssh_public_key}"
		os_short_name		 = "rhel74"
		bucket			 = "${var.iso_location["bucket_name"]}"
		iso_name			 = "${var.iso_location["iso_name"]}"
		rhel_user			 = "${var.rhel_account["user_name"]}"
		rhel_pw			 = "${var.rhel_account["password"]}"
	}
}