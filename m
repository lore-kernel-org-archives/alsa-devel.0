From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Is there plans to support SiS7019?
Date: Thu, 19 Aug 2004 15:14:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408191314.i7JDEEAK015224@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: vrihad@softhome.net
Cc: clemens@ladisch.de, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

>It looks that the driver must be written from scratch, because
hardware is=20
>different from SI7018 and SI7012.

I don't expect alsa driver for this soon, because this is not common
hardware.
This means, this is not standard pc soundcard (or chipset). This is
used in STB, PDA, embeded systems... .

For this is more used OSS drivers, because of alsa-lib size.

PS: I wonder about existence of NetBSD patch, because I found this:

Released under NDA. List of all registers of SiS55x includeing those
for core logic, graphics, PCI IDE configuration, legacy device, LPC
bus, USB, AC97, ACPI, SMBUS, etc; an inportant document for BIOS porting.
Peter Zubaj
=0A____________________________________=0Ahttp://www.pobox.sk/ - najvacsi s=
lovensky freemail=0A=0A=0A


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
