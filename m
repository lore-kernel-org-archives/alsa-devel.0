From: "Daniel" <vfunc@talktalk.net>
Subject: Re: example of acting on events,
	rendering and threading
Date: Thu, 29 Jun 2006 23:27:01 +0100
Message-ID: <005b01c69bcb$24684f40$1a470d54@DANSHOME>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1730800037=="
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

--===============1730800037==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0058_01C69BD3.860B4C90"

This is a multi-part message in MIME format.

------=_NextPart_000_0058_01C69BD3.860B4C90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Date: Wed, 28 Jun 2006 19:16:33 +0200
From: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] example of acting on events, rendering and
threading

> Hm, I don't see why this is needed to be threaded...

> Anyway, the question is a bit too vague to answer.  As a good code as
> multi-threaded audio apps, you can find jackd, for example.
> Xmms and co have also threaded audio output.

> Takashi

Yes, 1 thread for the audio and 1 thread for the interface.

------=_NextPart_000_0058_01C69BD3.860B4C90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#d8d0c8>
<DIV><FONT face=3DArial size=3D2>
<DIV>Date: Wed, 28 Jun 2006 19:16:33 +0200<BR>From: Takashi Iwai &lt;<A=20
href=3D"mailto:tiwai@suse.de">tiwai@suse.de</A>&gt;<BR>Subject: Re: =
[Alsa-devel]=20
example of acting on events, rendering and<BR>threading<BR></DIV>
<DIV>&gt; Hm, I don't see why this is needed to be =
threaded...<BR><BR>&gt;=20
Anyway, the question is a bit too vague to answer.&nbsp; As a good code=20
as<BR>&gt; multi-threaded audio apps, you can find jackd, for =
example.<BR>&gt;=20
Xmms and co have also threaded audio output.<BR><BR>&gt; =
Takashi<BR></DIV>
<DIV>Yes, 1 thread for the audio and 1 thread for the interface.</DIV>
<P></P></FONT></DIV></BODY></HTML>

------=_NextPart_000_0058_01C69BD3.860B4C90--


--===============1730800037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1730800037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1730800037==--
