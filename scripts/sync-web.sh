#!/usr/bin/env bash
# 把 DingYue-Web 的最新构建同步进各端壳（显式更新动作，各壳平时只用已入库的 dist）。
# 用法: bash scripts/sync-web.sh
# 同步目标（存在才同步）:
#   • 本仓 dist/                          → 桌面 Electron
#   • ../DingYue-Android/app/src/main/assets/public/ → 安卓壳烘焙资源
# 同步后记得在各仓 commit（或直接跑 push-all.sh）。
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WEB="$HOME/Desktop/DingYue-Web"

if [ ! -d "$WEB" ]; then
  echo "❌ 找不到 $WEB —— 本仓已自包含（dist 已入库），不需要也可以不跑本脚本"
  exit 1
fi

echo "==> 构建 DingYue-Web（公网 API）"
(cd "$WEB" && VITE_API_BASE_URL="https://ngaasiu.studio/api" npm run build)

echo "==> 同步进本仓 dist/（桌面 Electron）"
rsync -a --delete "$WEB/dist/" "$ROOT/dist/"

if [ -d "$ROOT/../DingYue-Android/app/src/main/assets/public" ]; then
  echo "==> 同步进安卓壳 assets/public/"
  rsync -a --delete "$WEB/dist/" "$ROOT/../DingYue-Android/app/src/main/assets/public/"
  echo "    ⚠️ 安卓仓有更新：记得在 DingYue-Android 里 commit"
fi

echo "✅ 完成。两处产物已入库变更，commit 后 push-all.sh 推送。"
