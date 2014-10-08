#
# Cookbook Name:: app-recipes-backend
# Recipe:: app_server
#
# Copyright 2014, WebAsCrazy.net
#
# All rights reserved - Do Not Redistribute

include_recipe 'apache2'
include_recipe 'apache2::mod_headers'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'

# Move custom motd

cookbook_file "/etc/update-motd.d/01-custom" do
    mode 00755
end

# Additional packages

package 'php5-gd'
package 'php5-mysql'
package 'php5-common'

package "php5-memcache" do
  action :install
end

# Vhosts

# http://hhbd.pl.vmx/
web_app "000-hhbd.pl" do
  server_name "www.hhbd.pl.vmx"
  server_aliases ["hhbd.pl.vmx"]
  allow_override "All"
  docroot "/var/www/hhbd.pl/public"
  # server_port "7777"
  cookbook 'apache2'
end

# http://s.hhbd.pl.vmx/
web_app "001-s.hhbd.pl.vmx" do
  server_name "s.hhbd.pl.vmx"
  allow_override "All"
  docroot "/var/www/s.hhbd.pl"
  # server_port "7777"
  cookbook 'apache2'
end