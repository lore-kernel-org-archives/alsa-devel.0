From: "Nicolas Jean-Charles" <nicolas@linkage.fr>
Subject: Alsa Driver for ChipSet SIS7019
Date: Mon, 7 Aug 2006 11:22:22 +0200
Message-ID: <003f01c6ba02$fd15e7d0$c78673c3@dns2>
Reply-To: Nicolas Jean-Charles <nicolas@linkage.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0361935114=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0361935114==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003C_01C6BA13.C06DE3D0"

This is a multi-part message in MIME format.

------=_NextPart_000_003C_01C6BA13.C06DE3D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,=20

I have a vortex motherboard with a sound chipset SIS 7019.
I used a linux RedHat 9 (Kernel 2.4.20-8), i also install the kernel =
source. I installed the driver.

To test the sound, i tried a little program from http://www.fmod.org/.
I lauch this program=20
  a.. I select the OutPut Type :  OSS =20
  b.. I select the Open  Sound System Driver List : /dev/dsp. When i =
choose /etc/dsp, there is nothing (the system seems to be crash, there =
is no sound.... I must to reboot).
I want to know if Alsa have a driver for ChipSet SIS7019. If yes Wich =
Alsa version to use ?

Thanks a lot=20
Regards / Cordialement,

Mr Nicolas Jean-Charles
Vendigautomation
7 rue Colbert
63000 Clermont-Fd
Tel : (+33) 04 73 29 70 00
Fax : (+33) 04 73 29 70 01
http://www.vendingautomation.com



------=_NextPart_000_003C_01C6BA13.C06DE3D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hello, </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a vortex motherboard with a =
sound chipset=20
SIS 7019.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I used&nbsp;a linux RedHat 9 (Kernel =
2.4.20-8), i=20
also install the kernel source. I installed the driver.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>To test the sound, i tried a little =
program from <A=20
href=3D"http://www.fmod.org/">http://www.fmod.org/</A>.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I lauch this program&nbsp;</FONT></DIV>
<UL>
  <LI><FONT face=3DArial size=3D2>I select the OutPut Type : =
&nbsp;OSS&nbsp;</FONT>=20
  <LI><FONT face=3DArial size=3D2>I select the Open&nbsp; Sound System =
Driver List=20
  :&nbsp;/dev/dsp. When i choose /etc/dsp,&nbsp;there is nothing (the =
system=20
  seems to be crash, there is no sound.... I must to =
reboot).</FONT></LI></UL>
<DIV><FONT face=3DArial size=3D2>I want&nbsp;to know =
if&nbsp;Alsa&nbsp;have a driver=20
for ChipSet SIS7019. If yes Wich Alsa version to use ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot</FONT>&nbsp;<FONT =
face=3DArial=20
size=3D2></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Regards / Cordialement,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Mr Nicolas =
Jean-Charles<BR>Vendigautomation<BR>7=20
rue Colbert<BR>63000 Clermont-Fd<BR>Tel : (+33) 04 73 29 70 00<BR>Fax : =
(+33) 04=20
73 29 70 01<BR><A=20
href=3D"http://www.vendingautomation.com">http://www.vendingautomation.co=
m</A></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2></FONT>&nbsp;</DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_003C_01C6BA13.C06DE3D0--



--===============0361935114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0361935114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0361935114==--
