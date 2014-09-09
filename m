From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 1/3] ASoC: simple-card: Merge single and muti DAI
 link(s) code.
Date: Tue, 9 Sep 2014 13:02:20 +0100
Message-ID: <20140909120220.GX2601@sirena.org.uk>
References: <1409711021-19277-1-git-send-email-Li.Xiubo@freescale.com>
 <1409711021-19277-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="szlDyXxWT551m6yh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409711021-19277-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.de, moinejf@free.fr, andrew@lunn.ch, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--szlDyXxWT551m6yh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 10:23:39AM +0800, Xiubo Li wrote:
> This patch will split the DT node into old style and new style:
> The new style will merge the single DAI link and muti DAI links code
> together, the new style will be easier to add muti DAI links from old
> single DAI link DTs.

Applied, thanks.

--szlDyXxWT551m6yh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDuxJAAoJECTWi3JdVIfQgjIH+gOVufLik4aa0LrqWmsb0ss0
mU1EjLg7gZsjwh5UHKafY6DblbZuOp1WieXPHeVpZqwID1WkGM2ouIBTaOVM31l8
t0KAMbh+1tBHEo26jb7uD/265QRiNuyYGm9cOD+M3U4PFHaobNUedL2hQ7h46DdU
xsduTxuTiQfx1XXv/5IHKlUsqLeh6mMmguwprmoU8Rr+h4gbaQiCQbf2W67xAFM4
U8/l4Mh1DVEhxU8p1rgiJgKyEYqiJwGwMWT0q9CVQM8SEjpgvSeTS1XPr+zp017+
kWnem1rLvRBZNPQjqlE2GQrok8XHZwxhc7drufEDFMlTND/PMA+tovzqkfb1a6c=
=qh1x
-----END PGP SIGNATURE-----

--szlDyXxWT551m6yh--
