resource "aws_iam_group" "rookies" {
  # グループ名
  name = "rookies"

  # 謎。 See: https://dev.classmethod.jp/articles/aws-iam-with-path/
  path = "/"
}

resource "aws_iam_group_policy_attachment" "AmazonEC2FullAccess-to-rookies" {
  # 付与対象のグループ
  group = aws_iam_group.rookies.name

  # 付与するポリシー
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group_policy_attachment" "CantTouchWebIDE-to-rookies" {
  # 付与対象のグループ
  group = aws_iam_group.rookies.name

  # 付与するポリシー
  policy_arn = aws_iam_policy.cant_touch_web_ide_policy.arn
}

resource "aws_iam_group_policy_attachment" "IAMUserChangePassword-to-rookies" {
  # 付与対象のグループ
  group = aws_iam_group.rookies.name

  # 付与するポリシー
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

