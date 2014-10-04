default[:distelli][:agent][:user]             = 'distelli'
default[:distelli][:agent][:group]            = 'distelli'

default[:distelli][:agent][:version]          = '2.05'
default[:distelli][:agent][:url]              = 'http://download.distelli.com/'
default[:distelli][:agent][:package]          = "DistelliAgent-#{default[:distelli][:agent][:version]}.tar.gz"

# Required
default[:distelli][:agent][:access_token]     = ''
default[:distelli][:agent][:secret_key]       = ''

# Optional
default[:distelli][:agent][:server_id]        = ''
default[:distelli][:agent][:sudo_commands]    = 'ALL'
