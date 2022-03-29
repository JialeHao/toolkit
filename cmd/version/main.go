package main

import (
	"fmt"
	"os"

	"github.com/JialeHao/toolkit/utils"
)

// go build -ldflags "-X github.com/JialeHao/toolkit/utils.version=v1.0.0 -X github.com/JialeHao/toolkit/utils.platform=win11 -X github.com/JialeHao/toolkit/utils.arch=x86_64" .\cmd\version\
// .\version.exe version
// output: App version v1.0.0, build on win11/x86_64

func main() {
	args := os.Args

	if len(args) >= 2 && args[1] == "version" {
		v := utils.GetVersion()
		fmt.Printf("App version %v, build on %v/%v", v.Version, v.Platform, v.Arch)
	} else {
		fmt.Println("bad parms...")
	}
}
