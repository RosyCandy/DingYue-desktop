# DingYue（主仓：后端 + 桌面端 + iOS Capacitor 壳）

订阅管理 App DingYue 的**主仓库**（现仅桌面端 + iOS Capacitor 壳）。2026-10-04 起各端独立分仓：

| 项目 | 位置 | 说明 |
|---|---|---|
| 后端 API | `~/Desktop/DingYue-Server` | Express + MySQL，独立 git 仓（部署到阿里云 ECS，ngaasiu.studio/api） |
| 桌面端 | 本仓 `electron/` | Electron 壳，界面加载 DingYue-Web 构建的 dist |
| iOS Capacitor 壳 | 本仓 `ios/` | `npx cap copy ios` 流（界面同样来自 DingYue-Web） |
| **网页版** | `~/Desktop/DingYue-Web` | React 19 + Vite + Tailwind 4（官网 + 应用主界面） |
| **Android** | `~/Desktop/DingYue-Android` | Capacitor 安卓原生工程（自包含） |
| **iOS 原生** | `~/Desktop/DingYue-iOS` | SwiftUI 原生客户端 |
| **鸿蒙** | `~/Desktop/DingYue-Harmony` | ArkTS 原生客户端 |

## 常用命令

```bash
npm run ios:sync      # 把 DingYue-Web 构建的 dist 同步进 iOS 壳
npm run desktop       # 打桌面安装包（先自动构建 DingYue-Web）
bash scripts/build-desktop.sh   # 桌面全流程
bash scripts/build-ios.sh       # iOS 模拟器全流程
```

## 注意

- **网页发版**：`cd ~/Desktop/DingYue-Web && npm run build`，然后把 `dist/` 部署到
  服务器 nginx 目录（生产部署流程变更见部署文档）。
- `assetlinks.json`（android）、Google OAuth 客户端等包名配置按各端包名登记：
  Android `com.dingyue.app`、iOS 原生 `studio.ngaasiu.DingYue`、桌面 `com.dingyue.app`。
