# Logi Optimizer Skill

這是一個 Agent 專用的 Skill，旨在協助 macOS 用戶移除臃腫的 Logitech 官方軟體（G HUB, Logi Options+），並安裝輕量化的替代方案。

## 功能

- **Clean Purge**: 徹底移除 Logitech 官方軟體及其殘留檔案（支援 G HUB 與 Options+）。
- **Mini Install**: 安裝社群維護的輕量版 Logi Options+ Mini，支援自訂功能模組（如 Flow, DFU 等）。
- **Safe Mode**: 所有破壞性操作（刪除、安裝）預設皆提供 `Dry Run`（模擬執行）與確認步驟。

## 安裝

你可以透過以下方式安裝此 Skill：

### 使用 npx
```bash
npx skill add kime541200/logi-optimizer-skill
```

### 手動安裝
將此倉庫 Clone 到你的 Skill 目錄中：
```bash
cd ~/.gemini/skills  # 或你的 skill 存放路徑
git clone https://github.com/kime541200/logi-optimizer-skill.git
```

## 使用方法

在 Agent 對話中，你可以直接使用自然語言請求：

- 「幫我清理 Logitech 的舊軟體」
- 「安裝 Logi Options+ Mini」

## 系統需求

- macOS
- 需具備 `sudo` 權限（用於清理殘留檔案與安裝）

## 致謝

本 Skill 封裝了 [Qetesh/logi-options-plus-mini](https://github.com/Qetesh/logi-options-plus-mini) 的功能。

---

**Language:** [English](README.md) | 繁體中文
