From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: wm8962: NULL pdata pointer
Date: Thu, 4 Jul 2013 10:45:07 +0100
Message-ID: <20130704094507.GN27646@sirena.org.uk>
References: <20130704062913.GC14617@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3840652290711112586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0756C261670
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 11:45:11 +0200 (CEST)
In-Reply-To: <20130704062913.GC14617@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3840652290711112586==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RmrLSWhN5mxSx4z6"
Content-Disposition: inline


--RmrLSWhN5mxSx4z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 02:29:14PM +0800, Shawn Guo wrote:
> Mark,
>=20
> I'm running next-20130703 and seeing the following NULL pointer bug.

Please send a patch, and please send mail to this address which is the
one that's advertised and consistently used...

--RmrLSWhN5mxSx4z6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1UQgAAoJELSic+t+oim9kOsP/judR/bzHjAQ/WrEz1I0p/N0
s7JEiH6X4H5fX6qdbaCXySGa14r07HSk4877SAlzPPykLf+llrs8lmpCGqOZ+okP
OIijPsIXRo5w09MK0oULdW5sMxJ+x1yeJ74TY4bnz4JBqT989JnCqVuAILY2h5cr
RHGI4cTiePgvLDbYeBkjRolho7Gh2wWo+HF0bf7+6zXQ5WPXmKOa/6ZjJXDxvdJ9
dtjAiqP0XZhHc03jWFFPHuxWM76NMuIJbuQZNF4VdVeEpQJf8iLekeioHaOhJ2px
lldQFeZox6ZrRaTz+MoX9S5LwAMdy7ZWfYcfGXvMT6r44MHo/HH/rRhuXFSNjAxK
DqRhaESF8pFBx5jRbGIL2RjiquQnZBe5VSffQAdS0z7KYUscUzGXHBUX5QyDb/ba
wc+wo+ZG/opM2UXTbLZ5kYBxzTl5huFhjsQSMBeUey4n6xDxldisrxE9GgnPJ965
PgRwNji/hEh/mRVm9TosOygRw5nNuSHpisXex6o2kdu65U5N9sf2ZBEjlk3gtU9A
vknbx7A1rjeAvUAthxt/iL7A3Alvb3doMiKRmt0zEFuUYWMofsoIf8aB2BkLV6bU
qLGD1mo5T3IKGQC2v845JeeSWGNsEG3DgBlRksQOkA5QR1LHoiMYDnW19+b2pbva
jPCuad3rCV+Ejcfw3nxm
=0cch
-----END PGP SIGNATURE-----

--RmrLSWhN5mxSx4z6--

--===============3840652290711112586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3840652290711112586==--
