From: Kristof vansant <de_lupus@pandora.be>
Subject: Re: I think MSI KT6 Delta-SR also needs   
	VIA_DXS_NO_VRA in whitelist
Date: Wed, 11 Feb 2004 18:54:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076522094.2848.2.camel@D5E03F95.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

How can I see that it is enabled?
I patched it and installed it.

At Wed, 11 Feb 2004 16:02:00 +0100,
Kristof vansant wrote:
> 
> This: ?

yes.

> 
> 
> 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/
> A/8235 AC97 Audio Controller (rev 60)
> 
> 0000:00:11.5 Class 0401: 1106:3059 (rev 60)
>         Subsystem: 1462:5901
>         Flags: medium devsel, IRQ 11
>         I/O ports at d800
>         Capabilities: [c0] Power Management version 2

could you test the attached patch?


thanks,

Takashi




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
