From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002160]: ALi Corporation M5455 PCI
	AC-Link Controller Audio Device (rev 20)
Date: Sun, 9 Jul 2006 12:23:14 +0200
Message-ID: <fb1e58cfb443765004f8b1bd18a4793d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10EF726E
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 12:23:14 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been UPDATED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2160> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                marciovinicius
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   2160
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Dapper Beta 2
Kernel Version:             =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-25-2006 22:13 CEST
Last Modified:              07-09-2006 12:23 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    ALi Corporation M5455 PCI AC-Link Controller Au=
dio
Device (rev 20)
Description: =

The sound card "ALi Corporation M5455 PCI AC-Link Controller Audio Device
(rev 20)" which cames onboard "Asus k8u-x" motherboard simply doesn=B4t
work. It is recognized by the system but doesn't work.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 rlrevell - 05-25-06 22:26 =

----------------------------------------------------------------------
"Doesn't work" is not a useful bug report.

Please provide the output of "aadebug" and describe how you are testing
it.

----------------------------------------------------------------------
 marciovinicius - 05-25-06 22:38 =

----------------------------------------------------------------------
Sorry, I'm new here. What is "aadebug"? And the tests are described in the
links I posted here. (mainly
http://www.ubuntuforums.org/showthread.php?t=3D169987)

----------------------------------------------------------------------
 rlrevell - 05-25-06 22:56 =

----------------------------------------------------------------------
http://alsa.opensrc.org/aadebug

It sounds like a Ubuntu bug.

----------------------------------------------------------------------
 marciovinicius - 05-26-06 03:00 =

----------------------------------------------------------------------
ALSA Audio Debug v0.1.0 - Qui Mai 25 21:58:04 BRT 2006
http://alsa.opensrc.org/index.php?page=3Daadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux ubuntu 2.6.15-23-amd64-generic #1 SMP PREEMPT Tue May 23 13:45:47
UTC 2006 x86_64 GNU/Linux

Loaded Modules --------------------------------------------
snd_intel8x0           38440  0
snd_ac97_codec        110268  1 snd_intel8x0
snd_ac97_bus            4096  1 snd_ac97_codec
snd_pcm_oss            59424  0
snd_mixer_oss          20608  1 snd_pcm_oss
snd_pcm               104712  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              29064  1 snd_pcm
snd                    68576  6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         13968  2 snd_intel8x0,snd_pcm

Modprobe Conf ---------------------------------------------
Warning: module config file does not exist
This means any kernel modules will not be auto loaded
See your linux distro docs on how to create this file

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
--- no soundcards ---
 33:       : timer
cat: /proc/asound/hwdep: Arquivo ou diret=F3rio n&#227;o encontrado
cat: /proc/asound/seq/clients: Arquivo ou diret=F3rio n&#227;o encontrado

Dev Snd ---------------------------------------------------
timer

CPU -------------------------------------------------------
model name      : AMD Athlon(tm) 64 Processor 3000+
cpu MHz         : 1999.965

RAM -------------------------------------------------------
MemTotal:       512052 kB
SwapTotal:      497972 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8
Single Chip]
0000:00:04.0 Multimedia audio controller: ALi Corporation M5455 PCI
AC-Link Controller Audio Device (rev 20)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control

----------------------------------------------------------------------
 marciovinicius - 05-26-06 03:14 =

----------------------------------------------------------------------
If you see the links I posted you'll see that it happens at least with
Debian and Fedora too (not only with Ubuntu). It likely refers to the
AMD64 version of the kernel, but I think it is an ALSA issue too.
As a matter of fact the kernel version is 2.6.15-23-amd64-generic (as you
can see in aadebug report). I couldn't write at the time when I made the
report and I don't know how to change the report (I don't know if I can do
it). Actually I'd like to change the severity of the report to major too -
I don't have sound! :(

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-25-06 22:13 marciovinicius New Issue                                    =

05-25-06 22:13 marciovinicius Distribution              =3D> Ubuntu Dapper =
Beta 2
05-25-06 22:26 rlrevell       Note Added: 0009965                          =

05-25-06 22:38 marciovinicius Note Added: 0009966                          =

05-25-06 22:56 rlrevell       Note Added: 0009968                          =

05-26-06 03:00 marciovinicius Note Added: 0009971                          =

05-26-06 03:14 marciovinicius Note Added: 0009972                          =

07-09-06 12:23 Adrian Bunk    Category                 1_OTHERS =3D> PCI -
intel8x0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
