@echo off

echo 正在添加文件
git add --all

echo 正在提交更改
git commit -m "upload"

echo 正在上传更改
git push -u origin main

echo 正在清除Hexo缓存
hexo clean

echo 正在生成静态页面
hexo g

echo 正在部署网站
hexo d

echo 完成
pause