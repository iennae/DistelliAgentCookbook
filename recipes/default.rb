#
# Cookbook Name:: distelli_agent
# Recipe:: default
#
# Copyright 2014, Distelli Inc.
#
# All rights reserved
#

# mkdir $AGENT_DIR
directory "/usr/local/DistelliAgent/" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

# mkdir $LOG_DIR
directory "/usr/local/DistelliAgent/logs" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

# add the distelli group
group node[:distelli][:agent][:group] do
  action :create
end

# add the distelli user
user node[:distelli][:agent][:user] do
  gid node[:distelli][:agent][:group]
  supports :manage_home => true
  comment "Distelli User"
  home "/home/#{node[:distelli][:agent][:user]}"
  shell "/bin/bash"
end

# Download the agent package
remote_file "/tmp/#{node[:distelli][:agent][:package]}" do
  source "#{node[:distelli][:agent][:url]}#{node[:distelli][:agent][:package]}"
  mode 00644
end

# Install the agent
bash "install_agent" do
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  tar -C /usr/local/DistelliAgent/ -zxvf /tmp/#{node[:distelli][:agent][:package]} >> /usr/local/DistelliAgent/logs/install.log 2>&1
  ln -sf /usr/local/DistelliAgent/bin/dagent /usr/local/bin/ >> /usr/local/DistelliAgent/logs/install.log 2>&1
  EOH
end

# Write the sudoers file
template "/etc/sudoers.d/distelli" do
  source "distelli.sudoers.erb"
  mode 00440
end

# mkdir -p /distelli
directory "/distelli" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/_agent
directory "/distelli/_agent" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/apps
directory "/distelli/apps" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/_packages
directory "/distelli/_packages" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/_apps
directory "/distelli/_apps" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/_agent/supervisor
directory "/distelli/_agent/supervisor" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/_agent/manifests
directory "/distelli/_agent/manifests" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# mkdir -p /distelli/_agent/logs
directory "/distelli/_agent/logs" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode 00755
  action :create
end

# Create the agent log file and set the right permissions / user
file "/distelli/_agent/distelli-agent.log" do
  owner node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
  mode '0644'
  action :create
end

# Chmod all the files to the correct user
bash "install_agent" do
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  find -L /distelli -type f -exec chmod 0644 {} + >> /usr/local/DistelliAgent/logs/install.log 2>&1
  find -L /distelli -type s -exec chmod 0700 {} + >> /usr/local/DistelliAgent/logs/install.log 2>&1
  find -L /distelli -type d -exec chmod 0755 {} + >> /usr/local/DistelliAgent/logs/install.log 2>&1
  EOH
end

# Create the agent config file
template "/etc/distelli.yml" do
  source "distelli.yml.erb"
  mode 00644
end

# Start the agent
execute "dagent" do
  server_id = node[:distelli][:agent][:server_id]
  if server_id == nil || server_id.empty?
    server_id = node[:fqdn]
  end
  command "dagent start #{server_id}"
  cwd "/home/#{node[:distelli][:agent][:user]}"
  user node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
end
