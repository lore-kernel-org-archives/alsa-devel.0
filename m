From: "Vrihad Shoonya" <vrihad@softhome.net>
Subject: Re: Is there plans to support SiS7019?
Date: Thu, 19 Aug 2004 19:01:25 +0530 (IST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <2878.192.168.0.30.1092922285.squirrel@dev.datamax.co.in>
References: <200408191314.i7JDEEAK015224@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408191314.i7JDEEAK015224@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: clemens@ladisch.de, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

>>It looks that the driver must be written from scratch,
>>because hardware is different from SI7018 and SI7012.
>
> I don't expect alsa driver for this soon, because this
> is not common hardware. This means, this is not standard
> pc soundcard (or chipset). This is used in STB, PDA,
> embeded systems... .
> For this is more used OSS drivers, because of alsa-lib size.
That is true. But the problem with OSS driver is that
recording is problematic.

> PS: I wonder about existence of NetBSD patch, because I
> found this:
The info was still under NDA when we got it. But they have
agreed now that info on audio section and code can be
released to third parties as they have stopped development.

-vrihad



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
