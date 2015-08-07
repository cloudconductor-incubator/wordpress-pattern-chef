#
# Cookbook Name:: front_part
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#パッケージのインストール
%w{ php php-mbstring php-fpm php-mysql }.each do |pkg|
  package pkg do
    action :install
  end
end

# nginxのrpmのダウンロード
remote_file "/tmp/#{node["nginx"]["package"]}" do
  source "#{node["nginx"]["source"]}/#{node["nginx"]["package"]}"
  owner 'root'
  group 'root'
  mode '0644'
end

# nginx のリポジトリ登録とインストール
bash 'nginx_deploy_package' do
  code <<-EOH
    rpm -ivh /tmp/#{node["nginx"]["package"]}
    EOH
end

# deploy_packageが実行されたら、実行する
package "nginx" do
    action :install
end

# wordpress ダウンロード
remote_file "/tmp/#{node["wordpress"]["package"]}" do
  source "https://ja.wordpress.org/#{node["wordpress"]["package"]}"
  owner "#{node["wordpress"]["web_server"]}"
  group "#{node["wordpress"]["web_server"]}"
  mode '0644'
end

# wordpress 解凍と配置
bash 'wordpress_deploy_package' do
  cwd "/tmp"
  code <<-EOH
  tar -zxvf #{node["wordpress"]["package"]}
   cp -r wordpress  #{node["wordpress"]["document_root"]}
   chown -R #{node["wordpress"]["web_server"]}:#{node["wordpress"]["web_server"]} #{node["nginx"]["document_root"]}
   EOH
end


