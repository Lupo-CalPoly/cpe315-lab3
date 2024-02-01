FLAGS=-g
# list .s source files here
SRCFILES=main.s intadd.s intsub.s intmul.s

all:	intcalc example

example: example.c
	gcc $(FLAGS) -o $@ $^
	 

intcalc: $(SRCFILES) 
	gcc $(FLAGS) -o $@ $^ 

clean: 
	rm -f *.o intcalc

