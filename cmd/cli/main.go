package main

import (
	"fmt"
	"os"
)

func main() {
	args := os.Args

	// 引数を標準出力に表示
	fmt.Println("Hello, World!")
	for i, arg := range args {
		fmt.Printf("Argument %d: %s\n", i, arg)
	}
}
