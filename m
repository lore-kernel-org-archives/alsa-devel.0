From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: RT286: Fix silent at the beginning
	of stream
Date: Mon, 7 Jul 2014 16:39:22 +0200
Message-ID: <20140707143922.GK30458@sirena.org.uk>
References: <1404731730-21364-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2124688366892443206=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A06E1265232
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 16:41:12 +0200 (CEST)
In-Reply-To: <1404731730-21364-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2124688366892443206==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 07:15:30PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch fix the issue that the output is almost silent at the
> beginning of starting a playback.

Applied, thanks.

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTurEXAAoJELSic+t+oim9VH0P/3EOYAcT5v3cd8jce7NZpzME
udgTOBqlCTFl6OtoPW2D2BLsd4rRbBq5q85YD2+mADUwW7D68NMFy1fHpVHAbYQP
bk5e56Ko1LKrgukZy51sod4UGErHlGKJoVFMGo1Q+wvA9YjgzEjQCsenflPnkKuy
+uzmbOWwFJJKLLqdM8cktQCRRAyqg+82SF0ws7aPtIKgXTrMHmbbAVWYaQmJjvbF
edPxDEA2mSvbIEXv95LOlEgoVPD6rQu+Cspfc4VkQeMyv6zbhy3bLDt8ulJXbFQh
deamhwN+7w6Of6SO/pVG/EtP6/RvGmam5Ps/Dq5de6irvBNNC7N19mmN3SHDbK3C
XAfjtvNx26QTBOYiHUxA92XvlYtTxk1eUtP5wf+E3vcK93ANgKUCZ5hFh37PW5vM
LO9n8riXJJYV86/+LDT2EyvChmvavbxN89JT/IVcIPwcHAR+oxjjd7bJ+jfbFQXG
k99S2FpSJlgNlZFNt46O2F5EPkkSXJZIZv5pEcxH2C4SjRdEbZDJSNyzdW6L1+Fc
zmyEelwZPxjP79/66OoMuS2+kCthVSZaMT9NDaKFdbguONGeiKdeVYLHkSyYi7UH
LdO/J+XHRwIYbSBIEfqiB4LUDUFrLALWbaNBTJLKpbtfbUUEYVOTM2j2Q0FaS3TE
g/Vzh7T4i3h66YGLddpO
=0M7/
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--

--===============2124688366892443206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2124688366892443206==--
