From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: usx2yloader 0.3
Date: Thu, 18 Sep 2003 22:57:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309182257.40573.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Exha/feQ3hDDau3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_Exha/feQ3hDDau3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hallo Takashi,

here is a patch which sports complete us428 initialisation via hotplug,
an INSTALL and a README.
I took the phase 1 firmware files from usb-midi-firmware project.
Also fixed are some compile warnings.
Maybe the Makefile.am is not completely correct as 
I hardcoded the directory /etc/hotplug/usb. But maybe also this is the 
standard place to put such hotplug files?
Well....here it works.
Please put the stuffs to CVS.
The driver from CVS also works here.

Thanks,
Karsten



--Boundary-00=_Exha/feQ3hDDau3
Content-Type: application/x-tbz;
  name="usx2yloader adds for 0.3.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="usx2yloader adds for 0.3.tar.bz2"

QlpoOTFBWSZTWWH6DJEABK1/h//wADB//////+/f+v/v//ABEDQAAEAACGA43vkzgAmqB7alee+h
KhIfWtE3SiLrJQ0NVSqAAAvmy6FrA1r7cddzvu3eyrbt3Jm9sElXGaF1nsbqtat7lZIL06OkZsNj
NrYyNVCDb0Pn29801u27rfXoHbKp6c4auYBhTpq5gZCFBVM76la7igalVCutOnTqDQQAjQTIKeEI
m2qPRPVPRqb0R6KNPamiaaaaaaPUxqYyJgGp6AICkklGgyDI0aNMhoYCAwIaYmAEyaZNGDTTRAp6
KSMTE00NGEyaaMJiYRkaYRgIMBNMRiBKZEAgkpqZRlDENMmgDIwhowgADCaAGgAIlITU9JhU/Rpo
mE8iGJpMnhEyY1NANGhoA0yDamQ0BIhBAmRJomEaKeNUyeJGmhoGnqAAAAAAAeQXoP5+30f9ZXWb
3q8V7v174dggFZmI3xaUISDB8CSEV9R92HH1/V9jG70asYzA4GCVYvDw7stMRDHRe8W+z2N6aCXv
ghCTaEhtNAxJGlACCwQOapWqBYQGgNVFJAcAUi9MKqCHa8FJmKZjW/W2B6cl6ut2nsvnDhCtqX7b
S8Zj7Geg/aZTjVNJsnkijn7tL/vsf+AMDilnUZ62LSRlAbOvV1w+bY0ebPh3d6cOdjuVjU7GdnZ8
Pw9E59+3v2tKwKtasrWvve9v3uuZ5c5RfZaeyZ1Gu+2vdtFzzPYGwnqKJpIU88HWtKbr17idtOeV
6k92Hvjmu9GyJ3O3y3XylT1Rl8mO2/LaN7C8vlTyepkGdTKdv07z1Xp41PKVbzOyiUnu5vV+2G3P
RNboyIRhFg9m96Zpe76Mxy3DboQE3XopV5pb3z1bYUjrtD3h7TcXO0jVjIUik7pPTOea4G2G68e8
k+mmhd6jPoRj5u207qLXhMqd6t+ly/V7qd8OuZnRjp97Wm5nJFvCZc5K5ap5xucXS9y7SdqdvXe8
7nd7qo9OxloyI82b5QvfTjTv2NV3z1znrajvXOoo9PjO9qudKb9m10sUnmM1CWadpTRri7y96i03
bykZ93y826ZLv5abyzzo3Hk9EJWlXW7krqzn4Pn+f7Ns+YJenE1HeP2z4MQegGjEi0IGAywBofb8
PpS3i1kBs9Ptdxnd82TlQjDIU/qU+w+er+iEDxIX/KzPxAi8SrlFgL2/8xo8j19Gza7bIyM9D0GT
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
1GSXq7Ies40HHsmgvYHGAH/i7kinChIMP0GSIA==

--Boundary-00=_Exha/feQ3hDDau3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="usx2yloader.patch.0.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usx2yloader.patch.0.3"

Index: Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/Makefile.am,v
retrieving revision 1.1
diff -u -r1.1 Makefile.am
--- Makefile.am	8 Sep 2003 11:12:31 -0000	1.1
+++ Makefile.am	18 Sep 2003 20:08:53 -0000
@@ -11,6 +11,11 @@
 
 EXTRA_DIST = depcomp
 
