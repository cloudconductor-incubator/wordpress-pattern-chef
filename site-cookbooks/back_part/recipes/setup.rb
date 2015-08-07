#
# Cookbook Name:: back_part
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#パッケージのインストール
package "mysql-server" do
  action :install
end
