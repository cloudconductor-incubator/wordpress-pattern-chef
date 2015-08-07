#
# Cookbook Name:: front_part
# Recipe::configure
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "php-fpm" do
  action [ :enable, :start ]
end

# ngixの起動
service "nginx" do
  action [ :enable, :start ]
end

# 相手のIP 取得
require 'cloud_conductor_utils/consul'
serverlist = CloudConductorUtils::Consul.read_servers
serverlist.each do |ip, value|
  if value[:roles].include?("db")
    node.set["wordpress"]["db"]["host"] = value[:private_ip]
  end
end


# nginxのnginx.conf
template "#{node["nginx"]["confpath"]}/#{node["nginx"]["confname"]}" do
  source "#{node["nginx"]["conftemplate"]}"
  owner "#{node["wordpress"]["web_server"]}"
  group "#{node["wordpress"]["web_server"]}"
  action :create
  notifies :restart, 'service[nginx]'
end
#nginx default.conf
template "#{node["nginx"]["confpath"]}/conf.d/#{node["nginx"]["defaultconf_name"]}" do
  source "#{node["nginx"]["defaultconf_name_erb"]}"
  owner "#{node["wordpress"]["web_server"]}"
  group "#{node["wordpress"]["web_server"]}"
  action :create
  notifies :restart, 'service[nginx]'
end




def secure_password(length = 20)
  pw = String.new
  while pw.length < length
    pw << ::OpenSSL::Random.random_bytes(1).gsub(/\W/, '')
  end
  pw
end

#set wordpress key
node.set_unless["wordpress"]["keys"]["auth"] = secure_password
node.set_unless["wordpress"]["keys"]["secure_auth"] = secure_password
node.set_unless["wordpress"]["keys"]["logged_in"] = secure_password
node.set_unless["wordpress"]["keys"]["nonce"] = secure_password
node.set_unless["wordpress"]["salt"]["auth"] = secure_password
node.set_unless["wordpress"]["salt"]["secure_auth"] = secure_password
node.set_unless["wordpress"]["salt"]["logged_in"] = secure_password
node.set_unless["wordpress"]["salt"]["nonce"] = secure_password


# wordpress の設定ファイルのコピー
template "#{node["wordpress"]["document_root"]}/#{node["wordpress"]["wp-config"]["name"]}" do
  source "#{node["wordpress"]["wp-config"]["erb"]}"
  owner "#{node["wordpress"]["web_server"]}"
  group "#{node["wordpress"]["web_server"]}"
  action :create
end

# php-fpm
template "#{node["php-fpm"]["config"]["path"]}/#{node["php-fpm"]["config"]["name"]}" do
  source "#{node["php-fpm"]["config"]["naem"]["template"]}"
  owner "root"
  group "root"
  action :create
  notifies :restart, 'service[php-fpm]'
end