terraform {
  # AWS を使いますよという定義
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "mikoto2000-terraform-user-admin"
    region = "ap-northeast-1"
    key = "terraform.tfstate"
  }
}

# AWS の設定
# アクセストークンとアスセスシークレットは、環境変数から取得する
provider "aws" {
  # リージョン
  region = "ap-northeast-1"

  default_tags {
    tags = {
      ResourceGroup = "terraform-study"
    }
  }
}
