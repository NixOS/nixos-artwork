#!/usr/bin/env make
# Requirements: Imagemagick

prefix ?= /usr

sizes = 16 24 32 48 64 72 96 128 256 512 1024
theme = hicolor
category = apps

icons = \
  $(foreach size,$(sizes),$(size)x$(size)/$(category)/nix-snowflake.png) \
  scalable/$(category)/nix-snowflake.svg \
  $(foreach size,$(sizes),$(size)x$(size)/$(category)/nix-snowflake-white.png) \
  scalable/$(category)/nix-snowflake-white.svg

install_dest = $(DESTDIR)$(prefix)/share/icons/$(theme)

all: $(icons)

%/$(category)/nix-snowflake.png: ../logo/nix-snowflake-colours.svg
	@mkdir -p $(@D)
	convert -background none -resize $* $< $@

scalable/$(category)/nix-snowflake.svg: ../logo/nix-snowflake-colours.svg
	@mkdir -p $(@D)
	cp $< $@

%/$(category)/nix-snowflake-white.png: ../logo/nix-snowflake-white.svg
	@mkdir -p $(@D)
	convert -background none -resize $* $< $@

scalable/$(category)/nix-snowflake-white.svg: ../logo/nix-snowflake-white.svg
	@mkdir -p $(@D)
	cp $< $@

$(install_dest)/%: %
	install -D $< $@

install: $(foreach icon,$(icons),$(install_dest)/$(icon))

clean:
	rm -f $(icons)

.PHONY: all install clean
