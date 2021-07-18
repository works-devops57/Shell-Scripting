#!/bin/bash

## Declare a function

sample() {
  echo Hello, I am a sample function
  echo value of a = ${a}
}

## Call the function
a=100
sample