#!/bin/bash
# WSL Ubuntu 部署脚本（适配 Jenkins 工作目录）
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/my-python-webapp"  # Jenkins 工作目录
DEPLOY_DIR="/opt/my-python-webapp"                              # WSL 部署目录
SERVICE_NAME="my-python-webapp"                                 # Systemd 服务名
PORT=5000                                                       # 应用端口
# 1. 停止当前服务（若存在）
sudo systemctl stop $SERVICE_NAME 2>/dev/null
# 2. 初始化部署目录
sudo mkdir -p $DEPLOY_DIR
sudo rm -rf $DEPLOY_DIR/*
# 3. 复制代码到部署目录
sudo cp -r $JENKINS_WORKSPACE/* $DEPLOY_DIR/
# 4. 安装 Python 依赖
cd $DEPLOY_DIR || exit 1
sudo pip3 install --upgrade pip
sudo pip3 install -r requirements.txt
# 5. 启动服务（通过 Systemd 管理）
sudo systemctl start $SERVICE_NAME
# 6. 验证部署
if sudo systemctl is-active --quiet $SERVICE_NAME; then
    echo "🎉 部署成功！Windows 访问：http://localhost:$PORT"
else
    echo "❌ 部署失败！查看日志：sudo systemctl status $SERVICE_NAME"
    exit 1
fi