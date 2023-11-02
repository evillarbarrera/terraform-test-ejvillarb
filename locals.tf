locals {
  sufix = "${var.tags.proyecto}-${var.tags.env}"
}

resource "random_string" "sufijo-s3" {
  length = 8
  special = false
  upper = false
}

locals {
  s3-sufix = "${var.tags.proyecto}-${random_string.sufijo-s3.id}"
}