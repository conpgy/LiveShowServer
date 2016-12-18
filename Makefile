name = bookstore
port = 8090
database-type = compose-for-postgresql
database-level = Standard
database-name = Bookstore-postgresql
registry-url = registry.ng.bluemix.net
desired-instances = 3
memory = 128

# Other parameters outside of application

cloudfoundry-installer-mac = https://cli.run.pivotal.io/stable?release=macosx64&version=6.22.2&source=github-rel

all: build

login:
	cf login
	cf ic login
	cf ic init

install-tools:
	wget -O cloudfoundry-installer.pkg $(cloudfoundry-installer-mac) 
	open ./cloudfoundry-installer.pkg
	rm ./cloudfoundry-installer.pkg

clean:
	docker rm -fv $(name) || true

build: 
	docker build -t $(name) --force-rm .

run: 
	docker run --name $(name) -d -p $(port):$(port) $(name)

clean-bluemix:
	cf ic group rm $(name)

create-database: 
	cf create-service $(database-type) $(database-level) $(database-name)
	cf bind-service containerbridge $(name)

push-bluemix: 
	docker tag $(name) $(registry-url)/$(shell cf ic namespace get)/$(name)
	docker push $(registry-url)/$(shell cf ic namespace get)/$(name)

deploy-bluemix: 
	cf ic group create --anti --auto \
		--desired $(desired-instances) \
		-m $(memory) \
		--name $(name) \
		-p $(port) \
		-n $(hostname) \
		-d mybluemix.net $(registry-url)/$(shell cf ic namespace get)/$(name)

create-bridge:
	mkdir containerbridge
	cd containerbridge
	touch empty.txt
	cf push containerbridge -p . -i 1 -d mybluemix.net -k 1M -m 64M --no-hostname --no-manifest --no-route --no-start
	cd ..
	rm -rf containerbridge


