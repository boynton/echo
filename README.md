# echod
A simple echo daemon.

## Install from source

    go get github.com/boynton/echod

## Usage

    $GOPATH/bin/echod

for the default port, or to listen on, say, port 8888:

    $GOPATH/bin/echod -p 8888

It listens for connections on the port, reads a line, and echos it back, capitalized.

## Running it elsewhere

A docker image running the server can be built and published (tested on a Mac):

    make docker
	make publish

To run locally on docker (using dockertoolbox):

    make run-docker

To run the same docker image on AWS:

	make run-aws

Be sure to

	make stop-aws

after killing the run to clean up the aws side.



