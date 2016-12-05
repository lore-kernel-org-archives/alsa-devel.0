From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cq93vc: enable compiling on COMPILE_TEST
Date: Mon, 5 Dec 2016 11:37:07 +0000
Message-ID: <20161205113707.3f2qum7coazy2jrg@sirena.org.uk>
References: <87r35rugmc.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="54pxtl6x5nlia56v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r35rugmc.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Jeremy McDermond <nh6z@nh6z.net>, Bard Liao <bardliao@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--54pxtl6x5nlia56v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 03:59:36AM +0000, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> I posted cq93vc dependency fixup (=3D no depend to MFD_DAVINCI_VOICECODEC)
> patch which were 2 patches.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--54pxtl6x5nlia56v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhFUWIACgkQJNaLcl1U
h9BUtAf/Udez+jEQ1AkbI1gS991oZXixhyvDgXlRm5qUkulKuUMf6IdH4Z+klemd
TK9A2eS1yz9CTcdIdJ1AJJisLpsB9JeB+oEzaHodToiaxn7k2TzCRxU2mtEX4hQf
07Es6hvIsyuoFZL1U646x0lcm0WqP8Vq98p1oOIbGUN020CFW/Y62+KzNYBsyoG1
Ipt9pkzodRnAwbD/x1VB4LYmRXge+w79LB4/6+fv5JBduhl4MNGlOY+pEix3Fcsp
BBlsVOT5OystrrPWF1SvPDTd92+Eg3rbpoHbQbLLXcl5evR7FcteAF2/qAZqR536
sGBUlcJz4K+seYxgWg+mx0rrzec65Q==
=hMMR
-----END PGP SIGNATURE-----

--54pxtl6x5nlia56v--
