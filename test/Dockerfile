FROM ubuntu
MAINTAINER Brian Maher <bmaher@distelli.com>

# Set-up Chef:
RUN apt-get update
RUN mkdir -p /etc/chef && \
    printf 'ssl_verify_mode :verify_peer\nverify_api_cert true\n' > /etc/chef/solo.rb && \
    echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/00assume-yes && \
    apt-get install apt-transport-https sudo git rsync wget python-software-properties build-essential
RUN wget -qO- https://www.opscode.com/chef/install.sh | bash
