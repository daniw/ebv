all:
	bfin-uclinux-g++ -elf2flt="-s 1048576" hello_world.cpp -o app

copy:
	scp app root@192.168.1.10:/mnt/app
