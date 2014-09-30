#
# Cookbook Name:: app
# Recipe:: database_server
#
# Copyright 2014, WebAsCrazy.net
#
# All rights reserved - Do Not Redistribute
#

# Needed to install mysql
apt_package "ruby-dev" do
  action :install
end

include_recipe "database::mysql"
include_recipe "mysql::server"

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

# Create databases and import data from a file

# Create a mysql database
mysql_database 'maindb' do
  connection mysql_connection_info
  action :create
end

# import an sql dump from your app_root/data/dump.sql to the my_database database
execute 'import' do
  command "mysql -u root -p\"#{node['mysql']['server_root_password']}\" maindb < /vagrant/db/maindb.sql"
  action :run
end

# Create users

# Create a mysql user but grant no privileges
mysql_database_user 'www' do
  connection mysql_connection_info
  password   'www'
  action     :create
end

# Grant privilages
mysql_database_user 'www' do
  connection    mysql_connection_info
  password      'www'
  database_name 'maindb'
  host          '%'
  # privileges    [:create,:select,:update,:insert]
  privileges    [:select, :insert, :update, :delete, :create, :drop, :index, :alter]
  action        :grant
end

# Copy sql files

# Import sql files

# Query a database

mysql_database 'flush the privileges' do
  connection mysql_connection_info
  sql        'flush privileges'
  action     :query
end
