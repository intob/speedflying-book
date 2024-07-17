package main

import (
	"flag"
	"log"
	"net/http"
)

type middleware struct {
	handler http.Handler
}

func (m middleware) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Cache-Control", "max-age=86400") // 1d
	m.handler.ServeHTTP(w, r)
}

func main() {
	flag.Parse()
	fs := http.FileServer(http.Dir("."))
	m := middleware{handler: fs}
	http.Handle("/", m)
	log.Print("starting server on http://localhost:8080\n")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}
