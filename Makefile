# Andy Sayler
# CI Practice
# Summer 2014


#Compiling  (CFLAGS) - changes C code to machine language code (.o files) but not an excutable
#Linking (LFLAGS) - generates executable - takes .o files, links them, makes an executable file
CC = gcc
CFLAGS = -c -g -Wall -Wextra
LFLAGS = -g -Wall -Wextra

#-lm - includes math library
PKG_MATH_LIBS = -lm
PKG_CHECK_LIBS = `pkg-config --libs check`

#anything with : after is called a "rule"
#right side of colon: dependences

#PHONY target: 
.PHONY: all dep clean test

all: geometry_test

#rule name: geometry_test
geometry_test: geometry_test.o geometry.o #dependencies
	$(CC) $(LFLAGS) $^ $(PKG_CHECK_LIBS) $(PKG_MATH_LIBS) -o $@ #command

#-o flag to gcc: whatever you put after will be name of executable

geometry_test.o: geometry_test.c geometry.h
	$(CC) $(CFLAGS) $< -o $@

#$< : placeholder stands for first dependency: geometry_test.c
#$@ : placeholder for whatever is left of colon: geometry_test.o
#%^ : placeholder for whatever is right of colon

geometry.o: geometry.c geometry.h
	$(CC) $(CFLAGS) $< -o $@

dep:
	sudo apt-get install check

#clean removes all files we got as an output
clean:
	$(RM) *.o
	$(RM) geometry_test
	$(RM) *~

#STARTING ASST. HERE. added test and added test to PHONY
test: geometry_test
	./geometry_test