provider "google" {
  credentials = file("C:\\development\\trellonotify-401705-34c3114d5a2c.json")
  project     = "trellonotify-401705"
  region      = "us-central1"
}

resource "google_storage_bucket" "function_source" {
  name     = "trellonotify-source-bucket"
  location = "us-central1"
}

