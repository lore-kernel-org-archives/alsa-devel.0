From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Date: Thu, 1 Feb 2018 13:48:40 +0000
Message-ID: <20180201134840.GA10785@sirena.org.uk>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
 <1517475954.8615.18.camel@nxp.com>
 <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vf=Ap7UkMNOcOhzY+MjJmn-c-UphzEzAjmFtMh69kea4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>
List-Id: alsa-devel@alsa-project.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2018 at 03:20:38PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 1, 2018 at 11:05 AM, Daniel Baluta <daniel.baluta@nxp.com> wrote:

> >> > Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> >> > Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> >> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> 4 authors of the code?!

> > The code has a very long history. I will add under each SoB the specific
> > contribution.

> > Mihai got the code from Junichi and reworked it for 4.9. Then Shengjiu and
> > me added various features and cleanups.

> > Any other suggestion?

> Yes, please, put detailed credits in commit message to not shock
> people with so many SoB w/o explanation why.

Honestly the signoffs above are nothing unusual for a driver contributed
by a vendor - things are often bouncing around internally for ages and
it's good to keep credits for people.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpzGrUACgkQJNaLcl1U
h9C3lQf/YZrAB58+vemPyqBByphuou28a9BvXQ/NrWpcN/wLzkAv22E1xRFE+W4/
9B1LiXWVBqK1viKoVkNRjl1JLMmRZeeQTVaoxLIO9IMW2lx9dSLvC0nK65J0BoPY
8cY4y8pnv64ZBKrI2L7+zRD79r7R3e/0HMfMVf5fYetrKMjAunEh+QtIqrZyFMFn
rLyrfYWrfi3pffDVooNU8OBWn6paOSiRcWyqUb+ddOWVAfOozM8DAhtlZavip513
XN+JDwHB7Sj+ZPxcDPILGwkxwX5yBqmOn82o8GtA8tlQ1XtLapXVKLyvXLkABkfv
2q4zeuuhTEilCcbKBgRmFe7doXm0Bw==
=x7m6
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
