all:
	gcc -c marquee.c -o marquee.o
	ar rc libmarquee.a marquee.o
	ranlib libmarquee.a
	gcc -c client.c -o client.o
	gcc -g -o client client.o libmarquee.a

objc:
	clang -fobjc-arc -lc++ -framework Foundation -framework AppKit draw.mm -o draw

clean:
	rm *.o
	rm libmarquee.a
