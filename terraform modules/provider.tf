provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  alias  = "aarushi"
  region = "us-east-1"
}