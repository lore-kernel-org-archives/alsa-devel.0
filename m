From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/18] ASoC: wm8731: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:14:11 +0000
Message-ID: <20131127181411.GU14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-7-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7780118275207453126=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B9BD2652BE
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:14:13 +0100 (CET)
In-Reply-To: <1385044736-14911-7-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7780118275207453126==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N+XLEcmrpw+t5qL9"
Content-Disposition: inline


--N+XLEcmrpw+t5qL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:43PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--N+XLEcmrpw+t5qL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljZwAAoJELSic+t+oim9LrkP/1gyzzuAUi5rL1ARLw61b1/I
PaT6MSKjvRfQUAeWAqejFbtOUPShs42g8UozNW8C9IVwT2LI8O5K9/llEc96fTYU
fAAgtVciK+IPtkLZB5q/U+zP8qUB84/nw7soV5ljivORw6Cq9o8/f8IYJn4HkzSC
PnoQDJsVgcL/BL0/0+B9veZY0ApANE0eYlskvs0zzogcB3UgWa6l0KebySsiqjAR
9jq1f+I9zH6ph1FSFn8wg9OllwmsfwzcQp5BXvRTJcR+oJv3s9bWcVVguKdyPiX/
uWSJMsBQTxXVhlmAx6R/9Zm4xXUbWaIVPIW4VIlP1R2OIpJOSrbYK2NmyB5VcfTY
iNAxb/heKGWUFglBrCxJcoTGwYuBXGyVzvxda5Vhqv1PWufc0GnuNEmDlrScJFC7
1M6BpycZMYMggEqg8h23osoibAqiZ4KmDAQfuWzqNJBffd9SdsE2oll4QUVOiJPz
aESKxqMaJuMpWi0EqOXI3zGexorSxFz7uXG9X5fWjcPmVZGAIzSEbuL/MSoAd8qM
ZFmTlLj5jhMDHkKtXSbMOEw2Wx3fWqzZ4oUpv4M/hmqEnTqEMwq+LBwgXFS8F19f
bm1FbSQZeaUPlaLQH+z9g0wX940kk8pNpP1DKMRP3i92mQau1xLVgX0NEyjLI/D0
4r0dRkAsik3MM/Jg8kBM
=XtV3
-----END PGP SIGNATURE-----

--N+XLEcmrpw+t5qL9--

--===============7780118275207453126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7780118275207453126==--
