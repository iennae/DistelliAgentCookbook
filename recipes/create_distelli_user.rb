#
# Cookbook Name:: distelli
# Recipe:: create_distelli_user
#
# Copyright 2016, Distelli Inc.
#
# All rights reserved
#
# This recipe is NOT manditory to run (and only works on UNIX
# systems). However, if you want to create the distelli user account
# before the agent install, this is our recommended set-up (although
# you can customize this as you see fit).

user "distelli" do
    supports :manage_home => true
    comment "Distelli User"
    home "/home/distelli"
    shell "/bin/bash"
end

# NOTE: for this to work /etc/sudoers needs to have this line:
#
#    #includedir /etc/sudoers.d
#
# Most modern linux installs have that by default (but not OS-X).
#
# Also note that sudo access by the distelli user is not strictly
# manitory, but it is recommended so your deployment scripts can
# use sudo.
file "/etc/sudoers.d/distelli" do
    content "distelli ALL=(ALL) NOPASSWD:ALL\nDefaults:distelli !requiretty\n"
    mode "0400"
    owner "root"
end
