ECHOD=$(GOPATH)/bin/echod
EC2=$(GOPATH)/bin/ec2

local: $(ECHOD)

clean::
	rm -f *~ echod $(ECHOD) .docker .aws

check::
	go fmt github.com/boynton/echod
	go vet github.com/boynton/echod

echod: echod.go
	env GOOS=linux GOARCH=386 go build echod.go

.docker: echod
	docker build -t boynton/echod .
	touch .docker

docker: .docker

publish::
	docker push boynton/echod

$(ECHOD): echod.go
	go install github.com/boynton/echod

run: $(ECHOD)
	$(ECHOD)

run-docker: docker
	docker run -p 23000:23000 boynton/echod

$(EC2):
	go get github.com/boynton/hacks/ec2

INSTANCE_ID=`$(GOPATH)/bin/ec2 id`
INSTANCE_IP=`$(GOPATH)/bin/ec2 ip`
SSH=ssh -t -o StrictHostKeyChecking=no -i $(HOME)/.ssh/ec2-user.pem ec2-user@$(INSTANCE_IP)

.aws:
	$(GOPATH)/bin/ec2 up
	$(SSH) sudo yum -y update
	$(SSH) sudo yum -y install docker
	$(SSH) sudo service docker start
	$(SSH) sudo usermod -a -G docker ec2-user
	echo $(INSTANCE_ID) > .aws

run-aws: docker $(EC2) .aws
	$(EC2) ssh docker run -p 23000:23000 boynton/echod

stop-aws::
	$(EC2) down
	rm -f .aws
