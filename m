From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: enable stereo line output
	power-save mode
Date: Tue, 24 Mar 2015 10:00:59 -0700
Message-ID: <20150324170059.GN17265@sirena.org.uk>
References: <87vbj64dsa.wl%kuninori.morimoto.gx@renesas.com>
 <54DDCF15.1060205@renesas.com>
 <87d25an1z5.wl%kuninori.morimoto.gx@renesas.com>
 <54E7314A.7070902@renesas.com> <54EFB1B9.8060004@renesas.com>
 <87ioenhqa8.wl%kuninori.morimoto.gx@renesas.com>
 <87ioe9sa2y.wl%kuninori.morimoto.gx@renesas.com>
 <550A0C63.6030305@renesas.com>
 <87twxheu5v.wl%kuninori.morimoto.gx@renesas.com>
 <87zj732czb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7694471924311806865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34AA42604A1
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 18:00:32 +0100 (CET)
In-Reply-To: <87zj732czb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: tomoharu.fukawa.eb@renesas.com, Linux-ALSA <alsa-devel@alsa-project.org>, naoya.shiiba.nx@renesas.com, Liam Girdwood <lgirdwood@gmail.com>, toshiaki.komatsu.ud@renesas.com, ryo.kataoka.wt@renesas.com, Simon <horms@verge.net.au>, "takeshi.kihara" <takeshi.kihara.df@renesas.com>, kuninori.morimoto.gx@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7694471924311806865==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 05:15:22AM +0000, Kuninori Morimoto wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>=20
> ak4642 has power-save mode for stereo line to reduce pop noise.
> This patch enables it.

Applied, thanks.

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEZhKAAoJECTWi3JdVIfQoNoH/i5Xk68kvqounGIOOIP2c8DK
dDUiCmqWMEJTAHKyqLcyfCDn656gJ11CpRrIIQCLYkuRe+agWa+1iN6t7lVior3Q
YNDEcNqlMveoNiS9/kwpXmTkDyUG+twBqtAgH76fPIO8KqEh9uH1KQCo2JagG1em
T1qi7/9PSUWKJTGLh5j1rYuo+XrqYO2vP7IuSo/mXi7KE45Hom6V9pucBxrWtTSY
MEJu56Y9qoIHUAIeWgcK5FhQxHayJBnfBi77GfC7gEziUQC6VNGOMsPQjoJWJCO2
kYnhw3GPT6RUkfXHzx2EvFG+9isr6Vr6Bi4hoXnI+LTlbwnXEWMyzfVzqiZNtQI=
=mtCw
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--

--===============7694471924311806865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7694471924311806865==--
