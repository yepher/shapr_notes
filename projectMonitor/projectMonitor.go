package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/fsnotify/fsnotify"
)

var watcher *fsnotify.Watcher

func main() {

	watcher, _ = fsnotify.NewWatcher()
	defer watcher.Close()

	dirname, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
		os.Exit(-1)
	}

	projectPath := dirname + "/Library/Containers/com.shapr3d.shapr/Data/Documents"
	fmt.Println("Will monitor: ", projectPath)
	if err := filepath.Walk(projectPath, watchDir); err != nil {
		fmt.Println("ERROR", err)
	}

	done := make(chan bool)

	go func() {
		for {
			select {
			case event := <-watcher.Events:
				fmt.Printf("EVENT! %#v\n", event)

			case err := <-watcher.Errors:
				fmt.Println("ERROR", err)
			}
		}
	}()

	<-done
}

func watchDir(path string, fi os.FileInfo, err error) error {

	if fi.Mode().IsDir() {
		return watcher.Add(path)
	}

	return nil
}
