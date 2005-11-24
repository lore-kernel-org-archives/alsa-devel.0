From: "Sverker Abrahamsson" <sverker@abrahamsson.com>
Subject: question about pointer callback
Date: Thu, 24 Nov 2005 15:12:55 +0100
Message-ID: <009d01c5f101$2ab05e30$3d2aa8c0@Fiona>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009A_01C5F109.8C12F720"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from belle.abrahamsson.com (belle.abrahamsson.com [62.119.34.90])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF0FF181
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 15:13:00 +0100 (MET)
Received: from Fiona (static-213-115-0-156.sme.bredbandsbolaget.se [213.115.0.156])
	by belle.abrahamsson.com (Postfix) with ESMTP id 724CCA08D24
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 16:20:01 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_009A_01C5F109.8C12F720
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi
I have a (maybe stupid) question about the pointer callback and it's =
purpose. Is it used for both playback and capture? As I understand it =
should return the availible data to read (for capture) in number of =
frames, but should it return the availible space to write to for =
playback also?
/Sverker
------=_NextPart_000_009A_01C5F109.8C12F720
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I have a (maybe stupid) question about =
the pointer=20
callback and it's purpose. Is it used for both playback and capture? As =
I=20
understand it should return the availible data to read (for capture) in =
number=20
of frames, but should it return the availible space to write to for =
playback=20
also?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>/Sverker</FONT></DIV></BODY></HTML>

------=_NextPart_000_009A_01C5F109.8C12F720--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
