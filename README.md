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
- ✅ 数据持久化（`/opt/xiaoya`）
- ✅ 容器异常自动重启

---

## 🚀 一键安装（推荐）

### 方法一：curl（GitHub）

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/wjjxqx2/alist-tvbox/master/install_alist_tvbox.sh)"
```

### 方法二：wget（GitHub）

```sh
sh -c "$(wget -qO- https://raw.githubusercontent.com/wjjxqx2/alist-tvbox/master/install_alist_tvbox.sh)"
```

### 方法三：国内加速（ghproxy）

```sh
sh -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/wjjxqx2/alist-tvbox/master/install_alist_tvbox.sh)"
```

---

## 🛠 手动安装

```sh
# 克隆仓库
git clone https://github.com/wjjxqx2/alist-tvbox.git
cd alist-tvbox

# 运行安装脚本
sh install_alist_tvbox.sh
```

---

## 🌐 访问方式

安装完成后，浏览器打开：

```
http://路由器IP:4566
```

示例：

```
http://192.168.1.1:4566
```

---

## 🔑 默认账号

| 项目 | 值 |
|------|------|
| 用户名 | `admin` |
| 密码 | `admin` |

> ⚠️ **首次登录后请立即修改密码**

---

## 📁 数据目录

默认挂载目录：

```
/opt/xiaoya
```

包含：

- `/www/static`
- `/opt/alist/data`
- `/www`

### OpenWrt 推荐配置（避免 overlay 丢数据）

```sh
# 修改为 U 盘 / 硬盘挂载点
/mnt/sda1/xiaoya
```

修改方式：编辑 `install_alist_tvbox.sh` 中的：

```sh
DATA_DIR="/opt/xiaoya"
```

---

## ⚙️ Docker 参数说明

| 参数 | 说明 |
|------|------|
| `-p 4566:4567` | 宿主机 4566 → 容器 4567 |
| `--restart=always` | 开机 / 异常自动重启 |
| `-v /opt/xiaoya` | 数据持久化 |
| `--name alist-tvbox` | 容器名称 |

---

## 🔄 升级 / 更新

```sh
docker pull ghcr.io/wjjxqx2/alist-tvbox:latest
docker rm -f alist-tvbox
sh install_alist_tvbox.sh
```

---

## ❓ 常见问题

### 1️⃣ Docker 拉取 ghcr.io 很慢 / 失败

- 使用代理
- 使用国内镜像加速
- 或手动拉取后重命名

---

### 2️⃣ OpenWrt 提示 docker 不存在

```sh
opkg update
opkg install dockerd docker-compose
```

---

### 3️⃣ 端口被占用

修改脚本中的：

```sh
HOST_PORT=4566
```

---

### 4️⃣ 数据丢失

- 不要放在 `/overlay`
- 使用外接存储并修改 `DATA_DIR`

---

## 🧩 适用设备

- ✅ OpenWrt 路由器
- ✅ 软路由（x86 / N100 / ARM）
- ✅ 树莓派 / 开发板
- ✅ 任意支持 Docker 的 Linux

---

## 📄 License

本项目基于 [alist-tvbox](https://github.com/wjjxqx2/alist-tvbox)
具体协议请参考原仓库。

---

## ⭐ Star History

如果你觉得这个项目有用，欢迎点个 Star ⭐

---

## 🙏 致谢

- [alist-tvbox](https://github.com/wjjxqx2/alist-tvbox)
- [Alist](https://github.com/alist-org/alist)
- [TVBox](https://github.com/HiTaoDev/TVBox)
