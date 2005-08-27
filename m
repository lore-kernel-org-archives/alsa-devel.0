From: =?iso-8859-1?q?Andr=E9_Mouhot?= <amouhot@free.fr>
Subject: Dysfonctionnement driver carte son
Date: Sat, 27 Aug 2005 08:29:32 +0200
Message-ID: <200508270829.32552.amouhot@free.fr>
Mime-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_MhAEDdz1IlHIqKG"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_MhAEDdz1IlHIqKG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Bonjour,
Comme propos=E9 en log de ma machine Linux, je vous fais suivre cette=20
notification de dysfonctionnement.

Computer; HP Vectra VE 400Mhz

Un d=E9butant sous Linux, expert poste de travail Windows, responsable=20
conception et d=E9veloppement des applications d'installation de postes (70=
 000=20
PC et serveurs dans un grand groupe automobiles)

Cordialement

Andr=E9 Mouhot

ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97
       Try reloading the ALSA driver, if you find something
       broken or not working on your soundcard upon
       this message please report to alsa-devel@lists.sourceforge.net

=2D-=20
Linux version 2.6.8-2-386 (horms@tabatha.lab.ultramonkey.org) (gcc version=
=20
3.3.5 (Debian 1:3.3.5-12)) #1 Thu May 19 17:40:50 JST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
 BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
 BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 77808 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI disabled because your bios is from 99 and too old
