BOOT_ASM = boot.asm
LOADER_ASM = loader.asm

BOOT_BIN = boot.bin
LOADER_BIN = loader.bin
BOOT_IMG = boot.img

ASM_FLAGS = -f bin

all: $(BOOT_BIN) $(LOADER_BIN) $(BOOT_IMG)

$(BOOT_BIN): $(BOOT_ASM)
	nasm $(ASM_FLAGS) -o $@ $<

$(LOADER_BIN): $(LOADER_ASM)
	nasm $(ASM_FLAGS) -o $@ $<

$(BOOT_IMG): $(BOOT_BIN) $(LOADER_BIN)
	dd if=$(BOOT_BIN) of=$(BOOT_IMG) bs=512 count=1 conv=notrunc
	dd if=$(LOADER_BIN) of=$(BOOT_IMG) bs=512 count=5 seek=1 conv=notrunc

clean:
	rm -f $(BOOT_BIN) $(LOADER_BIN) $(BOOT_IMG)

.PHONY: all clean

