modules = icons bootloader

.PHONY: $(modules) install clean all

all: $(modules)

install:
	$(MAKE) $(foreach module,$(modules),-C $(module)) install

clean:
	$(MAKE) $(foreach module,$(modules),-C $(module)) clean

$(modules):
	$(MAKE) -C $@
