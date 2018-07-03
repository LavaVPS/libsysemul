NAME = sysemul
LIBNAME = lib$(NAME)
TARGET += $(LIBNAME).so
CFLAGS += -W
CFLAGS += -Wall
CFLAGS += -O3
CFLAGS += -DPIC -fPIC -D_REENTRANT
CFLAGS += -Wl,-soname,$(LIBNAME).so.0
LDFLAGS += -lc -lgcc -nostdlib
libdir ?= /lib

all: $(TARGET) test-prlimit64

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

%.so: %.o
	$(CC) $(CFLAGS) -shared $< -o $@ $(LDFLAGS)

test-prlimit64: test-prlimit64.c
	$(CC) -o $@ $^ -W -Wall -O3

install:
	install -o root -g root -m 755 -d $(DESTDIR)${libdir}/
	install -o root -g root -m 755 $(LIBNAME).so $(DESTDIR)${libdir}/$(LIBNAME).so.0

clean:
	$(RM) $(TARGET)

.PHONY: all install clean
