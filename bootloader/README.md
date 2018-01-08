Bootloader artwork
==================

This directory holds the artwork used for the NixOS bootloaders.

`bios-boot`
-----------

The bootloader for legacy boot, specifically the ISO/USB image.

It is assumed it is of the SYSLINUX family, probably ISOLINUX.

Technically the ISOLINUX setup is to be configured to use a 800×600 resolution.
This resolution ensures a maximum number of machines to be compatible, and
still allows enough definition.

It is also assumed that legacy boot **is not really used anymore**. Most recent
hardware will be using the UEFI bootloader. This is why the image is made
assuming 4:3 aspect ratio; most of the legacy boot uses are assumed to be on
virtual machines, where the bootloader will be shown with square pixels.
