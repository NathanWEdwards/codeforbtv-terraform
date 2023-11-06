resource "random_id" "id" {
  byte_length = 8
}

data "google_billing_account" "default" {
  display_name = var.BILLING_ACCOUNT_DISPLAY_NAME
}

resource "google_project" "default" {
  provider = google-beta

  name            = random_id.id.dec
  project_id      = "${var.PROJECT_NAME}-${tonumber(random_id.id.dec)}"
  billing_account = data.google_billing_account.default.id

  labels = {
    "firebase" = "enabled"
  }
}