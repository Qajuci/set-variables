#!/bin/bash

# rcloneのコンフィグファイルを作成
mkdir -p ~/.config/rclone

# r2など新しいプロバイダに対応するため更新
rclone selfupdate

# Cloudflare r2の変数をコンフィグに記入
cat > ~/.config/rclone/rclone.conf <<EOF
[r2]
type = s3
provider = Cloudflare
access_key_id = ${R2_ACCESS_KEY}
secret_access_key = ${R2_SECRET_KEY}
endpoint = https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com
region = auto
EOF

# rcloneデフォルトオプション
cat >> ~/.bashrc <<'EOF'
export RCLONE_TRANSFERS=16
export RCLONE_CHECKERS=32
export RCLONE_S3_UPLOAD_CONCURRENCY=8
export RCLONE_S3_CHUNK_SIZE=256M
EOF

# 現在のシェルにも反映
source ~/.bashrc

echo "Setup completed."