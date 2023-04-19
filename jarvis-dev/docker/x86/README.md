# 统一开发环境 Jarvis Dev for IPC

## 编译

```bash
# 编译基础镜像（仅包含ROS、CUDA、TRT等大容量组件，无变更则无需编译）
make base
# 编译开发环境镜像
make devel
```

## 上传

```bash
make upload
```

## 拉取

```bash
make pull
```

## 清理

```bash
make clean
```

## 部署

* 车载和本地开发环境请使用 [Jarvis Dev](https://gitlab.sg.cambricon.com/jarvis-auto/jarvis-dev) 仓库提供的启动器。
* CI等自动化环境可参考 [Jarvis Dev](https://gitlab.sg.cambricon.com/jarvis-auto/jarvis-dev) 仓库下 bin/jarvis 实现业务裁剪。
