resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = var.compartment_tenancy_id
    name = var.compartment_name
    description = "terraform provided"
}
