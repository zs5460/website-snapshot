# website-snapshot

website-snapshot是一个定时生成网站快照图片并上传到七牛云的小工具

## 使用方法

```shell
docker pull zhousong/website-snapshot

docker run --name my-website-snapshot --env QINIU_ACCESS_KEY=YOUR_ACCESS_KEY  --env QINIU_SECRET_KEY=YOUR_SECKEY  --env QINIU_BUCKET=YOUR_BUCKET --env URL=YOUR_SITE_URL -d website-snapshot --restart=always

```

## 说明

环境变量

变量名|说明
-|-
QINIU_ACCESS_KEY|七牛云存取key
QINIU_SECRET_KEY|七牛云密钥
QINIU_BUCKET|七牛云存储桶名称
URL|网站url
