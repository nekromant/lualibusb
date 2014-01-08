№LIBUSB_SRC = ./depends/libusb-0.1.12 #change with your libusb sources folder
№LUA_SRC = ./depends/lua-5.1.4/src    #change with your lua sources folder

OPTS=-Wall -D_GNU_SOURCE -c -fPIC -fno-stack-protector
OBJS=lualibusb.o
OBJS_SO = lualibusb.so


LUA_PKG=lua5.1
CFLAGS=$(OPTS) $(shell pkg-config --cflags $(LUA_PKG))
LDFLAGS=-shared -soname libluausb.so.1 -o $(shell pkg-config --libs $(LUA_PKG)) $(shell pkg-config --libs libusb)


all: lualibusb so

lualibusb: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -c -fPIC -fno-stack-protector 

so: $(OBJS)
		$(LD) $(LDFLAGS) -o $(OBJS_SO) -lusb $(OBJS)
clean:
	-rm $(OBJS) $(OBJS_SO)
