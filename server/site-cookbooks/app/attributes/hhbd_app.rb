default['apache']['listen_ports'] = %w(80 7777)

default['app']['hhbd-app']['app_name'] = 'hhbd-app'
default['app']['hhbd-app']['config'] = {
    :emergency_log => "/var/log/#{default['app']['hhbd-app']['app_name']}/emergency-hhbd.log",
    :debug_log => "/var/log/#{default['app']['hhbd-app']['app_name']}/debug-hhbd.log",
}
