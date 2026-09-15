#!/bin/sh
set -eu
cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

if ! command -v docker >/dev/null 2>&1; then
  echo '找不到 Docker。请先安装并启动 Docker Desktop。' >&2
  exit 1
fi
if ! docker compose version >/dev/null 2>&1; then
  echo '需要 Docker Compose v2，请更新 Docker Desktop。' >&2
  exit 1
fi

# macOS 的目录共享由 Docker Desktop 管理；Linux 使用当前用户的权限。
if [ "$(uname -s)" = Linux ]; then
  BROWSER_UID=$(id -u)
  BROWSER_GID=$(id -g)
  export BROWSER_UID BROWSER_GID
fi

case "${1:-start}" in
  start)
    if ! docker info >/dev/null 2>&1; then
      echo 'Docker 尚未就绪，请启动 Docker Desktop，等待启动完成后重试。' >&2
      exit 1
    fi
    mkdir -p data
    docker compose up -d
    echo ''
    echo '容器已启动，首次初始化可能需要约一分钟。'
    echo '访问地址：http://localhost:3001'
    echo '查看日志：sh browser.sh logs'
    echo '停止服务：sh browser.sh stop（保留浏览器数据）'
    ;;
  stop) docker compose down ;;
  logs) docker compose logs --tail=100 -f ;;
  status) docker compose ps ;;
  *) echo '用法：sh browser.sh [start|stop|logs|status]' >&2; exit 2 ;;
esac
