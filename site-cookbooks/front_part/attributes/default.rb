#
# Cookbook Name:: front_part
# attributes:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#


# php-fpm
default["php-fpm"]["config"]["path"] = "/etc/php-fpm.d"
default["php-fpm"]["config"]["name"] = "www.conf"
default["php-fpm"]["config"]["naem"]["template"] = "www.conf.erb"
# nginx
default["nginx"]["source"] = "http://nginx.org/packages/centos/6/noarch/RPMS"
default["nginx"]["package"] = "nginx-release-centos-6-0.el6.ngx.noarch.rpm"
# nginx.conf path
default["nginx"]["conftemplate"] = "nginx.conf.erb"
default["nginx"]["confpath"] = "/etc/nginx"
default["nginx"]["confname"] = "nginx.conf"
default["wordpress"]["document_root"] = "/usr/share/nginx/html/wordpress"
default["nginx"]["document_root"] = "/usr/share/nginx/html"

# nginx.conf
default["nginx"]["worker_connections"] = "1024"
default["nginx"]["worker_processes"] = "1"
default["nginx"]["error_log"] = "/var/log/nginx/error.log warn"
# nginx default.conf
default["nginx"]["defaultconf_name"] = "default.conf"
default["nginx"]["defaultconf_name_erb"] = "default.conf.erb"
default["nginx"]["server_name"] = "localhost"
default["nginx"]["server_listen"] = "80"

# wordpress ダウンロード
default["wordpress"]["package"] = "wordpress-4.2.2-ja.tar.gz"
default["wordpress"]["web_server"] = "nginx"

# wordpress 設定
default["wordpress"]["db"]["host"] = ""
default["wordpress"]["db"]["name"] = "wordpress"
default["wordpress"]["user"]["name"] = "wordpress"
default["wordpress"]["user"]["password"] = "wordpress"
default["wordpress"]["wp-config"]["name"] = "wp-config.php"
default["wordpress"]["wp-config"]["erb"] = "wp-config.php.erb"
