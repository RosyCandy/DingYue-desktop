#!/usr/bin/env bash
# 一键攒批推送：遍历 DingYue 全部仓库，各自 add+commit（无改动跳过）再 push。
# 用法: bash scripts/push-all.sh "commit message"（不传则用默认信息）
# 注意: 各仓 remote 需已配置；推送走 https + 钥匙串里的 GitHub PAT。
# 连续快速推送可能触发 GitHub 临时限流，失败自动重试 3 次（间隔 8s）。
set -u
MSG="${1:-chore: 常规迭代同步}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPOS=(
  "$ROOT"                       # 主仓（桌面 Electron + iOS 壳 + scripts）
  "$ROOT/../DingYue-Web"
  "$ROOT/../DingYue-Server"
  "$ROOT/../DingYue-Android"
  "$ROOT/../DingYue-iOS"
  "$ROOT/../DingYue-Harmony"
)
for repo in "${REPOS[@]}"; do
  name=$(basename "$repo")
  if [ ! -d "$repo/.git" ]; then
    echo "⚠️  $name: 不是 git 仓库，跳过"
    continue
  fi
  cd "$repo" || continue
  if [ -n "$(git status --porcelain)" ]; then
    git add -A
    git commit -q -m "$MSG" && echo "✅ $name: 已提交" || echo "⚠️  $name: 提交失败"
  else
    echo "— $name: 无改动"
  fi
  if ! git remote get-url origin >/dev/null 2>&1; then
    echo "⚠️  $name: 未配置 origin，未推送"
    continue
  fi
  ok=0
  for attempt in 1 2 3; do
    err=$(GIT_TERMINAL_PROMPT=0 git push origin HEAD 2>&1) && { ok=1; break; }
    echo "… $name: 第 ${attempt} 次推送失败（$(echo "$err" | tail -1 | head -c 80)），8s 后重试"
    sleep 8
  done
  if [ "$ok" = "1" ]; then
    echo "🚀 $name: 已推送"
  else
    echo "❌ $name: 推送失败——网络不通就挂代理试：git -c http.proxy=http://127.0.0.1:7890 push"
  fi
done
