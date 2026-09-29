#!/bin/sh
set -e

IMAGE="ghcr.io/wjjxqx2/alist-tvbox:latest"
CONTAINER_NAME="alist-tvbox"
HOST_PORT=4566
CONTAINER_PORT=4567
DATA_DIR="/opt/xiaoya"

echo "====================================="
echo " Alist-TVBox 一键安装（GitHub 版）"
echo "====================================="

# 必须是 root
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ 请使用 root 运行： sudo sh $0"
    exit 1
fi

# 检查 docker 命令
if ! command -v docker >/dev/null 2>&1; then
    echo "❌ 未找到 docker，请先在 OpenWrt / Linux 上安装 Docker"
    exit 1
fi

# 检查 dockerd 是否在跑
if ! docker info >/dev/null 2>&1; then
    echo "⚠️ Docker 未运行，尝试启动 dockerd ..."
    if [ -x /etc/init.d/dockerd ]; then
        /etc/init.d/dockerd start
        sleep 3
    else
        echo "❌ 找不到 /etc/init.d/dockerd，请手动启动 Docker"
        exit 1
    fi

    if ! docker info >/dev/null 2>&1; then
        echo "❌ Docker 仍无法使用，检查存储驱动 / 分区空间"
        exit 1
    fi
fi

# 创建数据目录
mkdir -p "$DATA_DIR"

# 拉取镜像（全自动化核心）
echo "📥 拉取镜像：$IMAGE"
docker pull "$IMAGE"

# 如果旧容器存在就删
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "♻️ 删除旧容器：$CONTAINER_NAME"
    docker rm -f "$CONTAINER_NAME"
fi

# 启动容器
echo "🚀 启动容器：$CONTAINER_NAME"
docker run -d \
    -p "${HOST_PORT}:${CONTAINER_PORT}" \
    --restart=always \
    --name "${CONTAINER_NAME}" \
    -v "${DATA_DIR}:/www/static" \
    -v "${DATA_DIR}:/opt/alist/data" \
    -v "${DATA_DIR}:/www" \
    "$IMAGE"

# 获取 LAN IP（OpenWrt 优先）
LAN_IP=$(uci get network.lan.ipaddr 2>/dev/null)
if [ -z "$LAN_IP" ]; then
    LAN_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
fi

echo "====================================="
echo "✅ 安装完成"
echo "🌐 管理地址： http://${LAN_IP}:${HOST_PORT}"
echo "👤 默认账号： admin"
echo "🔑 默认密码： admin"
echo "📁 数据目录： ${DATA_DIR}"
echo "====================================="
