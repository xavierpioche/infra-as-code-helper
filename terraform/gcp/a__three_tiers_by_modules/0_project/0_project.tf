########---- PROJECT ----########
module "gcp_project" {
  source="../modules/project"
  project_name=var.project_name
  project_id=var.project_id
  billing_account=var.billing_account
}

