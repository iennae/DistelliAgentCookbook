#
# Cookbook Name:: distelli
# Recipe:: default
#
# Copyright 2016, Distelli Inc.
#
# All rights reserved
#

download_url="https://www.distelli.com/download/client"
version=node[:distelli][:agent][:version]
if ! version.nil? && ! version.empty? then
    download_url << "/" + version
end

# Install the CLI:
temp=Chef::Config[:file_cache_path]
if platform?('windows') then
    remote_file "#{temp}\\install-distelli.ps1" do
        source download_url + ".ps1"
        mode 00755
    end
    powershell_script "#{temp}\\install-distelli.ps1" do
        code "#{temp}\\install-distelli.ps1"
    end
else
    remote_file "#{temp}/install-distelli.sh" do
        source download_url
        mode 00755
    end
    execute "#{temp}/install-distelli.sh"
end

# Create the agent config file
template "/etc/distelli.yml" do
    if platform?('windows') then
        path "#{ENV['SYSTEMDRIVE']}\\distelli.yml"
    end
    source "distelli.yml.erb"
    mode 00644
end

# Start the agent
execute "distelli agent install" do
    if platform?('windows') then
        command "distelli.exe agent install"
        base = "#{ENV['PROGRAMFILES']}\\Distelli"
        if not Dir.exist? base then
            base = "#{ENV['PROGRAMW6432']}\\Distelli"
        end
        environment 'PATH' => "#{base};#{ENV['PATH']}"
    else
        environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
    end
end
