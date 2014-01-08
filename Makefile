OPTS=-Wall -D_GNU_SOURCE -c -fPIC -fno-stack-protector
OBJS=libusb.o
OBJS_SO = libusb.so


LUA_PKG=lua5.1
CFLAGS=$(OPTS) $(shell pkg-config --cflags $(LUA_PKG))
LDFLAGS=-shared -soname libusb.so.1 -o $(shell pkg-config --libs $(LUA_PKG)) $(shell pkg-config --libs libusb)


all: libusb so

libusb: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -c -fPIC -fno-stack-protector 

so: $(OBJS)
		$(LD) $(LDFLAGS) -o $(OBJS_SO) -lusb $(OBJS)
clean:
	-rm $(OBJS) $(OBJS_SO)
