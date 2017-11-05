#!/bin/sh
nasm -f bin boot$1.nasm -o boot.bin
qemu-system-i386 -fda boot.bin
