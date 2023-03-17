
resource "google_project" "project" {
  name       = var.project_name
  project_id = var.project_id
  billing_account = var.billing_account
// folder_id  = google_folder.folder.name
  auto_create_network = false
  
}

//resource "google_folder" "folder" {
//  display_name = var.project_folder
//  parent       = var.project_org
//}
