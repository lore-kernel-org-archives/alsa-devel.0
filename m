From: "marion rundell" <mrundell@gmail.com>
Subject: Subject: Does anyone know if this chipsset VT82C686
	will output 24 bit,
	96 kHz to USB 1.1 or pcmcia card...using a Linux 2.4 platform
Date: Mon, 29 Jan 2007 09:55:08 -0600
Message-ID: <045701c743bd$db033950$1402a8c0@pcc41100>
References: <45AFE785.6020307@informatik.uni-oldenburg.de><45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de><s5hac08cvct.wl%tiwai@suse.de><20070125101319.GA3340@titan.lahn.de><s5hd553bbfs.wl%tiwai@suse.de><20070126202950.GA5721@titan.lahn.de><s5hbqkhq4i6.wl%tiwai@suse.de><20070129153011.GA2831@synertronixx3>
	<20070129153301.GB2831@synertronixx3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0064413370=="
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
To: Konstantin Kletschke <lists@ku-gbr.de>, ALSA developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0064413370==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0454_01C7438B.8EFA1E20"

This is a multi-part message in MIME format.

------=_NextPart_000_0454_01C7438B.8EFA1E20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




I am trying to determine if I can get spdif out of a system with the =
VT82C686 chipset. =20

Does anyone know if this chipset is capable of outputting, on a Linux =
2.4 platform...24bit, 96kHz bandwidth to a USB 1.1 or pcmcia card.  I =
have only been able to get unreliable sound out so far.=20

Marion

mrundell@gmail.com
  ----- Original Message -----=20
  From: Konstantin Kletschke=20
  To: ALSA developers=20
  Sent: Monday, January 29, 2007 9:33 AM
  Subject: Re: [Alsa-devel] A: VIA Technologies Inc. VT1720/24


  Am 2007-01-29 16:30 +0100 schrieb Konstantin Kletschke:

  > May be Philps patch needs only slight work, my approach of a

  What I forgot to point out: It gives basic functionality but main
  volume sliders are not working. Sound is constant at moderate
  level. This is expected by me, since aureon.c seems to speak in spi
  mode to wm8776, it needs i2c functions.

  Konsti

  --=20
  GPG KeyID EF62FCEF
  Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

  =
-------------------------------------------------------------------------=

  Take Surveys. Earn Cash. Influence the Future of IT
  Join SourceForge.net's Techsay panel and you'll get the chance to =
share your
  opinions on IT & business topics through brief surveys - and earn cash
  =
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
  _______________________________________________
  Alsa-devel mailing list
  Alsa-devel@lists.sourceforge.net
  https://lists.sourceforge.net/lists/listinfo/alsa-devel
------=_NextPart_000_0454_01C7438B.8EFA1E20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2></FONT><BR></DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to determine if I can get =
spdif out of=20
a system with the VT82C686 chipset.&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Does anyone know if this chipset is =
capable of=20
outputting, on a Linux 2.4 platform...24bit, 96kHz bandwidth to a USB=20
1.1&nbsp;or pcmcia card.&nbsp; I have only been able to get unreliable =
sound out=20
so far.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>Marion</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:mrundell@gmail.com">mrundell@gmail.com</A></FONT></DIV></D=
IV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dlists@ku-gbr.de href=3D"mailto:lists@ku-gbr.de">Konstantin=20
  Kletschke</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dalsa-devel@lists.sourceforge.net=20
  href=3D"mailto:alsa-devel@lists.sourceforge.net">ALSA developers</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Monday, January 29, 2007 =
9:33=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [Alsa-devel] A: =
VIA=20
  Technologies Inc. VT1720/24</DIV>
  <DIV><BR></DIV>Am 2007-01-29 16:30 +0100 schrieb Konstantin=20
  Kletschke:<BR><BR>&gt; May be Philps patch needs only slight work, my =
approach=20
  of a<BR><BR>What I forgot to point out: It gives basic functionality =
but=20
  main<BR>volume sliders are not working. Sound is constant at=20
  moderate<BR>level. This is expected by me, since aureon.c seems to =
speak in=20
  spi<BR>mode to wm8776, it needs i2c functions.<BR><BR>Konsti<BR><BR>-- =
<BR>GPG=20
  KeyID EF62FCEF<BR>Fingerprint: 13C9 B16B 9844 EC15 CC2E&nbsp; A080 =
1E69 3FDA=20
  EF62=20
  =
FCEF<BR><BR>-------------------------------------------------------------=
------------<BR>Take=20
  Surveys. Earn Cash. Influence the Future of IT<BR>Join =
SourceForge.net's=20
  Techsay panel and you'll get the chance to share your<BR>opinions on =
IT &amp;=20
  business topics through brief surveys - and earn cash<BR><A=20
  =
href=3D"http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsource=
forge&amp;CID=3DDEVDEV">http://www.techsay.com/default.php?page=3Djoin.ph=
p&amp;p=3Dsourceforge&amp;CID=3DDEVDEV</A><BR>___________________________=
____________________<BR>Alsa-devel=20
  mailing list<BR><A=20
  =
href=3D"mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourcef=
orge.net</A><BR><A=20
  =
href=3D"https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://=
lists.sourceforge.net/lists/listinfo/alsa-devel</A></BLOCKQUOTE></BODY></=
HTML>

------=_NextPart_000_0454_01C7438B.8EFA1E20--



--===============0064413370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0064413370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0064413370==--
