From: Luca Capello <luca@pca.it>
Subject: Re: Fw: [Alsa-devel] drivers in alsa-driver tree with 2.6 kernels
Date: Tue, 16 Mar 2004 00:14:40 +0100
Message-ID: <405638E0.5030209@pca.it>
References: <20040311180122.30343d89@sashak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <discuss-return-13430-lindows=m.gmane.org@linmodems.org>
In-Reply-To: <20040311180122.30343d89@sashak.lan>
To: ML ALSA-devel <alsa-devel@lists.sourceforge.net>
Cc: "linmodems.org" <discuss@linmodems.org>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/11/04 17:01, Sasha Khapyorsky wrote:
> Takashi, ALSA maintainer, is asking now for confirmations of 'intel8x0m'
> AC97 modem driver usage.
> If you are using this you may report your case to
> alsa-devel@lists.sourceforge.net - then the driver will be submitted to
> 2.6 linux kernel tree.
<cut>
> Begin forwarded message:
>
> Date: Thu, 11 Mar 2004 14:27:59 +0100
> From: Takashi Iwai <tiwai@suse.de>
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] drivers in alsa-driver tree with 2.6 kernels
<cut>
> does anyone use the following drivers with a 2.6 kernel successfully?
> if it's confirmed, i'd like to move them to alsa-kernel tree, so that
> they can be submitted to 2.6 linux tree soon.
<cut>
> - snd-intel8x0m
I successfully used 'snd-intel8x0m' on my ancient laptop, an ASUS M3410C:
 http://luca.pca.it/projects/asus/m3410c/

My success post on the 'discuss@linmodems.org' mailing-list is here:
 http://linmodems.org/cgi-bin/ezmlm-cgi?1:mss:13083:200402:pkpdkliklhpapcodpmop

I already posted on 'alsa-user@lists.sourceforge.net'
 http://sourceforge.net/mailarchive/forum.php?thread_id=3847625&forum_id=1751
while it seems that my post never reached 'alsa-devel@lists.sourceforge.net'.

ASAP I'll try with my new laptop (an ASUS M6842NWH, M6800N family), just to have
another confirmation.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAVjaSVAp7Xm10JmkRAj2fAJ9kSAHE8m+nE9nI5iMFd6+4KBg4OwCfbZod
suN/ukkIhXgg8kuDKxrx4DM=
=h2J6
-----END PGP SIGNATURE-----
