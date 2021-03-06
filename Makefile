FLAGS = -mmcu=attiny13a -DF_CPU=750000UL -O2 -std=c99 $(DEBUG) $(ALTCODE)

all: flashy

flashy: tree.hex

slowglow: tree.hex 

slowglow: ALTCODE = -DALTCODE

%.hex: %.elf ws2812.h
	avr-objcopy -O ihex $< $@

clean:
	rm -f *.elf *.hex

random.c: random.h

%.elf: %.c random.c
	avr-gcc $(FLAGS) $^ -o $@
	avr-size -C --mcu=attiny13a $@
