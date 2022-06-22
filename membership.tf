resource "aws_iam_group_membership" "rookies" {
  # グループメンバーシップ名
  name = "rookies"

  # グループに所属させるユーザーの、名前のリストを指定
  users = [for v in aws_iam_user.rookies: v.name]

  # 対象のグループを指定
  group = aws_iam_group.rookies.name
}

