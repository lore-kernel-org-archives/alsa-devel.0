From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Remove bodges for no-widget
	CODECs
Date: Fri, 9 Mar 2012 12:21:22 +0000
Message-ID: <20120309122122.GL3273@opensource.wolfsonmicro.com>
References: <1331219169-21998-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F596895.2080401@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7913642711482550234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84BEF10BBD0
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:21:24 +0100 (CET)
In-Reply-To: <4F596895.2080401@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7913642711482550234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 02:19:02AM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > I don't actually have any no widget CODECs so can't really test - Timur,
> > would it be possible for you to give it a spin?

> I'm assuming you're talking about the CS4270?  I don't even know what a=
=20
> dapm widget is.  Is there anything in particular I should check when=20
> testing this patch?

Does it power up.

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfW7AAoJEBus8iNuMP3d8xAP/AoTUZ+M//5Yu2TuDFzBoSAQ
3qlIKnO2xokSUAA9LYK+w2B29DYNgjrvAQv1A0VXfcyUehDnPZPpVjuDYGZZhBBV
5TXCI1mstx1DzmunmD1iCPbfR0HFZtDX8wt+2d6QDwrT9NUAa1xAH0tz1UGdz09T
rYa0JpW+yk+2FKY05oGxC4I5FgNpPnHZAfDZ9N4a+/Z0XxYA/dbzTINwuzQqvqmK
VWPyimB+gb+e62Mm/n2aargPJaa7lk6rdx/yB0V6DtUhO8L1KFEfricj4Tv3gYKq
mJXj7UqCwO4+ypMkSI4PsMB6zamngvIpXs2Xh47cFHPzDIosGbkd3W38kpizzF5K
ix2a9pIClI8+qlIFA0rh2k+JJikdgUZBiuE1QxXEP48kq1Xl1D35jzUwtL/5dGGt
tdW7Cmvs3I5hVLC6RcCmRckHAabSVBfuvyXYvocTBr3JABenckvZp7w5hfAWmdeT
RyTuknHaCEvSSyCjDU+8b0hDRoMAxHocVwqWdl4FKq6OIG90Oe9rf3T/toRIgR6F
L5hLfym+V5jrx4MP6iobvty2X9i4tHZ6kAmoPs7RcIW5g8ZydMe+/BTEBit72PJ4
nKuSxo5zs/KtzjIOV3rW62hKHcMHq4ekcRMxzhs31puYUrczIodkE/LGgbu0nnIv
JM0lQDl3c5d9V9Ls1zRi
=sjzx
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--

--===============7913642711482550234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7913642711482550234==--
