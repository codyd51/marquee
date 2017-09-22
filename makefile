all: marquee
	gcc -c client.c -o client.o
	gcc -g -o client client.o libmarquee.a

marquee: marquee.c
	gcc -c marquee.c -o marquee.o
	ar rc libmarquee.a marquee.o
	ranlib libmarquee.a

objc: marquee
	gcc -c marquee.c -o marquee.o
	clang -fobjc-arc -c draw.m -o objc_draw.o
	clang -framework Foundation -framework AppKit -g -o draw objc_draw.o libmarquee.a

clean:
	rm *.o
	rm libmarquee.a
