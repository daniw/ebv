all:
	bfin-uclinux-gcc -c hello_math.c
	bfin-uclinux-gcc -elf2flt="-s 1048576" hello_math.o -lm -o app

copy:
	scp app root@192.168.1.10:/mnt/app
