local::
	go install github.com/boynton/echod

clean::
	rm -f *~ echod $(GOPATH)/bin/echod

echod: echod.go
	env GOOS=linux GOARCH=386 go build echod.go

docker: echod
	docker build -t boynton/echod .

publish::
	docker push boynton/echod
