From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx_mc13783: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 19:14:35 +0100
Message-ID: <20130702181435.GW27646@sirena.org.uk>
References: <CAPgLHd9uFhvTi+Kw2RkJEQLVepeC8K0WA2ZhPY=N7jveY0T3OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q6s/hoVGC5OdHMNF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9uFhvTi+Kw2RkJEQLVepeC8K0WA2ZhPY=N7jveY0T3OQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, wfp5p@virginia.edu, fabio.estevam@freescale.com, shawn.guo@linaro.org, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Q6s/hoVGC5OdHMNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:26:00PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add missing .owner of struct snd_soc_card. This prevents the
> module from being removed from underneath its users.

Applied, thanks.

--Q6s/hoVGC5OdHMNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0xiIAAoJELSic+t+oim9fmQQAIv0Du3IQZw9ZY1iddprQdBY
jRVeq4Xf0xnvNTnI21FZH76zNcm9NZadjXYJ5b9SMPhD0m0F8R5bpqjDZ9S0hR4u
60Tp/FLyOpg69OO/5Fotjcp7bGPz9gwtgoNxYqmr3oupqmWYflVOemnzeD+rRZDp
g5z80r3w2hjGoighfFl/c3qjVBPLZh2uLri2e4OQFVZZxWCXlUS4Jw3mKttoS+zZ
ugjDfNPZutUtA9dR/Za64B0wfWz6TCg/AgKi2cC37hJtUgDkaRaWsoPqt/W4yc5z
g1Dn1Qm9Pe8ddxy5WtB87Ftz21fNHpSS5CZ3lfB33tIThGXeGeo2Kpjvz/w7PT+l
ANhKbmPrrVF/HVxV1Ptpo6xdVKDZXoF+wuzTpWNryhz1hMIdDRRtoSMIWEmq1wNk
5fV4e/zHPYltsq1fnXYMLKJEuVXmIxd0NANICaULog2xhqEuM9u2BcGZ6NZ++2X9
h2V4iDT0k6xS3WJo2/l7mDUB7oMj1tPy/EEjDoLwPW2bry8WUavduWDSLx2IPOVq
hy/1oU/OjigYfmdwj3K/1UXiF2xSUhPKVLxcbZJcLOIwH0qzWZssiaNLMROK2x0Y
k1qqjhRo751H/1JI2V3c1wtSgfZNacs+Fj5yRbsLoeSP6txM9FZ3tm6G0f1X82TQ
lgChW2NGBAPRar+QmZ3C
=gXSw
-----END PGP SIGNATURE-----

--Q6s/hoVGC5OdHMNF--
