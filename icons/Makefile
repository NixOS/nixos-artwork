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

%/$(category)/nix-snowflake.png: scalable/$(category)/nix-snowflake.svg
	@mkdir -p $(@D)
	convert -background none -resize $* $< $@

scalable/$(category)/nix-snowflake.svg: ../logo/nix-snowflake.svg
	@mkdir -p $(@D)
	xmlstarlet ed \
		-u '/svg:svg/@height' -x 'string(/svg:svg/@width)' \
		-a '/svg:svg' \
			-t attr \
			-n 'preserveAspectRatio' \
			-v "xMidYMid meet" \
		< $< > $@

%/$(category)/nix-snowflake-white.png: scalable/$(category)/nix-snowflake-white.svg
	@mkdir -p $(@D)
	convert -background none -resize $* $< $@

scalable/$(category)/nix-snowflake-white.svg: ../logo/white.svg
	@mkdir -p $(@D)
	xmlstarlet ed \
		-u '/svg:svg/@height' -x 'string(/svg:svg/@width)' \
		-a '/svg:svg' \
			-t attr \
			-n 'preserveAspectRatio' \
			-v "xMidYMid meet" \
		< $< > $@

$(install_dest)/%: %
	install -D $< $@

install: $(foreach icon,$(icons),$(install_dest)/$(icon))

clean:
	rm -f $(icons)

.PHONY: all install clean
