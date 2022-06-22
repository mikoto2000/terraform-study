locals {
  # 作成するユーザーのリスト(新人ユーザーリスト)
  rookies = [
    "rookie0001"
    , "rookie0002"
    , "rookie0003"
  ]
}

resource "aws_iam_user" "rookies" {
  # `rookies` の要素ごとに繰り返し定義するという設定
  for_each = toset(local.rookies)

  # ユーザー名。 rookies に定義した文字列が設定される
  name = "${each.value}"
}

resource "aws_iam_user_login_profile" "rookie" {
  # `aws_iam_user` で作成したユーザーごとに繰り返し定義するという設定
  # ここで `local.rookies` とかを指定してしまうと、
  # ユーザーがまだ作成されないうちにプロファイル定義を作ろうとして、
  # 「ユーザーがいません」って怒られることがある。
  for_each = aws_iam_user.rookies

  # 対象ユーザー
  user = "${each.value.name}"

  # 初期パスワードを暗号化するための公開鍵
  pgp_key = "${var.user_admin_gpg_key}"
}

output "rookies_encrypted_initia_password" {
  # aws_iam_user_login_profile.rookie の定義ごとに繰り返し、
  # `user` と `encrypted_password` をセットで表示するように指定
  value = "${[for v in aws_iam_user_login_profile.rookie: tomap({
    "user_name" = v.user
    "encrypted_password" = v.encrypted_password}
  )]}"
}
