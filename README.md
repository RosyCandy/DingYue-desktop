## 常用命令

```bash
bash scripts/build-desktop.sh   # 桌面全流程（用本仓 dist，直接可跑）
bash scripts/sync-web.sh        # 网页端有更新时：构建 DingYue-Web 并同步 dist/ 与安卓壳（可选，需 DingYue-Web 在旁边）
bash scripts/push-all.sh        # 一键攒批推送全部六仓
```

## 注意

- **网页发版**：`cd ~/Desktop/DingYue-Web && npm run build`，把 `dist/` 部署到服务器 nginx；
  若桌面/安卓也要带上新界面，再跑 `bash scripts/sync-web.sh` 并在各仓 commit。
- Google OAuth 桌面端等包名配置：桌面 `com.dingyue.app`。
