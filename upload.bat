@echo off

echo ��������ļ�
git add --all

echo �����ύ����
git commit -m "upload"

echo �����ϴ�����
git push -u origin main

echo �������Hexo����
hexo clean

echo �������ɾ�̬ҳ��
hexo g

echo ���ڲ�����վ
hexo d

echo ���
pause