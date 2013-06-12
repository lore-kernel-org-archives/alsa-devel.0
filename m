From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] DMA fixes for ux500 ASoC driver
Date: Wed, 12 Jun 2013 17:03:17 +0100
Message-ID: <20130612160317.GK1403@sirena.org.uk>
References: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7UxcOAJ07vnNm5/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org


--7UxcOAJ07vnNm5/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 09:57:56AM +0200, Fabio Baltieri wrote:
> Hi Mark,
>=20
> The DMA driver used on ux500 has been recently reworked to make it
> device-tree capable, but the rework required to drop some "features",
> such as opportunistic channel allocation and hardcoded addresses, that
> the ASoC driver was relying upon.

Applied all, thanks.

--7UxcOAJ07vnNm5/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuJvCAAoJELSic+t+oim9tSkP/0r7rVsDAEreWgy9FWhF6Zjr
wEAVi2bBamEqpCczaA9wImBJLeuVuAzUnBdmfl71R/qM4cxAoutWg3apr+bhrZ6d
gjtPO01mjhgUNZIkPPghXJgNUfGZtZOnyyM9jQSwlWq5SPGj3tmz1WiThHDDaY/8
RgTem1aH5l559GQYa8wfFNtRS9uITvshpB9+/PEnF6RO+U0VWCYFUuQUo6lbflYf
PejS78NBRfXIGqwXB/lhH13VhYUmka1O0ThiwRQy9V1ZtyuvDVgae9kGp8tL899I
grSZvTYlmiS21LqtWWvxTwg2Bl8KSAiXW2rAVscbx0PTeqF7146mi+QQm2tr01eA
Yfazk8cT77pPBoDJgGeeVkxBeezlMwUq1PwXzriFvwoNdqyyvEyfOS2hxe67uGz5
cIAmoOTA0ASYp8BWpTSWVdHqEIWbCaP7EHwhctPgF5gOLNnH4/IsjW0XC59TSS4i
5wDV9yJpSdt9gbInEgqcEkPrUN8jU+ym+iiDbroonwIxHls9w8j8s4IqZOd0aPTB
wElbXd+RempqeENNrayuIF48V2qjxUsPR9KaEWZs3uwkOIAyJ/UIlEzCGl7vCXsM
dORTNInZnxL6Bsk3+WLF2c1uM2ZfzuW2thdZA4YMDS4/5qfYbrhHb0JIjzUHbN2/
Bs6sCNNHgyO4GzrF6XxS
=QHvL
-----END PGP SIGNATURE-----

--7UxcOAJ07vnNm5/N--
