From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 4/4] Revert "ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible"
Date: Tue, 18 Feb 2014 21:48:46 +0100
Message-ID: <20140218204846.GC10590@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-5-git-send-email-mpa@pengutronix.de>
 <20140218012848.GT2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0483330319230683759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AA0192651EC
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 21:48:49 +0100 (CET)
In-Reply-To: <20140218012848.GT2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0483330319230683759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 10:28:48AM +0900, Mark Brown wrote:
> On Mon, Feb 17, 2014 at 11:04:20AM +0100, Markus Pargmann wrote:
> > This reverts tlv320aic32x4 as compatible for tlv320aic3x as it has its
> > own bindings now.
>=20
> Please use a normal subject line for this ("ASoC: ...") when you
> resubmit the series.
Okay, will fix.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTA8cuAAoJEEpcgKtcEGQQMGEP/3i0jnWlPNSNhz8Nbt6g5za4
y738Dgwj5YiRsVjA/RGFvoOBeTYJPWRqgGNM/1nkDp1qoG0oNiI18J+Ai3t8TrSs
gzggFau1AS3U5B2gj/rpqX35v6J7+CtpTClF6VJ5CEfk+Wqm61sviok4olKTZ0Pu
FJ11/vwrTNEnb8sUTjxCV8dnXJ5L7ptP/xvjmD2W4F9W7r7//Pmcc/5ANeDnpQn0
3nbjvYtAPTM0WiGzGH/rzV/+BMzRXvgWmVP2Jw4OjUfGBKL1nxaZXOG4D6SPkzqu
+5AxVI1uN4yRKGv1SQBmPC99d6Uic6j36KP3TdO1FQdDbzOOUMc80iAxy5nkOnU2
oCtew/lnUlHM17I1wDqkiX7jqtCoIHLPUPzTOK5SummqKaaiSiyqBbRCW/ZMXpPf
6neHBwX1TFou2jY4tfpaUbkjRph8XliTTke/3ghDQp7GIePVyp2xGESCCj59FL0C
cLROrocP7h5taYj5NdLj1DSIiJXBIWdzn0p3hJ2KnFVQvaEz6NAGSAag5yXjVh9z
tnh6Np8BBiPEcSEykoo0rPheT9Y5hGs6+7fBYwxF3w85pIVOMQ38tZL4vc7/zlnz
4F3LDr8irOJsPBhE8ZC7ylSlkvFusOalFVEtX2TkHnUX/KF2uzKCFBxQMqaiG67U
1dPRBYkbdvi1DDjiwNVF
=pfuA
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

--===============0483330319230683759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0483330319230683759==--
