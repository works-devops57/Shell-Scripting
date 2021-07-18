#!/bin/bash

## Declare a function

sample() {
  echo Hello, I am a sample function
  echo value of a = ${a}
  b=200
  echo First Arguments in Function = $1
}

## Call the function
a=100
sample ABC
echo value of b=${b}
echo First Argument in Main Program=$1