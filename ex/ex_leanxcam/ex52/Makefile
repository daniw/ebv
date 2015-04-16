all:
	bfin-uclinux-gcc -elf2flt="-s 1048576" hello_world.c -o app

copy:
	scp app root@192.168.1.10:/mnt/app
