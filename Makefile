test:
	python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout)' < /etc/distelli.yml | \
		jq '{"distelli":{"agent":{"endpoint":.AgentEndpoint,"access_token":.DistelliAccessToken,"secret_key":.DistelliSecretKey}}}' | \
		docker run -i -v "$$(pwd):/var/chef/cookbooks/distelli" distelli/test-chef /bin/bash -c '\
                cat > /tmp/test.json; \
                chef-solo -l debug -j /tmp/test.json -o distelli'

build:
	docker build --rm=false -t distelli/test-chef test

.PHONY: test build
