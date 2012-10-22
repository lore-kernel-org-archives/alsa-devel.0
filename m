From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Ux500: Control apb clock
Date: Mon, 22 Oct 2012 14:32:00 +0100
Message-ID: <20121022133200.GG4477@opensource.wolfsonmicro.com>
References: <1350909125-20189-1-git-send-email-ulf.hansson@stericsson.com>
 <1350909125-20189-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350909125-20189-2-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: alsa-devel@alsa-project.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 02:32:05PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> When switching to common clock driver for ux500 this clock needs to
> be handled as well. Before this clock was internally managed by the
> clock driver itself.

Applied but why isn't this a deficiency in the common clock
implementation for the platform?

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhUrIAAoJELSic+t+oim99sgP/jjXO+8QWb4vTVUjhjQfL0ed
3L1HotmrwDJ0n4txZkF+oNd5NYZDs6m/2WdCDMMkgEDeVj/VdCu/31ZY21oNWK0R
sRbYeRh4FRo7SCJNYj99o1eLGUKvUynxvFnOs1s91kB3QTuYGD2xoBaxMW3WuRSY
WPXERsJfYVfInUQlCQfTL/4oCPC+IVUbMqQyvoQIKhTryJ6wshCm+j/KnIZMjo+C
9gCNs32gamMOdEW/UGHS0NKnu3+4zuFDJvx1rDIaf1q1BM+qba/FH5UopKHdbxg8
jmDCkH1g4op99AYkTAXd9vAVwbohh+eWvyUUd3WJMQPBqruXOEvP89n63H2y2+mx
tx6qmvfMnLbZatfxegyeL/4y97Cm+N4vzzGho6TiFOG/VWv1YCQToMRhP3Hh8lrg
HcPl5xQQqdtjEKxXYMvax8ZYhb8yKQKIepcMtBAvCQH6d4Kw75MVhsdOPIb6RsC4
C8JHxSXkCfSKdN8LTaRFEbVjFS7wPWKP8v4qKFhUVo6TryKHp/hBPmG9A/4P8d6F
RjztR2UoIFDnrFyorrpO0twFss1M75DsWcvTCeJ9dbrpm7nRbEmcYc0advsUB3n6
EsR3q5b+Pvh2UeesAJYT/uP+3lL+ZigIC65Nrk7TWSj+nbjWX5/UxC0rCPU9/goh
YDpS41qCJ6s034ny/xHC
=D1dI
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
