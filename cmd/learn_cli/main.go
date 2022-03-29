package main

import (
	"fmt"
	"log"
	"os"

	"github.com/urfave/cli/v2"
)

// VERSION go build -ldflags "-X main.VERSION=x.x.x"
var VERSION string = "not specified"


// docker image
func main() {
	app := cli.NewApp()
	app.Name = "docker"
	app.Version = VERSION
	app.Usage = "This is a docker app"
	app.Commands = []*cli.Command{
		newImageCmd(),
	}
	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}

func newImageCmd() *cli.Command {
	return &cli.Command{
		Name: "image",
		Usage: "manage images",
		Flags: []cli.Flag{
			&cli.StringFlag{
				Name: "ls",
				Usage: "list all images",
			},
		},
		Action: func(ctx *cli.Context) error {
			if ctx.String("ls") == "" {
				fmt.Println("Ok, list all images.")
			} else {
				fmt.Printf("Ok, list %v", ctx.String("ls"))
			}
			return nil
		},
	}
}
