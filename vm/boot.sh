#!/bin/sh
nasm -f bin boot.nasm -o boot.bin
qemu-system-i386 -fda boot.bin
