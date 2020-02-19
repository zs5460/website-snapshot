# website-snapshot

website-snapshot是一个定时生成网站快照图片并上传到七牛云的小工具

## 使用方法

```shell
docker pull zhousong/snapshot

docker run --name my-website-snapshot --env QINIU_ACCESS_KEY=YOUR_ACCESS_KEY  --env QINIU_SECRET_KEY=YOUR_SECKEY  --env QINIU_BUCKET=YOUR_BUCKET --env URL=YOUR_SITE_URL -d snapshot

```

## 说明

环境变量

变量名|说明
-|-
QINIU_ACCESS_KEY|七牛云存取key
QINIU_SECRET_KEY|七牛云密钥
QINIU_BUCKET|七牛云存储桶名称
URL|网站url
CRON_EXP|Cron表达式，如“0 0 11,18 * * ?”表示每天11点和18点执行一次
