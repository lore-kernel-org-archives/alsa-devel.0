From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: Samsung: h1940_uda1380: Fix
	build warning
Date: Wed, 22 Jan 2014 17:12:52 +0000
Message-ID: <20140122171252.GL17314@sirena.org.uk>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
 <1390392043-24387-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3738061571320271237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD245261A5F
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 18:12:56 +0100 (CET)
In-Reply-To: <1390392043-24387-5-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3738061571320271237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uez3XWYSTYqFCK2C"
Content-Disposition: inline


--uez3XWYSTYqFCK2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 05:30:41PM +0530, Sachin Kamat wrote:
> Fixes the following warning:
> sound/soc/samsung/h1940_uda1380.c:98:4: warning: passing argument 1 of =
=E2=80=98dev_err=E2=80=99 from incompatible pointer type [enabled by defaul=
t]

Applied, thanks.

--uez3XWYSTYqFCK2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3/wRAAoJELSic+t+oim9otAP/1ulXbmgUv/rk8s3XDisYHHS
HalPoRMhs/ks+SMP3TbAZHjLw9ZF9FgS7PYXh3AF0nW/W8JWaoQZwb5OZwCgayDD
5gyUK6Et8HxSTzIRAJ+3+EgUn8emGqNISDvvCBPPkqFtO+83hoDUPCLVinVNy+MX
U2UMv+40d/PJn/+UDzL/wybM3WvIgokBowp7O5J8ke6kP/dKSXuV0Tvcfqh0LXyo
xsUgacjH7XZ9cuwBX9wKJYkFgaZB6Ub+xfnObgzYNScohn0yNRU4qz8Rkc5o5m/m
A4/2ocR9/CpaSP6pxEU6nSQGA5iaVoKMIOKULpdwmc5D95dT+s9k5rmtlMzCrd+5
xywTGm6bL1SXuasD+Jg8sR5jYjWw8F8GP4yDEBpw/qDcxBkYWExeB1cQqMhhShnx
Z4rIb88lUF70IVPX6beaPtR/Zn41yH/E+dXfKhWn7iU0zHuAaXpNLKHqd3b1sPIf
hDpp3grCNYXJzv667Pfl7o5gav6+lKq0pY3nwd1uXRNyLbIcjc6ql4DTlYgzDyjT
BK95f/5DcUxpa0I2M3p5MBF0FGnMCzw+A6yxYLxJCKjb7uRgN1rwaYZ01rAEc13N
eLjMXYH+tMiCd0rtSZgXOYRbcfW+Mk+8xpkKe6Wc/Wp/Ey5tsc2oech2Sx2Aphni
MXSkN0ExBy52WHMimWl6
=YNsz
-----END PGP SIGNATURE-----

--uez3XWYSTYqFCK2C--

--===============3738061571320271237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3738061571320271237==--
