#
# Cookbook Name:: back_part
# Recipe:: configure
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
## my.confの配置
cookbook_file "/etc/my.cnf" do
  mode "0755"
  action :create
end

#mysql サービスの起動時の設定等
service "mysqld" do
  action [ :enable, :start ]
end


# 相手のIP 取得
node['cloudconductor']['servers'].select { |_, s| s['roles'].include?('web') }.each do |_, value|
  node.set["wordpress"]["db"]["host"] = value[:private_ip]
end

#sqlファイル 実行
execute "create-db" do
  command "mysql < #{node["wordpress"]["sql"]["path"]}/#{node["wordpress"]["sql"]["name"]}"
  action :nothing
end

# create-wordpress.sql を相手ノードに作成
template "#{node["wordpress"]["sql"]["path"]}/#{node["wordpress"]["sql"]["name"]}" do
  source node["wordpress"]["sql"]["erb"]
  owner "root"
  group "root"
  action :create
  notifies :run, "execute[create-db]", :immediately
end