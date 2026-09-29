docker pull ghcr.io/wjjxqx2/alist-tvbox:latest

docker run -d -p 4566:4567 --restart=always --name=alist-tvbox \
  -v /opt/xiaoya:/www/static \
  -v /opt/xiaoya:/opt/alist/data \
  -v /opt/xiaoya:/www \
  ghcr.io/wjjxqx/alist-tvbox:latest

# Alist-TVBox

> 基于 [alist-tvbox](https://github.com/wjjxqx2/alist-tvbox) 的 **一键 Docker 部署脚本**  
> 适用于 **OpenWrt / Linux / ARM / x86**  
> 支持 **Alist + TVBox 数据源一键整合**

---

## 📦 项目简介

`alist-tvbox` 是一个将 **Alist** 与 **TVBox** 生态结合的项目，  
通过 Docker 一键部署，即可在局域网内提供：

- Alist 文件列表服务
- TVBox 可用接口
- Web 管理面板
- 自动重启、持久化存储

本项目提供 **GitHub 一键安装脚本**，适合：

- OpenWrt 路由器
- 软路由（x86 / ARM）
- Linux 服务器 / 开发板

---

## ✨ 功能特点

- ✅ 一键安装，无需手动 `chmod`
- ✅ 自动拉取 `ghcr.io/wjjxqx2/alist-tvbox:latest`
- ✅ 自动创建容器并映射端口
- ✅ 自动清理旧容器（支持重复执行）
- ✅ 自动尝试启动 Docker（`dockerd`）
- ✅ 支持 OpenWrt / Debian / Ubuntu / Alpine
- ✅ 数据持久化（/opt/xiaoya）
- ✅ 容器异常自动重启

---

## 🚀 一键安装（推荐）

### 方法一：curl（GitHub）
sh -c "$(curl -fsSL https://raw.githubusercontent.com/wjjxqx2/alist-tvbox/master/install_alist_tvbox.sh )"

sh -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/wjjxqx2/alist-tvbox/master/install_alist_tvbox.sh )"

sh -c "$(wget -qO- https://raw.githubusercontent.com/wjjxqx2/alist-tvbox/master/install_alist_tvbox.sh )"






![GitHub Repo stars](https://img.shields.io/github/stars/power721/alist-tvbox?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/power721/alist-tvbox?style=for-the-badge)
![GitHub contributors](https://img.shields.io/github/contributors/power721/alist-tvbox?style=for-the-badge)
![GitHub repo size](https://img.shields.io/github/repo-size/power721/alist-tvbox?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues/power721/alist-tvbox?style=for-the-badge)
![Docker Pulls - xiaoya-tvbox](https://img.shields.io/docker/pulls/haroldli/xiaoya-tvbox?style=for-the-badge)
![Docker Pulls - alist-tvbox](https://img.shields.io/docker/pulls/haroldli/alist-tvbox?style=for-the-badge)

# AList-TvBox
AList proxy server for TvBox, support playlist and search.

[中文文档](doc/README_zh.md)

[OpenList](https://github.com/power721/PowerList)

# Build
```bash
mvn clean package
```

# Run
```bash
sudo bash -c "$(curl -fsSL https://d.har01d.cn/update_xiaoya.sh)"
```
```bash
java -jar target/alist-tvbox-1.0.jar
```

# Docker
```bash
./build.sh
docker run -d -p 4567:4567 --restart=always --name=alist-tvbox alist-tvbox
```
Or run container from Docker hub.
```bash
docker run -d -p 4567:4567 --restart=always --name=alist-tvbox haroldli/alist-tvbox
```
```bash
docker run -d -p 4567:4567 -p 5344:80 -e ALIST_PORT=5344 -v /opt/alist-tvbox:/data --restart=always --name=xiaoya-tvbox haroldli/xiaoya-tvbox:latest
```
username: admin

password: admin

# TvBox Config
Use this config url `http://ip:4567/sub/0`.

### Customize
Backed URL support multiple values, use comma as separator.
e.g.: disable 2 sites by key, change 1 site name by key, add new site.
```json
{
  "sites": [
    {
      "key": "js豆瓣",
      "name": "js豆瓣"
    },
    {
      "key": "测试",
      "name": "测试",
      "type": 3,
      "api": "ATV_ADDRESS/tvbox/libs/drpy.min.js",
      "searchable": 2,
      "quickSearch": 0,
      "filterable": 1
    }
  ],
  "parses": [
    {
      "name": "测试1",
      "type": 3,
      "url": "测试"
    }
  ],
  "blacklist": {
    "sites": [
      "csp_Bili",
      "csp_Biliych"
    ],
    "parses": [
      "聚合"
    ]
  }
}
```
customize sites order by setting `order` field (lower value appears first). Built-in sources and plugins start from 1000, subscription sources start from 2000, sites without order default to 9000.
```json
{
  "sites": [
    {
      "key": "豆瓣",
      "order": 100
    },
    {
      "key": "YouTube",
      "order": 500
    }
  ]
}
```
### Python Spider Plugins
Python spider plugins are loaded through `csp_PyProxy` from the bundled `spring.jar`. The original Python entry and ext are wrapped like this:
```json
{
  "key": "YouTube",
  "name": "YouTube",
  "type": 3,
  "api": "csp_PyProxy",
  "jar": "ATV_ADDRESS/spring.jar",
  "ext": "base64({\"loader\":\"ATV_ADDRESS/Atvp.py\",\"api\":\"ATV_ADDRESS\",\"source\":\"...\",\"token\":\"...\",\"local_proxy_config\":{\"ALI\":{\"enabled\":true,\"concurrency\":20,\"chunk_size\":1024}}})"
}
```

`loader`, `local_proxy_config`, and the rest of the Python-side config are all encoded into `ext`. If `local_proxy_config` remains `{}`, local proxy acceleration is not enabled.

# Features
- Web management UI for AList-TvBox.
- TvBox subscriptions and aggregated configurations.
- Multiple AList, Emby, Jellyfin, Feiniu, BiliBili, YouTube, and live-stream sources.
- Cloud drive accounts and shares for Aliyun, Baidu, Quark, UC, 115, 123, Tianyi, 139, Thunder, PikPak, and GuangYa.
- Python spider plugin management, plugin filters, local proxy acceleration, and offline download for 115, GuangYa, and Thunder.
