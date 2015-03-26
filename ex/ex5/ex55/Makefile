INC_LOC = ../../../leanxcam/oscar/include
LIB_LOC = ../../../leanxcam/oscar/library
OBJ_OSC = libosc_target.a
SRC_NAME = main

all:
	bfin-uclinux-gcc -c -std=gnu99 -I$(INC_LOC) -DOSC_TARGET -O2 -elf2flt="-s 1048576" $(SRC_NAME).c
	bfin-uclinux-gcc -elf2flt="-s 1048576" $(SRC_NAME).o $(LIB_LOC)/$(OBJ_OSC) -o app

install:
	scp app root@192.168.1.10:/mnt/app

clean:
	rm -f *.o
	rm -f *.gdb
