From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH V2 2/2] ASoC: Davinci: machine: Add device
 tree binding
Date: Mon, 7 Jan 2013 14:27:40 +0000
Message-ID: <20130107142740.GG4544@opensource.wolfsonmicro.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
 <1357293277-25543-3-git-send-email-gururaja.hebbar@ti.com>
 <20130104122612.GM4627@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EB3690C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB3690C@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "rob@landley.net" <rob@landley.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2013 at 09:20:16AM +0000, Hebbar, Gururaja wrote:

> I will be looking into this now. To speed up the things, do you have any
> reference link/implementation which  I can refer to?

Any modern CODEC driver.

> I looked at the OMAP implementation but they are following the same (meaning both
> DT & non-DT use similar audio map for routing).

You should use the same setup for DT and non-DT.

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ6ttSAAoJELSic+t+oim94ScP/3LQhaeyRGpPovAP2xCS9AN+
QzsrhxO5i/BA4eInaEsah+mEfEXOGEN0rnsMEOm1TiGR2DKQJYfyKcngIOz8RHLv
mB2ZOOFmEpfuqIoh/bAq5EiAxuXOXKMxoXpHvuLHCNB3PA/G3q0OXBOiKXbuSg9a
cnuQrcZ9wf3YBOeD6B/DGNiYq3bshBmZx+4fAtkOTW9ySGnaepO84pzjVCfE2a4Q
xITRGWcLTr7ZhchUxFr3AeKKgW7iRXaigEUZDz8OkxHa2tw5GCEsTqDccC4Kk8sk
XaSD6KpgumNhZP2zL1jssKuNA9m1nS7ADaSQSLOO3/V+AL4/eiIUH9M7/ugUmZrz
EZd7l078VjedvDZPVYTGCFfFHmMO44yht7pglurEY2LmvTySCv7CErppAP4ir7Mk
uoUpnlKH7bGrWBIpRI/dv5+ttd6EPj32x6VdK77mGulJQ3FAEYG8hMHPMRNL2Etm
xbh9m5riUpz2kFvUbaBSobwDy+57bSB4PKzS9T5/E9+3EwzUYJAqB2s6haDG4dAi
gQQURKwfNxMuT1T1y4/d0UYE9F0CHb7iXY6+0iVsv9LxprgN8t2IIPgNBy6SNt5q
6oRQGeVOymgvIqdLUK4YYn2vmvNCRjYRfzMBnhGpldOLOKSDZevxaIxUmpwu03Sn
HZRhza9ZvC05ElJHwZ+1
=EDmV
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
