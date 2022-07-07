resource "aws_iam_policy" "cant_touch_web_ide_policy" {
  name        = "cant_touch_web_ide_policy"
  path        = "/"
  description = "WebIDE 関連のリソースには触れないようにする。"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Sid": "CantTouchWebIDE",
            "Effect": "Deny",
            "Action": "ec2:*",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/Owner": "WebIDE"
                }
            }
        }
    ]
  })
}

