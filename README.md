libmarquee
-------------

libmarquee is a little text marquee renderer.

libmarquee does not care what your pixels actually are. It abstracts pixels to the library user, and just worries about pixel transformations to render and scroll text efficiently.

usage
------

libmarquee exposes several functions to display and animate long text within small bounds.

```
# pragma mark - Defined by libmarquee

//initialize libmarquee session with a provided text content area size
void mq_init(int width, int height);

//check if a given (x, y) is contained within the text content area size
//it is good practice to ensure this method returns `true` before modifying a pixel
//in your own state.
bool mq_verify_coord(int x, int y);

//render character, with the upper left corner at (x, y)
void mq_render_char(char ch, int x, int y);

//render a NULL-terminated string pointed to by str,
//containing no more than len characters, 
//with the upper left hand corner at (x, y)
void mq_render_string_static(char* str, uint32_t len, int x, int y);

//render, and animate, a NULL-terminated string pointed to by str,
//containing no more than len characters, 
//with the upper left hand corner at (x, y)
//it is the responsibility of the library user to coordinate multithreading if you 
//want to animate multiple strings
void render_string(char* str, uint32_t len, int x, int y);
```

requirements
-----------------

libmarquee requires 3 functions to be provided by the library user; linking will fail if they're not defined.

```
//library user must implement this function
//when this function is called, the pixel at coordinate (x, y) should be turned on
void mq_px_on(int x, int y);

//library user must implement this function
//when this function is called, the pixel at coordinate (x, y) should be turned off
void mq_px_off(int x, int y);

//this function is expecte to stop the world for some short time interval
//sleeping in this function is what creates the delay between frames when animating 
//with libmarquee. it is the user's responsibility to include some sort of time delay///in this function, if desired. this is also the entry point for each frame update,
//so do any needed work here, such as pushing your internal pixel state 
//somewhere else
void mq_time_step(void);
```

building
---------------
```
cd <libmarquee directory>
# this will produce libmarquee.a
make marquee 
# you can link against it like so
gcc -g my_program.o libmarquee.a -o my_program
```

MIT license.
