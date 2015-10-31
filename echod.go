package main

import (
	"bufio"
	"flag"
	"fmt"
	"net"
	"strings"
)

func main() {
	pPort := flag.Int("p", 23000, "select port to listen on")
	flag.Parse()
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", *pPort))
	if err != nil {
		fmt.Println("Cannot listen: ", err)
	} else {
		fmt.Printf("listening on port %d\n", *pPort)
		for {
			con, err := listener.Accept()
			if err != nil {
				fmt.Println("Cannot accept: ", err)
			} else {
				go func(con net.Conn) {
					peer, _, _ := net.SplitHostPort(con.RemoteAddr().String())
					fmt.Println(peer, ": Accepted")
					for {
						message, err := bufio.NewReader(con).ReadString('\n')
						if err != nil {
							fmt.Println(peer, ": Closed")
							return
						}
						fmt.Print(peer, ": Received message ", string(message))
						newmessage := strings.ToUpper(message)
						con.Write([]byte(newmessage))
					}
				}(con)
			}
		}
	}
}
