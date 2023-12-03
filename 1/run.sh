#!/bin/sh

xxd -i input.txt > input.c && gcc main.c -o tmp/main && tmp/main
