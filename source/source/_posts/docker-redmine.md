---
title: docker redmine
categories:
- docker
---
需要事先启动一个mysql容器 并开启root用户远程访问
### 创建数据存储目录
```
mkdir -p /srv/repo/redmine/
```
### 使用官方镜像启动容器
```
docker run \
-d \
-p 80:3000 \
-v /srv/repo/redmine:/usr/src/redmine/files \
-e REDMINE_DB_PORT=3306 \
-e REDMINE_DB_USERNAME=root \
-e REDMINE_DB_DATABASE=redmine \
-e REDMINE_DB_PASSWORD=19b2ca8b28fbf7cc2c2cfe8daf2dd3a3 \
--name redmine \
--link mysql \
--restart=always \
redmine:3.4.3-passenger
```
### 邮件功能配置
拷贝容器中 Redmine 配置文件目录下的模板配置文件到宿主机下修改为自己的配置
```
mkdir -p /srv/conf/redmine/
docker cp redmine:/usr/src/redmine/config/configuration.yml.example /srv/conf/redmine/configuration.yml
```
修改后的配置文件如下
```
default:
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: 'smtp.yeah.net'
      port: 25
      authentication: :login
      domain: 'smtp.yeah.net'
      user_name: 'pm_admin@yeah.net'
      password: 'your password'
```
删除原有容器  将配置文件挂载到 Redmine 容器配置目录下 
```
docker run \
-d \
-p 80:3000 \
-v /srv/repo/redmine:/usr/src/redmine/files \
-v /srv/conf/redmine/configuration.yml:/usr/src/redmine/config/configuration.yml \
-e REDMINE_DB_PORT=3306 \
-e REDMINE_DB_USERNAME=root \
-e REDMINE_DB_DATABASE=redmine \
-e REDMINE_DB_PASSWORD=19b2ca8b28fbf7cc2c2cfe8daf2dd3a3 \
--name redmine \
--link mysql \
--restart=always \
redmine:3.4.3-passenger
```