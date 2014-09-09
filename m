From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 3/3] ASoC: simple-card: binding: update binding to
 support the new style.
Date: Tue, 9 Sep 2014 13:09:48 +0100
Message-ID: <20140909120948.GZ2601@sirena.org.uk>
References: <1409711021-19277-1-git-send-email-Li.Xiubo@freescale.com>
 <1409711021-19277-4-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aSM3KCOUSI0G0tph"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409711021-19277-4-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.de, moinejf@free.fr, andrew@lunn.ch, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--aSM3KCOUSI0G0tph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 10:23:41AM +0800, Xiubo Li wrote:
> This update patch will split the DT node into old style and new style:
> The new style will will be easier to add muti DAI links from old single
> DAI link DTs.

> This patch will maintian compatibility with the old DTs.

Is everyone happy with this new style binding?

--aSM3KCOUSI0G0tph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDu4LAAoJECTWi3JdVIfQ0u8H/iDNEPtFnuRUGXXCxZjgT0lY
V92sNeDnbDc61qLYRQGTVPaOjMZoVFvr9NvUKQjeE+iRzHvZwtPipFgkBsp+EmC9
YTVumOxWtDMn6sqQkuoJIdI9ZHZbBnQj1dI9Y4pDfgdPk8UqFZdS1ejGPRHr7dwC
jbtS5PG6iBxAQHyw6xlRFLTP0RWBGOSb1gbVzs6/n7JIvr86NRCbM2kq8Wp9Dy2v
2Eb6xxnCRIH8251FZJcLnZX252nFjoK9tTpcmeuorJw0zvnDRHmvLW7rXpTtPLyk
1QqK6otYCfLn2LcBTYs40M9kxA3YsquACdRy5VX3jwIObHgAy8N3LkLhBC31tlg=
=Ey16
-----END PGP SIGNATURE-----

--aSM3KCOUSI0G0tph--
