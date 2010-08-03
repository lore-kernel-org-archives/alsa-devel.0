From: Leandro Lucarella <luca@llucax.com.ar>
Subject: Re: Regression 2.6.35: Intel N10/ICH 7 Family HDA (Realtek ALC662
 rev1) beep broken
Date: Tue, 3 Aug 2010 13:00:13 -0300
Message-ID: <20100803160013.GF3508@llucax.com.ar>
References: <20100803040054.GX3508@llucax.com.ar>
 <s5h39uw6ymf.wl%tiwai@suse.de>
 <20100803134409.GA3508@llucax.com.ar>
 <s5hhbjblscn.wl%tiwai@suse.de>
 <20100803144810.GD3508@llucax.com.ar>
 <s5h7hk7lnxg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h7hk7lnxg.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, Daniel T Chen <crimsun@ubuntu.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai, el  3 de agosto a las 17:24 me escribiste:
> > > I can add such a trivial patch manually, of course.  But I'd need
> > > to know which machine you have (vendor/model name, etc).
> >=20
> > Is a desktop box.
> > CPU Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz
> > Motherboard Intel Corporation DG41RQ
>=20
> OK, it's fine, I just wanted to be sure that it's no other brand.
> The fix is now applied to sound tree, and will be included in the nex=
t
> pull request, then will reach to stable tree.

Thank you.

--=20
Leandro Lucarella (AKA luca)                     http://llucax.com.ar/
----------------------------------------------------------------------
GPG Key: 5F5A8D05 (F8CD F9A7 BF00 5431 4145  104C 949E BFB6 5F5A 8D05)
----------------------------------------------------------------------
La esperanza es una amiga que nos presta la ilusi=C3=B3n.
