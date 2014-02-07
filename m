From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/8] ASoC: da9055: Add DT support for CODEC
Date: Fri, 7 Feb 2014 16:26:49 +0000
Message-ID: <20140207162649.GQ32298@sirena.org.uk>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <9ec36c0633ae8291267be6802a34a469a34ae292.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <20140207162504.GP32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/OC9VIUhC1tLvmgX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140207162504.GP32298-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--/OC9VIUhC1tLvmgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 04:25:04PM +0000, Mark Brown wrote:
> On Thu, Feb 06, 2014 at 06:03:09PM +0000, Adam Thomson wrote:
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> This doesn't apply against my current for-next or v3.14-rc1, can you
> please check and resend?

Ugh, sorry - it'll be due to patch 1 of course which I'd skipped due to
the MFD bit.  If you need to resend it's probably easier all round to
just send the MFD and ASoC bits of that separately since there's no
direct dependency.

--/OC9VIUhC1tLvmgX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9QlFAAoJELSic+t+oim9bbAQAIWHlSl/4fPwKL0+LfDkDNE3
a98gt5tuWOdWH0U6n+s7s0D6y9cBcd+rlyBfQ3KfWXJmwzaZ/23yHtarPTimiHsp
QU1ANvN054dnAydl258CQpJmaaEcMRMz4c3p8qR9TG25r9hH/5lAn/bYZRNlgf1D
/7dpNQenDEV7aORQbmj2I8y1zoRpToao7jMzHklU/9cEzG2OjLH+HFMyGNmf1dcA
001EXJ6AhxFqCM0jKHSCnL94M8ntYqcypVhf6KyQwTlMsXJQpbgbnyZNJUuvP01D
D17C9rROMIRMnRr5HNS3d14N4YgTm5UnXG8/1rvd5RFJJOVcASFB67HXEcv3hpMi
XmqRaTOx+EVowYaFEl5b+wgL6plHO2fgpClLC0U+pDJf5glDELUBXDF6IFtdu0th
daasBuGdNw+bQfTv+KX57StcrP++g+82ZxtR1m4UiMI2A4oP1r0COTqZrFkvI8vo
CkgqvS47zzpbfO1FuRLUdu+cnX/tkasdm/UDAZjeagPczXsayPQL0vuf+DS11nZ1
g/ENcSy5EiPGnIvTx31lDVY1fzCrliCMszec1hYZBGG2IoBEdkzYk3xwfBbz0hnK
6tz5HzxCVqb8RSZGm1aE91AF7x12zfkAgv2/Lmq7RrM1BgnD3hntEIgnpfaRS24f
tnlB+yxuHEjyK5HWdDLc
=OSvq
-----END PGP SIGNATURE-----

--/OC9VIUhC1tLvmgX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
