From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/9] ASoC: tas2552: Fixes,
	cleanups and improvements
Date: Mon, 8 Jun 2015 18:53:30 +0100
Message-ID: <20150608175330.GN14071@sirena.org.uk>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4933094258588075888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E505260693
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 19:53:37 +0200 (CEST)
In-Reply-To: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4933094258588075888==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hc379uXrspCKzedK"
Content-Disposition: inline


--hc379uXrspCKzedK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2015 at 03:19:47PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v02:
> - Dropped already applied patches from v02
> - Fix bit shift in the PLL configuration patch (1/9) and add macro for it=
 for
>   readability

Applied all, thanks.

--hc379uXrspCKzedK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddaZAAoJECTWi3JdVIfQmvcH/14zDKAU8GvbD3S2bxOh29ql
n+qvEiSwbSDCM1JQ5GjexPeTlcUcGXu7otiMmVskZuwQTnB2aEIytBYFbxUlXu8Y
/WHKtO92ifoA7BQifLYslmgC/GdsHZHG37U96ozLYgOLuNs6tDoyy0t2ghMuU0Ae
/pH0JyJBs9Mp0fPf7HKs/5FUFN36QRfL4BFFGf8OswrQLergKWI/z5mxcSHNBDvW
yCIMyaFqEN0bxRkQvdptoVx98JOFMsRZiQKdjQ5wSLit7vvJkw87eEz8gVEaEvui
ZKAkyw1GaeDkX8gXx80166dLoivWhk24f5QbJD3xzb5lbEAxxdEDClNy56Xs++0=
=oXeg
-----END PGP SIGNATURE-----

--hc379uXrspCKzedK--

--===============4933094258588075888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4933094258588075888==--
