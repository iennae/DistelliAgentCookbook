test:
	python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout)' < /etc/distelli.yml | \
		jq '{"distelli":{"agent":{"version":"3.61","environments":["red-staging","green-staging"],"endpoint":.AgentEndpoint,"access_token":.DistelliAccessToken,"secret_key":.DistelliSecretKey}}}' | \
		docker run --rm=false -i -v "$$(pwd):/var/chef/cookbooks/distelli" distelli/chef-base /bin/sh -c '\
                cat > /tmp/test.json; \
                chef-solo -l debug -j /tmp/test.json -o distelli::create_distelli_user,distelli'

build:
	docker build --rm=false -t distelli/test-chef test

.PHONY: test build
