---
title: 'Go CLI'
subtitle: 'Setting up a decent Command Line Interface for your project in Go'
summary: How to set up a Command Line Interface (CLI) for your project using Go.
authors:
- admin
tags:
- Go
- Cobra
- CLI
date: "2020-06-05T00:00:00Z"
lastmod: "2020-06-05T00:00:00Z"
featured: true
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Placement options: 1 = Full column width, 2 = Out-set, 3 = Screen-width
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false

url_code: "https://github.com/akleinloog/hello"

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

Let's set up a decent Command Line Interface (CLI) for our Go project.
This has been made easy by [Cobra](https://github.com/spf13/cobra), a library that provides a simple interface to create a powerful modern CLI, like you are used to from git, kubectl, etc.

Cobra comes with a very nice set of features, amongst which:
* Easily add commands and nested commands
* Support for flags (including short & long versions)
* Intelligent suggestions (app srver... did you mean app server?)
* Automatic help generation and support of -h and \-\-help
* Automatically generated bash autocomplete and man pages

### Installation

To get started, we'll create a new go project and initialize it, in my case:
```bash
go mod init github.com/akleinloog/hello
```
Then, install the latest version of Cobra:
```bash
go get github.com/spf13/cobra/cobra
```
And initialize the new project:
```bash
cobra init --pkg-name github.com/akleinloog/hello
```

This adds a _main.go_ file and a _cmd_ folder with a _root.go_ file.
The main.go file is very simple, contains some license info and a simple main function:
```go
package main

import "github.com/akleinloog/hello/cmd"

func main() {
  cmd.Execute()
}
```

Take a look at the _root.go_ file in the _cmd_ folder, and you will notice a few things.
First, it contains a use instruction and a short and a long description.
Change the text to something meaningful for your example. In my case:
```go
var rootCmd = &cobra.Command{
  Use:   "hello",
  Short: "Go Hello",
  Long: `A simple HTTP Server written in Go.
It gives out a simple Hello message with a counter, the host name and the requested address.`,
}
```
It is good practice not to define an action here. In that case, Cobra will ensure to give out a nice set of instructions.
See for yourself:
```bash
go build

./hello
```

Another thing to notice is that cobra added an _Execute()_ function, an _init()_ function and an _initConfig()_ function.
With that, it added [Viper](https://github.com/spf13/viper) and support for a configuration file.
We'll add another flag later on, and I will discuss Viper and proper configuration in another post.

### Adding Commands
Let's first add a new command that will start our HTTP Server:
```bash
cobra add serve
```

Cobra added a _serve.go_ file in the _cmd_ folder, similar to the _root.go_ we saw earlier.
This time it adds a serve command. Let's update the text again:
```go
var serveCmd = &cobra.Command{
  Use:   "serve",
  Short: "Starts the HTTP Server.",
  Long: `Starts the HTTP Server listening at port 80, where it will return a simple hello on any request.`,
  Run: func(cmd *cobra.Command, args []string) {
    fmt.Println("serve called")
  },
}
```
In the _init()_ method you see that the command is added to the root command:
```go
func init() {
  rootCmd.AddCommand(serveCmd)
...
}
```

Rebuild and run again:
```bash
go build

./hello
```

Notice that the output has now changed.
Information is provided on the commands and on flags that are supported.

Try the help:
```bash
./hello serve -h
```
Help specific to the serve command is provided.

Now try the actual command:
```bash
./hello serve
```
You should see the simple 'serve called' output.

### Add the HTTP Server

Let's implement the HTTP server. We'll keep it simple.
In _serve.go_ add the following functions:
```go
var (
  requestNr int64  = 0
  host      string = "unknown"
)

func listen() {

  currentHost, err := os.Hostname()

  if err != nil {
    log.Println("Could not determine host name:", err)
  } else {
    host = currentHost
  }

  log.Println("Starting Hello Server on " + host)

  http.HandleFunc("/", hello)

  err = http.ListenAndServe(":80", nil)
  if err != nil {
    log.Fatal(err)
  }
}

func hello(w http.ResponseWriter, r *http.Request) {

  requestNr++
  message := fmt.Sprintf("Go Hello %d from %s on %s ./%s\n", requestNr, host, r.Method, r.URL.Path[1:])
  log.Print(message)
  fmt.Fprint(w, message)
}
```

And change the serve command to:
```go
var serveCmd = &cobra.Command{
  Use:   "serve",
  Short: "Starts the HTTP Server.",
  Long: `Starts the HTTP Server listening at port 80, where it will return a simple hello on any request.`,
  Run: func(cmd *cobra.Command, args []string) {
    listen()
  },
}
```

Rebuild and run the server:
```bash
go build

./hello serve
```

The HTTP Server will start and you can visit [http://localhost](http://localhost) to see the result.

### Add an HTTP Client

Let's add another command that will serve as a client for our Server:
```bash
cobra add get
```

Add the following function to _get.go_:
```go
func get() {
  resp, err := http.Get("http://localhost")
  if err != nil {
    log.Println(err)
  }
  defer resp.Body.Close()

  scanner := bufio.NewScanner(resp.Body)
  for i := 0; scanner.Scan() && i < 5; i++ {
    fmt.Println(scanner.Text())
  }
  if err := scanner.Err(); err != nil {
    log.Println(err)
  }
}
```

And make sure it is called from the get command:
```go
  Run: func(cmd *cobra.Command, args []string) {
    get()
  },
```

Rebuild and start the server:
```bash
go build

./hello serve
```

Then from another console window:
```bash
./hello get
```
And you will see the hello as output!

### Add a Flag

To finish up, let's add a flag to specify the port number that our server will listen on.

We'll keep it simple for now, we want:
* Works for both the client and the server
* Supports the full --port and the shorthand -p
* Default port is 80

In _get_.go_, declare a variable to be used as port number:
```go
var clientPort int
```
And add the port flag to the _init()_ function:
```go
  getCmd.Flags().IntVarP(&clientPort,"port","p", 80, "port number")
```
Do the same thing in _serve.go_, but use serverPort as variable name.

Rebuild and check the help output:
```bash
go build

./hello
./hello serve -h
./hello get -h
```

Let's adjust the server so it uses the new port flag.
In the _listen()_ function in _serve.go_, replace
```go
  err = http.ListenAndServe(":80", nil)
```
with 
```go
  log.Printf("Listening on port %d\n", serverPort)
  
  err = http.ListenAndServe(fmt.Sprintf(":%d", serverPort), nil)
```

Now for the client, in the get()_ function in _get.go_, replace
```go
  resp, err := http.Get("http://localhost")
```
with 
```go
  resp, err := http.Get(fmt.Sprintf("http://localhost:%d", clientPort))
```

Rebuild and start the server:
```bash
go build

./hello serve -p 10080
```
The server will now be available on [http://localhost:10080](http://localhost:10080)

Then from another console window:
```bash
./hello get -p 10080
```
 You should see something similar to:
 Then from another console window:
```plaintext
Go Hello 1 from my-mac.home on GET ./
```

### The code

The code of my simple Hello Server is available on GitHub [here](https://github.com/akleinloog/hello).
I may add a few features there since I intend to use it for some Kubernetes experiments.
Another similar example is my simple [HTTP Logger](/project/http-logger).
