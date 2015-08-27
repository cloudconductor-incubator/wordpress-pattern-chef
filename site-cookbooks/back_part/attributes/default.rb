#
# Cookbook Name:: back_part
# attributes:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# create-wordpress.sql
default["wordpress"]["db"]["name"] = "wordpress"
default["wordpress"]["user"]["name"] = "wordpress"
# front側のIPアドレスを指定する必要あり
default["wordpress"]["db"]["host"] = ""
default["wordpress"]["user"]["password"] = "wordpress"

# sqlファイルの作成先
default["wordpress"]["sql"]["path"] = "/tmp"
default["wordpress"]["sql"]["name"] = "create-wordpress.sql"
