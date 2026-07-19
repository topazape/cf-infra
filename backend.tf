terraform {
  required_version = ">=1.15.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.22"
    }
  }

  backend "s3" {
    bucket = "cf-infra-tfstate"
    key    = "terraform.tfstate"
    region = "auto"

    endpoints = {
      s3 = "https://fcceb839ff56f163e6280d4f39186d16.r2.cloudflarestorage.com"
    }

    skip_credentials_validation = true # R2 は STS API を持たないため資格情報検証をスキップ
    skip_region_validation      = true # "auto" は実在の AWS リージョンではないため検証をスキップ
    skip_requesting_account_id  = true # R2 は IAM/STS/metadata API を持たないためアカウント ID 取得をスキップ
    use_path_style              = true # R2 は path style URL のみ対応
    use_lockfile                = true # DynamoDB なしで S3 ネイティブロックを有効化(Terraform 1.10+)
  }

}
