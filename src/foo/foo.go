package main

/*
#include <stdlib.h>
*/
import "C"

import "syscall"

var initCh = make(chan int, 1)

func init() {
	initCh <- 42
}

func main() {}

//export DidInitRun
func DidInitRun() bool {
	select {
	case x := <-initCh:
		if x != 42 {
			// Just in case initCh was not correctly made.
			println("want init value of 42, got: ", x)
			syscall.Exit(2)
		}
		return true
	default:
		return false
	}
}
