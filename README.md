# echod
A simple echo daemon.

## Install from source

    go get github.com/boynton/echod

## Usage

    $GOPATH/bin/echod

for the default port, or to listen on, say, port 8888:

    $GOPATH/bin/echod -p 8888

It listens for connections on the port, reads a line, and echos it back, capitalized.



