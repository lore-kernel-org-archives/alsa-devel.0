From: Alain DANGER <alain.danger@wanadoo.fr>
Subject: New hardware report
Date: Tue, 23 Oct 2007 21:11:42 +0200 (CEST)
Message-ID: <31377814.89261193166702739.JavaMail.www@wwinf2204>
Reply-To: Alain DANGER <alain.danger@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7109_17906082.1193166702715"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp25.orange.fr (smtp25.orange.fr [193.252.22.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C2EF24A4C
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 21:11:43 +0200 (CEST)
Received: from wwinf2204 (wwinf2204 [172.22.131.31])
	by mwinf2549.orange.fr (SMTP Server) with ESMTP id BC3AF5400083
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 21:11:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_7109_17906082.1193166702715
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi. I managed to get the sound work with ALSA on the following MB : Shuttle AK32VN. OS : Kubuntu 7.10. 

Regards. Alain Danger


------=_Part_7109_17906082.1193166702715
Content-Type: text/plain; name="/home/alain/AK32VN.txt"
content-transfer-encoding: quoted-printable
Content-Disposition: attachment; filename="/home/alain/AK32VN.txt"

00:00.0 0600: 1106:3099
=09Subsystem: 1297:a232
=09Flags: bus master, 66MHz, medium devsel, latency 0
=09Memory at c0000000 (32-bit, prefetchable) [size=3D256M]
=09Capabilities: [a0] AGP version 2.0
=09Capabilities: [c0] Power Management version 2

00:01.0 0604: 1106:b099 (prog-if 00 [Normal decode])
=09Flags: bus master, 66MHz, medium devsel, latency 0
=09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
=09Memory behind bridge: e0000000-e2ffffff
=09Prefetchable memory behind bridge: d0000000-dfffffff
=09Capabilities: [80] Power Management version 2

00:0a.0 0180: 1095:3112 (rev 02)
=09Subsystem: 1095:3112
=09Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 15
=09I/O ports at 9000 [size=3D8]
=09I/O ports at 9400 [size=3D4]
=09I/O ports at 9800 [size=3D8]
=09I/O ports at 9c00 [size=3D4]
=09I/O ports at a000 [size=3D16]
=09Memory at e4401000 (32-bit, non-prefetchable) [size=3D512]
=09[virtual] Expansion ROM at 50000000 [disabled] [size=3D512K]
=09Capabilities: [60] Power Management version 2

00:0b.0 0c00: 1106:3004 (rev 46) (prog-if 10 [OHCI])
=09Subsystem: 1001:0000
=09Flags: bus master, medium devsel, latency 32, IRQ 10
=09Memory at e4000000 (32-bit, non-prefetchable) [size=3D2K]
=09I/O ports at a400 [size=3D128]
=09Capabilities: [50] Power Management version 2

00:10.0 0c03: 1106:3038 (rev 80) (prog-if 00 [UHCI])
=09Subsystem: 1297:a232
=09Flags: bus master, medium devsel, latency 32, IRQ 11
=09I/O ports at a800 [size=3D32]
=09Capabilities: [80] Power Management version 2

00:10.1 0c03: 1106:3038 (rev 80) (prog-if 00 [UHCI])
=09Subsystem: 1297:a232
=09Flags: bus master, medium devsel, latency 32, IRQ 5
=09I/O ports at ac00 [size=3D32]
=09Capabilities: [80] Power Management version 2

00:10.2 0c03: 1106:3038 (rev 80) (prog-if 00 [UHCI])
=09Subsystem: 1297:a232
=09Flags: bus master, medium devsel, latency 32, IRQ 15
=09I/O ports at b000 [size=3D32]
=09Capabilities: [80] Power Management version 2

00:10.3 0c03: 1106:3104 (rev 82) (prog-if 20 [EHCI])
=09Subsystem: 1297:a232
=09Flags: bus master, medium devsel, latency 32, IRQ 10
=09Memory at e4402000 (32-bit, non-prefetchable) [size=3D256]
=09Capabilities: [80] Power Management version 2

00:11.0 0601: 1106:3177
=09Subsystem: 1297:a232
=09Flags: bus master, stepping, medium devsel, latency 0
=09Capabilities: [c0] Power Management version 2

00:11.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
=09Subsystem: 1297:a232
=09Flags: bus master, medium devsel, latency 32, IRQ 11
=09[virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=3D8]
=09[virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=3D1]
=09[virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=3D8]
=09[virtual] Memory at 00000370 (type 3, non-prefetchable) [size=3D1]
=09I/O ports at b400 [size=3D16]
=09Capabilities: [c0] Power Management version 2

