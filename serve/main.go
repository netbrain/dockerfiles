package main

import (
	"os"
	"log"
	"net/http"
)

func main() {
	if len(os.Args) != 2 {
		log.Fatal("Supply a directory argument for which to serve")
	}
	fs := http.FileServer(http.Dir(os.Args[1]))
	http.Handle("/", fs)

	log.Println("Listening on :8080...")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}
