# golang and libvips
* docker login
* docker build -t 23233/golang_libvips:latest
* docker images
* docker push 23233/golang_libvips:latest

## golang and libvips结合
* golang_libvips 文件
  * 使用golang - debian 后安装libvips所有依赖项 作为构建的基础
* runtime 文件
  * 使用 debian:bullseye-slim 作为最小镜像运行


## 使用步骤
* 使用 golang_libvips 作为builder 加入项目文件 mod 等下载且打包构建完成
```shell
COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /go/release/app /code/app // 这个是项目名打包后的目录
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
```
* 运行 runtime 环境 从builder把环境复制过来后 直接运行项目文件即可