You can enable it with acpi=3Dforce
Built 1 zonelists
Kernel command line: root=3D/dev/hdd1 ro apm=3Don
Local APIC disabled by BIOS -- reenabling.
=46ound and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 401.070 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 317116k/327616k available (1336k kernel code, 9724k reserved, 732k=
=20
data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 790.52 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps:        0183fbff 00000000 00000000 00000040
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 400.0837 MHz.
=2E.... host bus clock speed is 100.0209 MHz.
checking if image is initramfs...it isn't (ungzip failed); looks like an=20
initrd
=46reeing initrd memory: 4216k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe60
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe90, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 4
Cannot allocate resource for EISA slot 5
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4216 blocks [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
=46reeing unused kernel memory: 204k freed
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD64AA, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/2048KiB Cache, CHS=3D13328/15/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
hdc: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive
hdd: QUANTUM FIREBALLlct20 20, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: max request size: 128KiB
hdd: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=3D39560/16/63, UDMA(33)
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 843372k swap on /dev/hdd5.  Priority:-1 extents:1
EXT3 FS on hdd1, internal journal
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Capability LSM initialized
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
PCI: Found IRQ 10 for device 0000:00:0f.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe400. Vers LK1.1.19
PCI: Found IRQ 9 for device 0000:00:04.0
Crystal 4280/46xx + AC97 Audio, version 1.28.32, 17:47:46 May 19 2005
cs46xx: Card found at 0xe8101000 and 0xe8000000, IRQ 9
cs46xx: Unknown card (1013:6003) at 0xe8101000/0xe8000000, IRQ 9
cs46xx: create - never read ISV3 & ISV4 from AC'97
cs46xx: create - never read ISV3 & ISV4 from AC'97
cs46xx: create - never read ISV3 & ISV4 from AC'97
cs46xx: create - never read ISV3 & ISV4 from AC'97
cs46xx: create - never read ISV3 & ISV4 from AC'97
cs46xx: cs46xx_probe()- cs_hardware_init() failed, retried 5 times.
cs46xx: probe()- no device allocated
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 3, io base 0000e000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xe0000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=3D0x1001
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=3D0x1001
PCI: Found IRQ 9 for device 0000:00:04.0
ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97
       Try reloading the ALSA driver, if you find something
       broken or not working on your soundcard upon
       this message please report to alsa-devel@lists.sourceforge.net
Sound Fusion CS46xx: probe of 0000:00:04.0 failed with error -5
Real Time Clock Driver v1.12
input: PC Speaker
inserting floppy driver for 2.6.8-2-386
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
NET: Registered protocol family 17
NET: Registered protocol family 5
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02cc960(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
                                                                      =20
Andr=E9 Mouhot
--Boundary-00=_MhAEDdz1IlHIqKG
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head><meta name=3D"qrichtext" content=3D"1" /></head><body style=3D"=
font-size:12pt;font-family:Bitstream Vera Sans">
<p>Bonjour,</p>
<p>Comme propos=E9 en log de ma machine Linux, je vous fais suivre cette no=
tification de dysfonctionnement.</p>
<p></p>
<p>Computer; HP Vectra VE 400Mhz</p>
<p></p>
<p>Un d=E9butant sous Linux, expert poste de travail Windows, responsable c=
onception et d=E9veloppement des applications d'installation de postes (70 =
000 PC et serveurs dans un grand groupe automobiles)</p>
<p></p>
<p>Cordialement</p>
<p></p>
<p>Andr=E9 Mouhot</p>
<p></p>
<p><span style=3D"font-weight:600">ERROR: snd-cs46xx: never read ISV3 &amp;=
 ISV4 from AC'97</span></p>
<p><span style=3D"font-weight:600">       Try reloading the ALSA driver, if=
 you find something</span></p>
<p><span style=3D"font-weight:600">       broken or not working on your sou=
ndcard upon</span></p>
<p><span style=3D"font-weight:600">       this message please report to als=
a-devel@lists.sourceforge.net</span></p>
<p></p>
<p>-- </p>
<p>Linux version 2.6.8-2-386 (horms@tabatha.lab.ultramonkey.org) (gcc versi=
on 3.3.5 (Debian 1:3.3.5-12)) #1 Thu May 19 17:40:50 JST 2005</p>
<p>BIOS-provided physical RAM map:</p>
<p> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)</p>
<p> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)</p>
<p> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)</p>
<p> BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)</p>
<p> BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)</p>
<p> BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)</p>
<p> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)</p>
<p>319MB LOWMEM available.</p>
<p>On node 0 totalpages: 81904</p>
<p>  DMA zone: 4096 pages, LIFO batch:1</p>
<p>  Normal zone: 77808 pages, LIFO batch:16</p>
<p>  HighMem zone: 0 pages, LIFO batch:1</p>
<p>DMI 2.2 present.</p>
<p>ACPI disabled because your bios is from 99 and too old</p>
<p>You can enable it with acpi=3Dforce</p>
<p>Built 1 zonelists</p>
<p>Kernel command line: root=3D/dev/hdd1 ro apm=3Don</p>
<p>Local APIC disabled by BIOS -- reenabling.</p>
<p>Found and enabled local APIC!</p>
<p>Initializing CPU#0</p>
<p>PID hash table entries: 2048 (order 11: 16384 bytes)</p>
<p>Detected 401.070 MHz processor.</p>
<p>Using tsc for high-res timesource</p>
<p>Console: colour VGA+ 80x25</p>
<p>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)</p>
<p>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)</p>
<p>Memory: 317116k/327616k available (1336k kernel code, 9724k reserved, 73=
2k data, 204k init, 0k highmem)</p>
<p>Checking if this processor honours the WP bit even in supervisor mode...=
 Ok.</p>
<p>Calibrating delay loop... 790.52 BogoMIPS</p>
<p>Security Scaffold v1.0.0 initialized</p>
<p>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)</p>
<p>CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000</=
p>
<p>CPU: After vendor identify, caps:  0183fbff 00000000 00000000 00000000</=
p>
<p>CPU: L1 I cache: 16K, L1 D cache: 16K</p>
<p>CPU: L2 cache: 512K</p>
<p>CPU: After all inits, caps:        0183fbff 00000000 00000000 00000040</=
p>
<p>CPU: Intel Pentium II (Deschutes) stepping 02</p>
<p>Enabling fast FPU save and restore... done.</p>
<p>Checking 'hlt' instruction... OK.</p>
<p>Checking for popad bug... OK.</p>
<p>enabled ExtINT on CPU#0</p>
<p>ESR value before enabling vector: 00000000</p>
<p>ESR value after enabling vector: 00000000</p>
<p>Using local APIC timer interrupts.</p>
<p>calibrating APIC timer ...</p>
<p>..... CPU clock speed is 400.0837 MHz.</p>
<p>..... host bus clock speed is 100.0209 MHz.</p>
<p>checking if image is initramfs...it isn't (ungzip failed); looks like an=
 initrd</p>
