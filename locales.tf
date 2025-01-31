# 利用可能なAWSアベイラビリティゾーン（AZ）のリストを取得
data "aws_availability_zones" "available" {
  state = "available"
}

# 現在のAWSアカウントID、ユーザーID、およびアカウントが属するARNを取得
data "aws_caller_identity" "current" {}
# 現在Terraformが操作しているリージョンの名前を取得
data "aws_region" "current" {}
# 現在のリージョンにおけるElastic Load Balancing (ELB) サービスアカウントのIDを取得
data "aws_elb_service_account" "main" {}
# AWSアカウントの標準（カノニカル）ユーザーIDを取得します。これは、S3バケットのアクセス制御リスト（ACL）などで使用される
data "aws_canonical_user_id" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  # サービス名
  name   = "sample_api"
  # サービスのドメイン
  domain = "sample_api.link"

  availability_zones = toset(data.aws_availability_zones.available.names)

  az_conf = {
    "ap-northeast-1a" = {
      index      = 1
      short_name = "1a"
    }
    "ap-northeast-1c" = {
      index      = 2
      short_name = "1c"
    }
    "ap-northeast-1d" = {
      index      = 3
      short_name = "1d"
    }
  }

  vpc_cidr = "10.0.0.0/16"

  secrets = {
    cloudfront_shared_key = "AQICAHhxcOHhVzL2EwWj90RRTdMZ0MYnfo0ER2g2xA6XxvsuMQFbfQt7T9DKrNezw9nVZrkYAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMDGyuL/ERm3fGHkXHAgEQgDvYMEXLBcD0MiZdANgk4a7pv2DUsG/J0dK8yfr20C/thZktjvrmtVnWj9dGh75/0mvbdVwh+lBhg/7zYQ=="
    rails_master_key      = "AQICAHhxcOHhVzL2EwWj90RRTdMZ0MYnfo0ER2g2xA6XxvsuMQG7TKaXX+Cl/gDQaU1KN1tJAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMXCj237k7rHqYDLqTAgEQgDvttnqzO/W7uotcXvenQpTsPDyqNExxRKvvdnCozhyhwlo+dfdfsY18PJSqabsdBvZR+llfrKJq/avWzQ=="
    db_password           = "AQICAHhxcOHhVzL2EwWj90RRTdMZ0MYnfo0ER2g2xA6XxvsuMQFB0W6mUq7CGTRpuJRU1JtdAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMtgf9ZvOZseWDcZlFAgEQgDtFlv+fobkyI4t3Jm4cqfvgpKumuCcT3Ep/UcjdJmUOIvhUKxILJA7Uwg9Z3MDY2HoGmrQuLaM18n4uAQ=="
  }
}