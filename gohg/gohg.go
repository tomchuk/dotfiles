package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func check(e error) {
	if e != nil {
		log.Fatal(e)
	}
}

func root() string {
	dir, err := os.Getwd()
	check(err)
	dir, err = filepath.Abs(dir)
	check(err)
	for dir != "/" {
		hgdir := filepath.Join(dir, ".hg")
		stat, err := os.Stat(hgdir)
		if err == nil && stat.IsDir() {
			return dir
		}
		dir, err = filepath.Abs(filepath.Join(dir, ".."))
		check(err)
	}
	log.Fatal("Not in a mercurial repo")
	return ""
}

func book() string {
	bm, err := ioutil.ReadFile(filepath.Join(root(), ".hg/bookmarks.current"))
	check(err)
	return strings.TrimSpace(string(bm))
}

func topic() string {
	tp, err := ioutil.ReadFile(filepath.Join(root(), ".hg/topic"))
	check(err)
	return strings.TrimSpace(string(tp))
}

func branch() string {
	br, err := ioutil.ReadFile(filepath.Join(root(), ".hg/branch"))
	check(err)
	return strings.TrimSpace(string(br))
}

func where() string {
  b, err := ioutil.ReadFile(filepath.Join(root(), ".hg/topic"))
  if err == nil && len(b) > 0 {
    return "✪ " + strings.TrimSpace(string(b))
  } else {
    b, err = ioutil.ReadFile(filepath.Join(root(), ".hg/bookmarks.current"))
    if err == nil {
      return "➘ " + strings.TrimSpace(string(b))
    } else {
      b, err = ioutil.ReadFile(filepath.Join(root(), ".hg/branch"))
      if err == nil {
        return " " + strings.TrimSpace(string(b))
      }
    }
  }
  log.Fatal("No topic, bookmark or branch found")
  return ""
}

func dirty() bool {
	// Run hg status in background to refresh fsmonitor.state
	state, err := ioutil.ReadFile(filepath.Join(root(), ".hg/fsmonitor.state"))
	check(err)
	parts := bytes.Split(state, []byte("\x00"))
	return len(parts) >= 8
}

func main() {
	var arg string
	if len(os.Args[1:]) == 0 {
		arg = "prompt"
	} else {
		arg = os.Args[1]
	}
	switch arg {
	case "root":
		fmt.Print(root())
	case "book":
		fmt.Print(book())
	case "branch":
		fmt.Print(branch())
	case "topic":
	  fmt.Print(topic())
	case "where":
		fmt.Print(where())
	case "dirty":
		fmt.Printf("%t", dirty())
	case "prompt":
		fmt.Printf("%s %t", where(), dirty())
	default:
		log.Fatal("Unrecognized command: " + arg)
	}
}
