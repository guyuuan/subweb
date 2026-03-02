# subweb
## 简介
subweb 是基于 subconverter 订阅转换的前端项目,方便用户快速生成各平台的订阅链接.

> *subweb 是我个人入门 vuejs 学习时简单做的一个案例,使用还算方便,开源出来,欢迎各路大佬贡献维护.*

*GitHub [stilleshan/subweb](https://github.com/stilleshan/subweb)  
Docker [stilleshan/subweb](https://hub.docker.com/r/stilleshan/subweb)*
> *docker image support for X86 and ARM*

## 示例
[https://sub.ops.ci](https://sub.ops.ci)  
[https://subweb-demo.vercel.app/](https://subweb-demo.vercel.app/)  
*`前后端示例,可以直接使用.`*

## 部署
### docker 本地版
*适用于本机快速部署使用*
```shell
docker run -d --name subweb --restart always \
  -p 18080:80 \
  stilleshan/subweb
```

访问 `http://127.0.0.1:18080`

### docker 自定义版 + 短链接版
自定义版可以挂载配置文件来修改`API 地址`,`短链接地址`,`站点名称`,`导航链接`.  
参考以下命令,修改本地挂载路径,启动容器后会生成`config.js`配置文件,更改后刷新生效.

```shell
docker run -d --name subweb --restart always \
  -p 18080:80 \
  -v /PATH/subweb/public/conf:/usr/share/nginx/html/conf \
  stilleshan/subweb
```

同时也可以不挂载目录,直接通过`-e`环境变量来修改`API 地址`,`短链接地址`和`站点名称`,但是无法修改`导航链接`.  
`注意:以下域名请严格填写 http 或 https 协议,结尾不要 / 斜杠符号.`
```shell
docker run -d --name subweb --restart always \
  -p 18080:80 \
  -e SITE_NAME=subweb \
  -e API_URL=https://sub.ops.ci \
  -e SHORT_URL=https://s.ops.ci \
  stilleshan/subweb
```

访问 `http://127.0.0.1:18080`  
> *推荐使用 nginx 反向代理部署*

### Vercel 部署
Vercel 部署请切换至 vercel 分支查看。

### subweb + subconverter + myurls 合并进阶版
详情查看 [stilleshan/sub](https://github.com/stilleshan/dockerfiles/tree/main/sub)

## 镜像发布（本仓库）
本项目已内置 GitHub Actions 自动发布（文件：`.github/workflows/docker-build-release.yml`）。

### 发布方式
1. `git tag v2.0.1 && git push origin v2.0.1`
2. 或在 GitHub Actions 手动触发 `docker-build-release`，输入 `release_tag`（例如 `2.0.1`）

### 发布目标
- 默认发布到 GHCR：`ghcr.io/<github-owner>/subweb:<tag>`
- 若配置了 Docker Hub secrets，则额外发布到 Docker Hub：`docker.io/<dockerhub-username>/subweb:<tag>`

### 需要的 GitHub Secrets
- `DOCKERHUB_USERNAME`（可选）
- `DOCKERHUB_TOKEN`（可选，建议使用 Access Token）

### 本地手动发布示例（Docker Hub）
```shell
docker buildx create --use --name subweb-builder || docker buildx use subweb-builder
docker login -u <dockerhub-username>
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t <dockerhub-username>/subweb:2.0.1 \
  -t <dockerhub-username>/subweb:latest \
  --push .
```

## 链接
- [stilleshan/sub](https://github.com/stilleshan/dockerfiles/tree/main/sub)
- [stilleshan/subweb](https://github.com/stilleshan/subweb)
- [stilleshan/subconverter](https://github.com/stilleshan/subconverter)
