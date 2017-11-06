#!/bin/sh
nasm -f bin boot$1.nasm -o boot.bin
qemu-system-i386 -drive format=raw,file=boot.bin,index=0,if=floppy