+hotplug_files = tascam_fw.usermap tascam_fw tascam_fpga
+hotplugdir = /etc/hotplug/usb
+hotplug_SCRIPTS = $(hotplug_files)
+
+
 alsa-dist: distdir
 	@rm -rf ../distdir/usx2yloader
 	@mkdir -p ../distdir/usx2yloader
Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/configure.in,v
retrieving revision 1.1
diff -u -r1.1 configure.in
--- configure.in	8 Sep 2003 11:12:31 -0000	1.1
+++ configure.in	18 Sep 2003 20:08:53 -0000
@@ -1,5 +1,5 @@
 AC_INIT(usx2yloader.c)
-AM_INIT_AUTOMAKE(usx2yloader, 0.2)
+AM_INIT_AUTOMAKE(usx2yloader, 0.3)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
Index: usx2yloader.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/usx2yloader.c,v
retrieving revision 1.1
diff -u -r1.1 usx2yloader.c
--- usx2yloader.c	8 Sep 2003 11:12:31 -0000	1.1
+++ usx2yloader.c	18 Sep 2003 20:08:54 -0000
@@ -63,15 +63,17 @@
 
 
 /*
- * read a xilinx bitstream file
+ * read a xilinx bitstream file.
+ * NOTE: This interprets somehow differently from the vxloaders read_xilinx_image()!
+ * I took this from rbtload.c of the project usb-midi-fw.sf.net.
  */
 static int read_xilinx_image(snd_hwdep_dsp_image_t *img, const char *fname)
 {
 	FILE *fp;
 	char buf[256];
-	int data, c, idx, length;
+	int data = 0, c = 0, idx = 0, length = 0;
 	char *p;
-	char *imgbuf;
+	char *imgbuf = 0;
 
 	if ((fp = fopen(fname, "r")) == NULL) {
 		fprintf(stderr, PROGNAME ": cannot open %s\n", fname);
@@ -79,10 +81,6 @@
 	}
 	snd_hwdep_dsp_image_set_name(img, fname);
 
-	c = 0;
-	data = 0;
-	idx = 0;
-	length = 0;
 	while (fgets(buf, sizeof(buf), fp)) {
 		if (strncmp(buf, "Bits:", 5) == 0) {
 			for (p = buf + 5; *p && isspace(*p); p++);
@@ -140,15 +138,13 @@
 			}
 		}
 	}
-	if (c)
-		imgbuf[idx++] = data;
-	if (idx != length) {
-		fprintf(stderr,
-			PROGNAME ": length doesn't match: %d != %d\n", idx,
-			length);
+	if (idx != length || 0 == imgbuf) {
+		fprintf(stderr, PROGNAME ": length doesn't match: %d != %d\n", idx, length);
 		fclose(fp);
 		return -EINVAL;
 	}
+	if (c)
+		imgbuf[idx++] = data;
 	snd_hwdep_dsp_image_set_length(img, length);
 	snd_hwdep_dsp_image_set_image(img, imgbuf);
 	fclose(fp);
@@ -223,7 +219,6 @@
 	len = strlen(temp);
 
 	while (fgets(buf, sizeof(buf), fp)) {
-		int prepad;
 		if (strncmp(buf, temp, len))
 			continue;
 
@@ -303,7 +298,7 @@
 {
 	snd_hwdep_t *hw;
 	const char *id;
-	int err, is_pcmcia;
+	int err;
 	unsigned int idx, dsps, loaded;
 	snd_hwdep_dsp_status_t *stat;
 
Index: firmware/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/firmware/Makefile.am,v
retrieving revision 1.1
diff -u -r1.1 Makefile.am
--- firmware/Makefile.am	8 Sep 2003 11:12:31 -0000	1.1
+++ firmware/Makefile.am	18 Sep 2003 20:08:54 -0000
@@ -1,5 +1,4 @@
-cfg_files = us428.conf us428.prepad us428.rbt
-
+cfg_files = us428.conf us428.prepad us428.rbt tascam_loader.ihx us428fw.ihx
 EXTRA_DIST = $(cfg_files)
 
 firmwaredir = $(datadir)/alsa/firmware

--Boundary-00=_Exha/feQ3hDDau3--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
