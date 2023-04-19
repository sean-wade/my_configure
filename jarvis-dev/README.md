# 统一开发环境 Jarvis Dev

## 描述

Jarvis Dev 是一个Docker启动器，负责调用DockerCLI拉起适合研发使用的Docker环境。

支持如下特性：

* 自动补全命令
* 持久化卷支持：`jarvis_home`，重建容器后保留/root目录
* 支持SSH
* 支持X11穿透，支持OpenGL

## 部署

```bash
# 克隆项目
git clone http://gitlab.sg.cambricon.com/jarvis-project/jarvis-dev.git

# 配置Bash环境，/path/to更改为实际路径
echo "source $(pwd)/jarvis-dev/env.sh" >> ~/.bashrc

# 配置Zsh环境，/path/to更改为实际路径
echo "source $(pwd)/jarvis-dev/env.sh" >> ~/.zshrc
```

## 基本使用方式

```bash
# 进入容器
jarvis run
# 重启容器
jarvis restart
# 移除容器
jarvis remove
# 移除持久卷
jarvis purge
```

## 查看完整帮助

* [Wiki链接](http://wiki.sg.cambricon.com/pages/viewpage.action?pageId=2328465)
