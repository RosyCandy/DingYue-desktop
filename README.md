# DingYue（主仓：桌面端 + iOS Capacitor 壳）

订阅管理 App DingYue 的**主仓库**（桌面 Electron + iOS Capacitor 壳）。2026-10-04 起各端独立分仓，
**每仓自包含**：本仓已入库 Web 构建产物 `dist/`，克隆本仓即可构建桌面/iOS 壳，不依赖其他文件夹。

| 项目 | 位置 | 说明 |
|---|---|---|
| 桌面端 | 本仓 `electron/` | Electron 壳，界面加载本仓 `dist/`（已入库） |
| iOS Capacitor 壳 | 本仓 `ios/` | `npx cap copy ios` 流（界面同样来自本仓 `dist/`） |
| **网页版** | `RosyCandy/DingYue-Web` | React 19 + Vite + Tailwind 4（官网 + 应用主界面，独立运行/部署） |
| **Android** | `RosyCandy/DingYue-Android` | Capacitor 安卓原生工程（Web 资源已入库，自包含） |
| **iOS 原生** | `RosyCandy/DingYue-iOS` | SwiftUI 原生客户端 |
| **鸿蒙** | `RosyCandy/DingYue-Harmony` | ArkTS 原生客户端 |
| **后端** | `RosyCandy/DingYue-Server` | Express + MySQL（部署在阿里云 ECS，ngaasiu.studio/api） |

## 常用命令

```bash
bash scripts/build-desktop.sh   # 桌面全流程（用本仓 dist，直接可跑）
bash scripts/build-ios.sh       # iOS 模拟器全流程（用本仓 dist，直接可跑）
bash scripts/sync-web.sh        # 网页端有更新时：构建 DingYue-Web 并同步 dist/ 与安卓壳（可选，需 DingYue-Web 在旁边）
bash scripts/push-all.sh        # 一键攒批推送全部六仓
```

## 注意

- **网页发版**：`cd ~/Desktop/DingYue-Web && npm run build`，把 `dist/` 部署到服务器 nginx；
  若桌面/iOS/安卓也要带上新界面，再跑 `bash scripts/sync-web.sh` 并在各仓 commit。
- `assetlinks.json`（android）、Google OAuth 客户端等包名配置按各端包名登记：
  Android `com.dingyue.app`、iOS 原生 `studio.ngaasiu.DingYue`、桌面 `com.dingyue.app`。
