## DingYue v1.4.1 打包 + Play 合规改动

### A. 账号注销合规（Google Play 要求）
1. **新建注销页** `DingYue-Web/public/close/index.html`（静态页，无需改 vite input，nginx 直接伺服）：
   - 邮箱+密码登录 → 调既有 `DELETE /api/users/account`（同域 /api 无 CORS 问题）→ 显示注销成功
   - 双语（中/英）、醒目的"不可恢复"警示、品牌风格与现有 privacy 页一致
2. **隐私政策加醒目链接**：`public/privacy/index.html`（数据删除章节+页脚）和应用内隐私文档 `src/components/LegalDocument.tsx`（PRIVACY_SECTIONS）都加入 https://www.ngaasiu.studio/close
3. **后端补漏**（DingYue-Server/server/index.ts 删号端点）：级联删不到的 `email_verification_codes`、`subscription_reminders` 和 uploads 头像文件一并清理；本地验证
4. **部署后端**：diff 确认本地与生产无意外差异后，按 README runbook `rsync → systemctl restart DingYue-api`，curl 校验接口存活

### B. 测试账号（生产库）
- 建 `testing@ngaasiu.studio` / `test1234`（bcrypt 哈希用本地 node 生成，按记忆里的 heredoc 单引号坑位注入服务器 MySQL，避免 $2b$ 被 shell 展开）
- 灌全功能演示数据：多币种（CNY/USD/JPY…）、多周期（月/季/年/免费试用）、多状态（即将到期/已过期/正常）、回收站若干条、自定义分类、支付方式

### C. 打包 1.4.1（APK + AAB）
1. Web 重建：`VITE_API_BASE_URL="https://ngaasiu.studio/api" npm run build`（含 A 项新页面）→ rsync 进 DingYue-Android assets；修正 README 里"默认相对路径即可"的误导注释
2. **创建签名 keystore**（本机没有任何 .jks）：JDK21 keytool、RSA 2048、30 年、alias `dingyue-upload`，存 `/Users/san/Desktop/APP 上架/安卓签名证书/DingYue-upload.jks`，密码写入同目录 `签名信息.txt`
3. `keystore.properties` + app/build.gradle 加 signingConfigs.release
4. `rm -rf app/build`（已知增量坑）→ `bundleRelease` + `assembleRelease`（JDK 21）→ jarsigner 验签 → 复制桌面 `DingYue-v1.4.1.aab` / `.apk`

### D. 交付物
- 桌面上的 AAB/APK 两个文件
- 内部测试版本说明文案（zh-CN/zh-TW/en/ko 四语言，直接粘贴）
- 你需要在 Play Console 手动完成清单：上传 AAB、版本说明、数据安全表单填注销网址、应用访问权限填测试账号、内部测试员加 testing@ngaasiu.studio

SSH 按 README 用 `ssh -p 9760 root@47.253.184.255`（config 里的 admin 备用）。