#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

say() { echo -e "\n==> $*"; }

exists() { [[ -e "$1" ]]; }

say "0) 預熱 sudo"
run "sudo -v"

say "1) 終止 Logitech 相關程序"
run 'sudo pkill -f "Logi" || true'
run 'sudo pkill -f "logi" || true'
run 'sudo pkill -f "LGHUB" || true'
run 'sudo pkill -f "lghub" || true'

say "2) 執行內建/隱藏卸載器（若存在）"

# Logi Options+ hidden uninstaller
OPTS_UNINSTALLER="/Library/Application Support/Logitech.localized/LogiOptionsPlus/logioptionsplus_agent.app/Contents/Frameworks/logioptionsplus_updater.app/Contents/MacOS/logioptionsplus_updater"
if exists "$OPTS_UNINSTALLER"; then
  run "sudo \"$OPTS_UNINSTALLER\" --full --uninstall || true"
else
  echo "   - 找不到 Options+ 卸載器：$OPTS_UNINSTALLER（可能未安裝或路徑不同）"
fi

# G HUB hidden uninstaller (two known variants)
GHUB_A="/Applications/lghub.app/Contents/Frameworks/lghub_updater.app/Contents/MacOS/lghub_updater"
GHUB_B="/Applications/lghub.app/Contents/MacOS/lghub_updater.app/Contents/MacOS/lghub_updater"
if exists "$GHUB_A"; then
  run "sudo \"$GHUB_A\" --uninstall || true"
elif exists "$GHUB_B"; then
  run "sudo \"$GHUB_B\" --uninstall || true"
else
  echo "   - 找不到 G HUB 卸載器（可能 App 名稱是 Logitech G HUB.app 或未安裝）"
fi

say "3) 移除主程式（Applications）"
APPS=(
  "/Applications/Logi Options+.app"
  "/Applications/Logitech G HUB.app"
  "/Applications/lghub.app"
  "/Applications/Logitech Gaming Software.app"
)
for p in "${APPS[@]}"; do
  run "sudo rm -rf \"$p\" 2>/dev/null || true"
done

say "4) 移除系統層級支援檔案（/Library）"
SYS_PATHS=(
  "/Library/Application Support/Logitech.localized"
  "/Library/Application Support/Logi"
  "/Library/Application Support/lghub"
)
for p in "${SYS_PATHS[@]}"; do
  run "sudo rm -rf \"$p\" 2>/dev/null || true"
done
run 'sudo rm -rf "/Library/Frameworks/Logi"* 2>/dev/null || true'

say "5) 移除 PrivilegedHelperTools（常見殘留）"
run 'sudo rm -rf "/Library/PrivilegedHelperTools/com.logi."* 2>/dev/null || true'
run 'sudo rm -rf "/Library/PrivilegedHelperTools/com.logitech."* 2>/dev/null || true'

say "6) 移除使用者層級檔案（~/Library）"
USER_PATHS=(
  "$HOME/Library/Application Support/Logitech.localized"
  "$HOME/Library/Application Support/logioptionsplus"
  "$HOME/Library/Application Support/Logi"
  "$HOME/Library/Application Support/lghub"
)
for p in "${USER_PATHS[@]}"; do
  run "rm -rf \"$p\" 2>/dev/null || true"
done
run 'rm -rf "$HOME/Library/Caches/com.logi."* 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Caches/com.logitech."* 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Preferences/com.logi."* 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Preferences/com.logitech."* 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Saved Application State/com.logi."* 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Saved Application State/com.logitech."* 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Logs/Logitech" 2>/dev/null || true'
run 'rm -rf "$HOME/Library/Logs/logioptionsplus" 2>/dev/null || true'

say "7) 移除 Shared 殘留（非常重要）"
run 'sudo rm -rf /Users/Shared/logi 2>/dev/null || true'
run 'sudo rm -rf /Users/Shared/LGHUB 2>/dev/null || true'
run 'sudo rm -rf /Users/Shared/.logishrd 2>/dev/null || true'

say "8) 清理 LaunchAgents / LaunchDaemons（先 unload 再刪）"
# unload first
for p in /Library/LaunchAgents/com.logi.* /Library/LaunchAgents/com.logitech.* \
         /Library/LaunchDaemons/com.logi.* /Library/LaunchDaemons/com.logitech.*; do
  if [[ -e "$p" ]]; then
    run "sudo launchctl unload -w \"$p\" 2>/dev/null || true"
  fi
done

run 'sudo rm -f /Library/LaunchAgents/com.logi.* 2>/dev/null || true'
run 'sudo rm -f /Library/LaunchAgents/com.logitech.* 2>/dev/null || true'
run 'sudo rm -f /Library/LaunchDaemons/com.logi.* 2>/dev/null || true'
run 'sudo rm -f /Library/LaunchDaemons/com.logitech.* 2>/dev/null || true'
run 'rm -f "$HOME/Library/LaunchAgents/com.logi."* 2>/dev/null || true'
run 'rm -f "$HOME/Library/LaunchAgents/com.logitech."* 2>/dev/null || true'

say "9) 驗證（可選）"
echo "   - 若要檢查："
echo "     ps aux | egrep -i \"logi|logitech|lghub\" | egrep -v egrep"
echo "     launchctl list | egrep -i \"logi|logitech|lghub\""

say "完成。建議重新啟動 Mac。"
echo "（可選）如需重置 TCC：sudo tccutil reset Accessibility ; sudo tccutil reset InputMonitoring"