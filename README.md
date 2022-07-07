# 実行環境起動

```sh
docker run -it --rm --name terraform -v "$(pwd):/work" --workdir /work mikoto2000/terraform
```

# 初回準備

```sh
terraform init
gpg2 --gen-key # terraform-user-admin を作成
gpg -o ./gpg/terraform-user-admin.public.gpg  --export terraform-user-admin
gpg -o ./gpg/terraform-user-admin.private.gpg --export-secret-key terraform-user-admin
export TF_VAR_user_admin_gpg_key=$(gpg2 --export terraform-user-admin | base64 | tr -d '\n')
```

# 適用

```sh
gpg --import ./gpg/terraform-user-admin.private.gpg
export TF_VAR_user_admin_gpg_key=$(gpg2 --export terraform-user-admin | base64 | tr -d '\n')
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

terraform plan
terraform apply
```

# 初期パスワード確認

```sh
# base64 エンコード済み、かつ、暗号化済みのパスワードが記載された json を取得
ENCRYPTED_PASSWORD=$(terraform output -json rookies_encrypted_initia_password | jq -r '.[0].encrypted_password')

# encrypted password を base64 デコードして復号
echo $ENCRYPTED_PASSWORD | base64 -d | gpg -r terraform-user-admin  2> /dev/null; echo
```

# Azure Pipeline の環境変数

1. `Pipelines` -> `Library`  -> `+ Variable group` ボタン押下
2. 必要事項を記入して `Save` ボタン押下
    - `Variable group name` : `terraform`
    - `Variables`
        - `AZ_VAL_AWS_ACCESS_KEY_ID`: 管理ユーザーの アクセスキー ID
        - `AZ_VAL_AWS_SECRET_ACCESS_KEY`: 管理ユーザーのシークレットアクセスキー
        - `AZ_VAL_TF_VAR_user_admin_gpg_key`: base64 エンコードした gpg 公開鍵

