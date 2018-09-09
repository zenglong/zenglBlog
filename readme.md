## 介绍

zenglBlog是使用zengl语言开发个人博客的实验项目

## 配置zenglServer

首先配置zenglServer，让其网站根目录指向zenglBlog：

```
................................. (zenglServer的config.zl配置，省略N行)
webroot = "/home/zengl/zenglBlog"; // web根目录，指向zenglBlog所在的目录

session_dir = "my_sessions"; // 会话目录
session_expire = 1440; // 会话默认超时时间(以秒为单位)，可以根据需要调整会话超时时间
session_cleaner_interval = 3600; // 会话文件清理进程的清理时间间隔(以秒为单位)
```

然后运行zenglServer(v0.6.0的zenglBlog对zenglServer的最低版本要求是v0.13.0，需要开启mysql和magick模块)：

```
zengl@zengl-ubuntu:~/zenglServer$ ./zenglServer -v
zenglServer version: v0.12.0
zengl language version: v1.8.2
zengl@zengl-ubuntu:~/zenglServer$ ./zenglServer
zengl@zengl-ubuntu:~/zenglServer$ tail -f logfile 
webroot: /home/zengl/zenglBlog
session_dir: my_sessions session_expire: 1440 cleaner_interval: 3600
remote_debug_enable: False remote_debugger_ip: 127.0.0.1 remote_debugger_port: 9999 zengl_cache_enable: False shm_enable: False shm_min_size: 307200
bind done
accept sem initialized.
process_max_open_fd_num: 1024 
Master: Spawning child(0) [pid 3524] 
Master: Spawning cleaner [pid 3525] 
------------ cleaner sleep begin: 1517792159
epoll max fd count : 896 
```

假设zenglServer所在的系统的ip为10.7.20.220，那么，访问 http://10.7.20.220:8083/index.zl 可以看到 hello world! 页面

访问 http://10.7.20.220:8083/admin/login.zl 可以看到后台登录页面(使用bootstrap前端框架编写的登录界面)

## 创建数据库表结构

要进入后台管理界面，还需要创建数据库表结构，首选修改zenglBlog根目录中的config.zl配置：

```
config['db_host'] = 'localhost'; // 填写mysql数据库ip
config['db_port'] = 3306;        // 填写mysql数据库端口
config['db_user'] = 'root';      // 填写mysql用户名
config['db_passwd'] = '123456';  // 填写mysql密码
config['db_name'] = 'testdb';    // 填写mysql数据库名
config['version'] = '0.6.0';     // zenglBlog版本号，无需修改
config['comment'] = TRUE; // 是否开启评论
config['site_name'] = 'zenglBlog'; // 站点名称
config['site_desc'] = 'blog made by zengl language'; // 站点描述
```

需要确保上面数据库配置的正确性，如果没有创建过testdb，就先创建该数据库

配置完后，访问 http://10.7.20.220:8083/install/create_table.zl 该脚本会自动在数据库中创建所需的表结构，例如 users(用户表)，并在users表中插入一条初始数据，该脚本执行成功后，会返回用户名，密码之类的信息，如下所示：

```
mysql客户端库的版本信息：5.7.22

mysql服务端的版本号信息：5.7.22

mysql当前设置的字符集：utf8

用户名：admin

密码：admin@123456

用户昵称：管理员

写入install.lock安装锁文件
```

安装会生成install.lock锁文件，以防止误操作，在有锁文件的情况下，执行create_table.zl脚本，会提示lock file exists，并阻止脚本继续执行

接着使用 admin 和 admin@123456 通过 http://10.7.20.220:8083/admin/login.zl 登录后台

登录成功后的后台地址：http://10.7.20.220:8083/admin/admin.zl ，后台概览页面可以看到一些基本信息，例如：mysql版本号，zenglServer版本号，zengl语言版本等等，还可以在用户列表中看到当前已有的用户信息，后台界面也是使用bootstrap前端框架编写的

## 使用nginx反向代理

虽然zenglServer可以处理html，css，js之类的静态文件，但是zenglServer主要还是用于执行zengl脚本用的，静态文件只做了一些基础的支持，因此，正式上线时，需要使用nginx作为前端处理静态文件，并将zengl脚本的请求通过反向代理转发给zenglServer，这样，zenglServer就只需要处理zengl脚本即可，静态文件就可以交由nginx去处理。

下面是nginx反向代理的基本配置(这只是示例，可以根据需要调整nginx中的配置)：

```
server {
     listen 80;
     server_name blog.zengl.dev;
     root /home/zengl/zenglBlog;
     index index.html index.zl;

     location ~ \.zl$ {
         proxy_pass   http://127.0.0.1:8083;
         proxy_set_header   X-real-ip $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         break;
     }
     access_log /usr/local/nginx/logs/www/zengl/blog.log jflog;
}
```

确保zenglServer对zenglBlog有读写权限，同时nginx对zenglBlog有读权限(让nginx能读取到静态文件即可)

使用上面nginx配置后(同时将blog.zengl.dev通过hosts之类的绑定了ip)，直接访问 http://blog.zengl.dev 就可以看到hello world!页面(因为上面nginx配置的默认首页是index.zl)，访问 http://blog.zengl.dev/admin/login.zl 可以看到后台登录页面，输入用户名和密码，点击登录，可以进入到 http://blog.zengl.dev/admin/admin.zl 的后台管理页面。点击后台界面右上角的登出，可以退出登录。

如果在新版本的Chrome浏览器中 http://blog.zengl.dev 被跳转到了 https://blog.zengl.dev 的话，可以将.dev替换为.test或者.example，原因可以参考 http://blog.justwe.site/2017/12/19/chrome-redirection-https/ 或者 https://iyware.com/dont-use-dev-for-development/ 对应的文章。

要使用https访问zenglServer的话，也可以通过nginx的反向代理来实现：

```
server {
     listen 80;
     listen 443 ssl;

     ssl_certificate /usr/local/nginx/cert/blog.zengl.test.crt;
     ssl_certificate_key /usr/local/nginx/cert/blog.zengl.test.key;

     server_name blog.zengl.test;
     root /home/zengl/zenglBlog;
     index index.html index.zl;

     location ~ \.zl$ {
         proxy_pass   http://127.0.0.1:8083;
         proxy_set_header   X-real-ip $remote_addr;
         proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
         break;
     }
     access_log /usr/local/nginx/logs/www/zengl/blog.log jflog;
}
```

## 官网

作者：zenglong

官网：www.zengl.com

