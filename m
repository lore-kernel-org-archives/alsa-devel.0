From: p z oooo <pzad@pobox.sk>
Subject: Re: Need to know SBLive Chip difference
Date: Tue, 30 Mar 2004 10:28:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403300828.i2U8SJK7020343@www1.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www1.pobox.sk (www1.pobox.sk [212.5.216.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA08983
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 10:28:18 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guanyim@hotmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't mean alsa-oss-emulation, I mean oss driver from=20
opensource.creative.com or linux kernel. If it works, than something=20
is wrong with alsa (I think it will not work).

In SB Live up to 2002 was used AC97 codec for front and center/lfe=20
and another dac for rear channels. I think, that in SB Live 2003=20
creative started using 6 channel AC97 codec and rear channel are=20
using this AC97 codec too. I thing, that only some initialization is=20
needed to get rear channels work (option 1) or rear channels are=20
connected on diffrent output from emu10k1 and this needs to be found=20
(option 2).

Peter Zubaj
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0ASpolocnost SUN Microsystems uviedla na trh novy server Sun Fire V20z=0Az=
alozeny procesoroch AMD Opteron.=0AViac informacii najdete na : http://www.=
somi.sk/sun/v20z.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
