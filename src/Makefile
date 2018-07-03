TARGET	+= x86/libsysemul.so
TARGET	+= x64/libsysemul.so
CFLAGS	+= -Wall
CFLAGS	+= -O3
CFLAGS	+= -DPIC -fPIC -D_REENTRANT
LDSFLAGS += -lc -lgcc -nostdlib -ldl

all: $(TARGET)

x86/%.o: %.c x86
	$(CC) -m32 -c $(CFLAGS) $< -o $@

x86/%.so: x86/%.o x86
	$(CC) -m32 $(CFLAGS) -shared $< -o $@ $(LDSFLAGS)

x64/%.o: %.c x64
	$(CC) -m64 -c $(CFLAGS) $< -o $@

x64/%.so: x64/%.o x64
	$(CC) -m64 $(CFLAGS) -shared $< -o $@ $(LDSFLAGS)

x86:
	mkdir $@

x64:
	mkdir $@

clean:
	$(RM) $(TARGET)
