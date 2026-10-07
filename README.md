# DingYue（主仓：桌面端）

订阅管理 App DingYue 的**桌面端仓库**（Electron）。2026-10-07 起 iOS Capacitor 壳已移除
（iOS 一律走原生 SwiftUI 版 `RosyCandy/DingYue-iOS`），本仓只保留桌面端。
各端独立分仓、**每仓自包含**：本仓已入库 Web 构建产物 `dist/`，克隆即可打桌面包。

| 项目 | 位置 | 说明 |
|---|---|---|
| **桌面端** | 本仓 `electron/` | Electron 壳，界面加载本仓 `dist/`（已入库） |
| **网页版** | `RosyCandy/DingYue-Web` | React 19 + Vite + Tailwind 4（官网 + 应用主界面，独立运行/部署） |
| **Android** | `RosyCandy/DingYue-Android` | Capacitor 安卓原生工程（Web 资源已入库，自包含） |
| **iOS 原生** | `RosyCandy/DingYue-iOS` | SwiftUI 原生客户端 |
| **鸿蒙** | `RosyCandy/DingYue-Harmony` | ArkTS 原生客户端 |
| **后端** | `RosyCandy/DingYue-Server` | Express + MySQL（部署在阿里云 ECS，ngaasiu.studio/api） |

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
