# 个人远程浏览器体验

## 启动

先启动 Docker Desktop，然后在终端执行：

```sh
cd ~/Downloads/remote-browser
sh browser.sh
```

首次运行会下载 Chromium 镜像，耗时取决于网络。脚本提示容器启动后，等初始化完成，打开：

https://localhost:3001

本地服务使用自签名证书。首次访问时选择“高级”并继续访问 localhost。
若暂时无法连接，稍等后刷新，或运行 `sh browser.sh logs` 查看日志。

## 常用命令

在此文件夹内执行：

```sh
sh browser.sh status  # 查看状态
sh browser.sh logs    # 查看日志，Ctrl+C 退出日志
sh browser.sh stop    # 停止并移除容器，保留数据
sh browser.sh start   # 重新启动
```

## 数据与访问范围

- `compose.yaml`：Docker Compose 配置。
- `browser.sh`：启动和管理脚本，也可以运行 `./browser.sh`。
- `data/`：首次启动时创建，保存浏览器设置、登录状态和下载文件。
- 默认只绑定本机的 127.0.0.1:3001，适合先在这台 Mac 上体验。
- 目前没有设置访问密码。若以后需要其他设备访问，需另行配置监听地址和访问认证。
- Docker 会自动选择 ARM64 或 x86-64 镜像。
- 如提示端口已被占用，可把 compose.yaml 的 `127.0.0.1:3001:3001` 改为 `127.0.0.1:3002:3001`，重新启动后访问 https://localhost:3002。

官方文档：https://docs.linuxserver.io/images/docker-chromium/
