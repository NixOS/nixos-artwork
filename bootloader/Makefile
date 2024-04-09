install_dest = $(DESTDIR)$(prefix)/share/grub/theme/nixos-installer-theme
grub2_icons := $(wildcard grub2-installer/icons/*.svg)
grub2_icons_png := $(foreach icon,$(icons),$(subst .svg,.png,$(icon)))

grub2-installer-theme.tar.gz: $(icons_png) $(wildcard grub2-installer/*.png) grub2-installer/dejavu.pf2 grub2-installer/theme.txt
	tar -czf $@ $^

.PHONY: clean

clean:
	rm $(icons_png) grub2-installer/dejavu.pf2 grub2-installer-theme.tar.gz

grub2-installer/icons/%.png: grub2-installer/icons/%.svg
	inkscape -o $@ $<

grub2-installer/dejavu.pf2:
	grub-mkfont -s 20 "$(dejavu)/share/fonts/truetype/DejaVuSans.ttf" -o $@

install: grub2-installer-theme.tar.gz
	mkdir -p "$(install_dest)"
	tar --strip-components=1 --directory "$(install_dest)" -xf "$<"
