resource "google_storage_bucket" "bucket_test" {
  name                        = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
  location                    = var.location
  project                     = var.project_id
  storage_class               = var.storage_class

  # Enforce public access prevention
  public_access_prevention = "enforced"

  # Ensure IAM-based access control is enabled
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = var.lifecycle_rule_age
    }
    action {
      type = "Delete"
    }
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4  # Adjust the length of the random string (in bytes)
}
