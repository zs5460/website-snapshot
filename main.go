package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"time"

	"github.com/qiniu/api.v7/auth/qbox"
	"github.com/qiniu/api.v7/storage"
	"github.com/robfig/cron"
)

var (
	accessKey = os.Getenv("QINIU_ACCESS_KEY")
	secretKey = os.Getenv("QINIU_SECRET_KEY")
	bucket    = os.Getenv("QINIU_BUCKET")
	url       = os.Getenv("URL")
	prefix    = "snapshot/"
)

func main() {
	if accessKey == "" || secretKey == "" || bucket == "" || url == "" {
		log.Println("Please set environment variables first.")
		os.Exit(1)
	}

	c := cron.New()
	spec := "0 0 11 * * ?"
	c.AddFunc(spec, run)
	c.Start()

	select {}
}

func snap(url string) {
	c := exec.Command("/bin/sh", "-c", "phantomjs", "p.js", url)
	c.Dir = filepath.Dir(os.Args[0])
	c.Stdout = os.Stdout
	err := c.Run()
	if err != nil {
		log.Println(err)
	}
}

func upload(localFile, key string) {
	putPolicy := storage.PutPolicy{
		Scope: bucket + ":" + key,
	}
	mac := qbox.NewMac(accessKey, secretKey)
	upToken := putPolicy.UploadToken(mac)
	formUploader := storage.NewFormUploader(nil)
	ret := storage.PutRet{}
	err := formUploader.PutFile(context.Background(), &ret, upToken, key, localFile, nil)
	if err != nil {
		fmt.Println(key, err)
		return
	}
	fmt.Println(ret.Key, ret.Hash)
}

func run() {
	tmpfile := filepath.Join(filepath.Dir(os.Args[0]), "tmp.png")
	key := prefix + time.Now().Format("20060102") + ".png"
	log.Println("start snapshot...")
	snap(url)
	log.Println("start upload...")
	upload(tmpfile, key)
	log.Println("start clean...")
	os.Remove(tmpfile)
	log.Println("completed!")
}
