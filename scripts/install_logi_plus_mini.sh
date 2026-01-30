#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Qetesh/logi-options-plus-mini.git"
DIR="${HOME}/tools/logi-options-plus-mini"
FEATURES=""
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir) DIR="$2"; shift 2;;
    --features) FEATURES="$2"; shift 2;;
    --dry-run) DRY_RUN=1; shift;; 
    *) echo "Unknown arg: $1"; exit 1;; 
  esac
done

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

echo "==> 0) sudo check"
run "sudo -v"

echo "==> 1) get/update repo"
if [[ -d "$DIR/.git" ]]; then
  run "cd \"$DIR\" && git pull --rebase"
else
  run "mkdir -p \"$(dirname "$DIR")\""
  run "git clone \"$REPO_URL\" \"$DIR\""
fi

echo "==> 2) chmod"
run "chmod u+x \"$DIR/logi-options-plus-mini.command\""

echo "==> 3) install"
echo "----------------------------------------------------------------"
echo "可用功能代碼參考 (選定: ${FEATURES:-無，將以最輕量化安裝}):"
echo "  1. analytics: 數據分享      2. flow: 跨電腦控制      3. sso: 帳號登入"
echo "  4. update: 自動更新        5. dfu: 韌體更新        6. backlight: 背光控制"
echo "  7. logivoice: 語音功能      8. aiprompt: AI 按鈕     9. recommend: 廣告"
echo "  10. smartactions: 智慧動作  11. ring: 圓形選單       12. all: 全部安裝"
echo "----------------------------------------------------------------"

run "cd \"$DIR\" && printf \"$FEATURES\ny\n\" | ./logi-options-plus-mini.command"

echo "==> Done."