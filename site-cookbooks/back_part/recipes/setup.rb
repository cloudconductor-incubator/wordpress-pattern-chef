#
# Cookbook Name:: back_part
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#リポジトリを追加
remote_file "#{Chef::Config[:file_cache_path]}/mysql-community-release-el7-5.noarch.rpm" do
  source 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
  action :create
end

rpm_package 'mysql-community-release' do
  source "#{Chef::Config[:file_cache_path]}/mysql-community-release-el7-5.noarch.rpm"
  action :install
end

#パッケージのインストール
package "mysql-server" do
  action :install
end
