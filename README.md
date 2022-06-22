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

