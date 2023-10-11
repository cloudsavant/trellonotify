provider "google" {
  credentials = file("C:\\development\\trellonotify-401705-34c3114d5a2c.json")
  project     = "trellonotify-401705"
  region      = "us-central1"
}

resource "google_storage_bucket" "function_source" {
  name     = "trellonotify-source-bucket"
  location = "us-central1"
}

resource "google_storage_bucket_object" "function_code" {
  name   = "test-function.zip"
  bucket = google_storage_bucket.function_source.name
  source = "../build/code.zip" # assuming you've zipped your function and placed it in the app directory
}

resource "google_cloudfunctions_function" "test_function" {
  name                  = "test-function"
  description           = "Function to execute test.py"
  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.function_source.name
  source_archive_object = google_storage_bucket_object.function_code.name
  trigger_http          = true
  runtime               = "python310"
  entry_point           = "test_function"
}