<p>Freeing initrd memory: 4216k freed</p>
<p>NET: Registered protocol family 16</p>
<p>EISA bus registered</p>
<p>PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=3D1</p>
<p>PCI: Using configuration type 1</p>
<p>mtrr: v2.0 (20020519)</p>
<p>ACPI: Subsystem revision 20040326</p>
<p>ACPI: Interpreter disabled.</p>
<p>Linux Plug and Play Support v0.97 (c) Adam Belay</p>
<p>PnPBIOS: Scanning system for PnP BIOS support...</p>
<p>PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe60</p>
<p>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe90, dseg 0xf0000</p>
<p>PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver</p>
<p>PCI: Probing PCI hardware</p>
<p>PCI: Probing PCI hardware (bus 00)</p>
<p>PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0</p>
<p>VFS: Disk quotas dquot_6.5.1</p>
<p>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)</p>
<p>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)</p>
<p>devfs: boot_options: 0x0</p>
<p>Initializing Cryptographic API</p>
<p>Limiting direct PCI/PCI transfers.</p>
<p>isapnp: Scanning for PnP cards...</p>
<p>isapnp: No Plug &amp; Play device found</p>
<p>Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enable=
d</p>
<p>ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A</p>
<p>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize</p>
<p>serio: i8042 AUX port at 0x60,0x64 irq 12</p>
<p>serio: i8042 KBD port at 0x60,0x64 irq 1</p>
<p>input: AT Translated Set 2 keyboard on isa0060/serio0</p>
<p>EISA: Probing bus 0 at eisa0</p>
<p>Cannot allocate resource for EISA slot 4</p>
<p>Cannot allocate resource for EISA slot 5</p>
<p>EISA: Detected 0 cards.</p>
<p>NET: Registered protocol family 2</p>
<p>IP: routing cache hash table of 2048 buckets, 16Kbytes</p>
<p>TCP: Hash tables configured (established 32768 bind 65536)</p>
<p>NET: Registered protocol family 8</p>
<p>NET: Registered protocol family 20</p>
<p>RAMDISK: cramfs filesystem found at block 0</p>
<p>RAMDISK: Loading 4216 blocks [1 disk] into ram disk... done.</p>
<p>VFS: Mounted root (cramfs filesystem) readonly.</p>
<p>Freeing unused kernel memory: 204k freed</p>
<p>vesafb: probe of vesafb0 failed with error -6</p>
<p>NET: Registered protocol family 1</p>
<p>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2</p>
<p>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx</p>
<p>PIIX4: IDE controller at PCI slot 0000:00:07.1</p>
<p>PIIX4: chipset revision 1</p>
<p>PIIX4: not 100% native mode: will probe irqs later</p>
<p>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio</p>
<p>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio</p>
<p>hda: WDC WD64AA, ATA DISK drive</p>
<p>Using anticipatory io scheduler</p>
<p>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14</p>
<p>hda: max request size: 128KiB</p>
<p>hda: 12594960 sectors (6448 MB) w/2048KiB Cache, CHS=3D13328/15/63, UDMA=
(33)</p>
<p> /dev/ide/host0/bus0/target0/lun0: p1 p2 &lt; p5 &gt;</p>
<p>hdc: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive</p>
<p>hdd: QUANTUM FIREBALLlct20 20, ATA DISK drive</p>
<p>ide1 at 0x170-0x177,0x376 on irq 15</p>
<p>hdd: max request size: 128KiB</p>
<p>hdd: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=3D39560/16/63, UDMA=
(33)</p>
<p> /dev/ide/host0/bus1/target1/lun0: p1 p2 &lt; p5 &gt;</p>
<p>kjournald starting.  Commit interval 5 seconds</p>
<p>EXT3-fs: mounted filesystem with ordered data mode.</p>
<p>Adding 843372k swap on /dev/hdd5.  Priority:-1 extents:1</p>
<p>EXT3 FS on hdd1, internal journal</p>
<p>hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)</p>
<p>Uniform CD-ROM driver Revision: 3.20</p>
<p>input: PS2++ Logitech Wheel Mouse on isa0060/serio1</p>
<p>apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)</p>
<p>Capability LSM initialized</p>
<p>mice: PS/2 mouse device common for all mice</p>
<p>ts: Compaq touchscreen protocol output</p>
<p>kjournald starting.  Commit interval 5 seconds</p>
<p>EXT3 FS on hda1, internal journal</p>
<p>EXT3-fs: mounted filesystem with ordered data mode.</p>
<p>Linux agpgart interface v0.100 (c) Dave Jones</p>
<p>PCI: Found IRQ 10 for device 0000:00:0f.0</p>
<p>3c59x: Donald Becker and others. www.scyld.com/network/vortex.html</p>
<p>0000:00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe400. Vers LK1.1.19=
</p>
<p>PCI: Found IRQ 9 for device 0000:00:04.0</p>
<p>Crystal 4280/46xx + AC97 Audio, version 1.28.32, 17:47:46 May 19 2005</p>
<p>cs46xx: Card found at 0xe8101000 and 0xe8000000, IRQ 9</p>
<p>cs46xx: Unknown card (1013:6003) at 0xe8101000/0xe8000000, IRQ 9</p>
<p>cs46xx: create - never read ISV3 &amp; ISV4 from AC'97</p>
<p>cs46xx: create - never read ISV3 &amp; ISV4 from AC'97</p>
<p>cs46xx: create - never read ISV3 &amp; ISV4 from AC'97</p>
<p>cs46xx: create - never read ISV3 &amp; ISV4 from AC'97</p>
<p>cs46xx: create - never read ISV3 &amp; ISV4 from AC'97</p>
<p>cs46xx: cs46xx_probe()- cs_hardware_init() failed, retried 5 times.</p>
<p>cs46xx: probe()- no device allocated</p>
<p>usbcore: registered new driver usbfs</p>
<p>usbcore: registered new driver hub</p>
<p>USB Universal Host Controller Interface driver v2.2</p>
<p>uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB</p>
<p>uhci_hcd 0000:00:07.2: irq 3, io base 0000e000</p>
<p>uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1</p>
<p>hub 1-0:1.0: USB hub found</p>
<p>hub 1-0:1.0: 2 ports detected</p>
<p>agpgart: Detected an Intel 440BX Chipset.</p>
<p>agpgart: Maximum main memory to use for agp memory: 262M</p>
<p>agpgart: AGP aperture is 64M @ 0xe0000000</p>
<p>cpci_hotplug: CompactPCI Hot Plug Core version: 0.2</p>
<p>pci_hotplug: PCI Hot Plug PCI Core version: 0.5</p>
<p>pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=3D0x1001</p>
<p>shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=3D0x1001</p>
<p>PCI: Found IRQ 9 for device 0000:00:04.0</p>
<p>ERROR: snd-cs46xx: never read ISV3 &amp; ISV4 from AC'97</p>
<p>       Try reloading the ALSA driver, if you find something</p>
<p>       broken or not working on your soundcard upon</p>
<p>       this message please report to alsa-devel@lists.sourceforge.net</p>
<p>Sound Fusion CS46xx: probe of 0000:00:04.0 failed with error -5</p>
<p>Real Time Clock Driver v1.12</p>
<p>input: PC Speaker</p>
<p>inserting floppy driver for 2.6.8-2-386</p>
<p>Floppy drive(s): fd0 is 1.44M</p>
<p>FDC 0 is a post-1991 82077</p>
<p>parport: PnPBIOS parport detected.</p>
<p>parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]</p>
<p>NET: Registered protocol family 17</p>
<p>NET: Registered protocol family 5</p>
<p>NET: Registered protocol family 10</p>
<p>Disabled Privacy Extensions on device c02cc960(lo)</p>
<p>IPv6 over IPv4 tunneling driver</p>
<p>eth0: no IPv6 routers present</p>
<p>                                                                       <=
/p>
<p>Andr=E9 Mouhot</p>
</body></html>
--Boundary-00=_MhAEDdz1IlHIqKG--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
