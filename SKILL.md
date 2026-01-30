---
name: logi-optimizer
description: 協助用戶移除臃腫的 Logitech 官方應用程式（G HUB, Logi Options+），並清理殘留檔案，隨後安裝輕量化的 Logi Options+ Mini 工具。適用於用戶抱怨 Logitech 軟體佔用資源或想要更乾淨的系統時。
---

# Logitech Optimization Skill

本 Skill 旨在協助用戶安全地移除官方 Logitech 軟體並遷移至輕量化替代方案。

## 步驟 1：清理官方軟體 (Purge)

在執行任何刪除操作前，務必先進行模擬執行（Dry Run）並獲得用戶同意。

1.  **模擬執行**：
    執行清理腳本並顯示將要刪除的項目：
    ```bash
    ./scripts/official-logi-pruge.sh --dry-run
    ```

2.  **確認與執行**：
    向用戶展示上述輸出，並詢問：「是否同意執行以上清理操作？（這將移除所有 Logitech 官方驅動與軟體）」
    若用戶同意，則執行：
    ```bash
    ./scripts/official-logi-pruge.sh
    ```
    *注意：此過程可能會要求用戶輸入密碼（sudo）。*

## 步驟 2：安裝 Logi Options+ Mini (Install)

清理完成後，協助安裝社群維護的輕量版工具。

1. **模擬/確認安裝配置**：

    預設為「最輕量安裝」（不含額外功能）。若用戶需要特定功能（如 Flow, DFU, 背光控制），可透過 `--features` 參數指定代碼（例如 `2 5 6`）。

    

    執行模擬以確認安裝路徑與來源：

    ```bash

    ./scripts/install_logi_plus_mini.sh --dry-run

    ```



2. **執行安裝**：
    告知用戶當前的功能選擇，詢問是否繼續安裝。若同意：
    ```bash
    ./scripts/install_logi_plus_mini.sh
    ```

### 功能代碼參考表

當用戶詢問各個選項的意義時，請參考下表：

| 代碼 | 名稱 | 說明 | 建議 |
| :--- | :--- | :--- | :--- |
| **1** | analytics | 傳送使用數據與診斷資料給羅技。 | 建議關閉 |
| **2** | flow | 跨電腦控制與檔案傳輸（Logi Flow）。 | 視需求開啟 |
| **3** | sso | 帳號登入功能（雲端備份設定）。 | 建議關閉 |
| **4** | update | 軟體自動更新。 | **強烈建議關閉**（避免更新後臃腫元件回歸） |
| **5** | dfu | 設備韌體更新。 | **建議開啟** |
| **6** | backlight | 鍵盤背光調整與自定義。 | 視需求開啟（MX Keys 等） |
| **7** | logivoice | 羅技語音聽寫與翻譯功能。 | 建議關閉 |
| **8** | aiprompt | AI Prompt Builder (ChatGPT 捷徑)。 | 建議關閉 |
| **9** | recommend | 設備推薦廣告。 | 建議關閉 |
| **10** | smartactions | 智慧動作 (巨集/自動化流程)。 | 視需求開啟 |
| **11** | ring | Actions Ring 螢幕圓形選單。 | 建議關閉 |
| **12** | all | 安裝以上所有功能。 | 不建議 |

**常見建議組合：**
- **標準實用 (2 5 6)**：Flow + 韌體更新 + 背光控制。
- **極簡穩定 (5)**：僅保留韌體更新，其餘皆無。
- **絕對輕量 (Enter)**：不選任何代碼，僅安裝驅動核心。

## 故障排除

- **權限錯誤**：確保腳本具有執行權限 (`chmod +x scripts/*.sh`)。
- **Sudo 超時**：腳本內建 `sudo -v` 預熱，若執行時間過長可能需要再次輸入密碼。
- **安裝失敗**：如果 `install_logi_plus_mini.sh` 在自動輸入階段失敗（因為上游變更了問答順序），建議改為手動引導用戶執行該工具。