00:11.5 0401: 1106:3059 (rev 50)
=09Subsystem: 1297:a232
=09Flags: medium devsel, IRQ 15
=09I/O ports at b800 [size=3D256]
=09Capabilities: [c0] Power Management version 2

00:12.0 0200: 1106:3065 (rev 74)
=09Subsystem: 1106:0102
=09Flags: bus master, medium devsel, latency 32, IRQ 11
=09I/O ports at c000 [size=3D256]
=09Memory at e4403000 (32-bit, non-prefetchable) [size=3D256]
=09Capabilities: [40] Power Management version 2

01:00.0 0300: 10de:00f1 (rev a2) (prog-if 00 [VGA])
=09Subsystem: 1458:3150
=09Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
=09Memory at e0000000 (32-bit, non-prefetchable) [size=3D16M]
=09Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
=09Memory at e1000000 (32-bit, non-prefetchable) [size=3D16M]
=09[virtual] Expansion ROM at e2000000 [disabled] [size=3D128K]
=09Capabilities: [60] Power Management version 2
=09Capabilities: [44] AGP version 3.0


------=_Part_7109_17906082.1193166702715
Content-Type: text/plain; name="/etc/modprobe.d/alsa-base"
content-transfer-encoding: quoted-printable
Content-Disposition: attachment; filename="/etc/modprobe.d/alsa-base"

# autoloader aliases
install sound-slot-0 /sbin/modprobe snd-card-0
install sound-slot-1 /sbin/modprobe snd-card-1
install sound-slot-2 /sbin/modprobe snd-card-2
install sound-slot-3 /sbin/modprobe snd-card-3
install sound-slot-4 /sbin/modprobe snd-card-4
install sound-slot-5 /sbin/modprobe snd-card-5
install sound-slot-6 /sbin/modprobe snd-card-6
install sound-slot-7 /sbin/modprobe snd-card-7

# Cause optional modules to be loaded above generic modules
install snd /sbin/modprobe --ignore-install snd && { /sbin/modprobe --quiet=
 snd-ioctl32 ; : ; }
install snd-pcm /sbin/modprobe --ignore-install snd-pcm && { /sbin/modprobe=
 --quiet snd-pcm-oss ; : ; }
install snd-mixer /sbin/modprobe --ignore-install snd-mixer && { /sbin/modp=
robe --quiet snd-mixer-oss ; : ; }
install snd-seq /sbin/modprobe --ignore-install snd-seq && { /sbin/modprobe=
 --quiet snd-seq-midi ; /sbin/modprobe --quiet snd-seq-oss ; : ; }
install snd-rawmidi /sbin/modprobe --ignore-install snd-rawmidi && { /sbin/=
modprobe --quiet snd-seq-midi ; : ; }
# Cause optional modules to be loaded above sound card driver modules
install snd-emu10k1 /sbin/modprobe --ignore-install snd-emu10k1 $CMDLINE_OP=
TS && { /sbin/modprobe -Qb snd-emu10k1-synth ; }
install snd-via82xx /sbin/modprobe --ignore-install snd-via82xx $CMDLINE_OP=
TS && { /sbin/modprobe -Qb snd-seq ; }

# Load saa7134-alsa instead of saa7134 (which gets dragged in by it anyway)
install saa7134 /sbin/modprobe --ignore-install saa7134 $CMDLINE_OPTS && { =
/sbin/modprobe -Qb saa7134-alsa ; : ; }

# Load snd-seq for devices that don't have hardware midi;
#   Ubuntu #26283, #43682, #56005; works around Ubuntu #34831 for
#   non-Creative Labs PCI hardware
install snd /sbin/modprobe --ignore-install snd && { /sbin/modprobe -Qb snd=
-seq ; }
# Prevent abnormal drivers from grabbing index 0
options snd-bt87x index=3D-2
options cx88-alsa index=3D-2
options saa7134-alsa index=3D-2
options snd-atiixp-modem index=3D-2
options snd-intel8x0m index=3D-2
options snd-via82xx-modem index=3D-2
options snd-usb-audio index=3D-2
options snd-usb-usx2y index=3D-2
options snd-usb-caiaq index=3D-2
# Ubuntu #62691, enable MPU for snd-cmipci
options snd-cmipci mpu_port=3D0x330 fm_port=3D0x388

options snd-via82xx dxs_support=3D5

------=_Part_7109_17906082.1193166702715
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_7109_17906082.1193166702715--
