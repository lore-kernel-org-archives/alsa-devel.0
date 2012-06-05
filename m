From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l73: Convert to
	devm_regmap_init_i2c()
Date: Tue, 5 Jun 2012 11:03:50 +0100
Message-ID: <20120605100349.GH23408@opensource.wolfsonmicro.com>
References: <1338833982-25482-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1738571135957428097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A818103FD4
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:03:51 +0200 (CEST)
In-Reply-To: <1338833982-25482-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1738571135957428097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 01:19:41PM -0500, Brian Austin wrote:
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>

Applied both, thanks.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzdl+AAoJEBus8iNuMP3dIk8P/2dQKqiIgnu3usK60sm5V3N3
QN3ihfY18CWSUiysA/i3kNcsJf8BDWOMPfvbqT6s2VklpntrwyVsWa8iiGK5RDSp
s2JZjMNhjQt4KxCyuOX2djyNxGW0FlpNu/4ESMo3Van9QAi13Bpxgxh67nLehliV
00lVQyD6j8wHThRsoJZp7IcVfILipSUyh6TxQm7Jqyf2h8Mm/mlrQDbn6AI1uyUu
VSpCJ3IQ0J1zaY5vp1M/HdYhITQePQePGaeW2899lgsWmMiimCd7PHXU0n6k/m1u
Uit7T15i6ZmLPG5sDo+EbXVGgfmO8N2fbiVHkWS84UT0Mcl+5YWv0/c0oBGPEGL2
jmXMI37Ze+HHvf7omVehua6Z6i6gA7I4fhremUdBAOpAkvc74N+wszUcxlghnyJt
Z6ZC8utOmpLli4NFYf433l7PPJbc7crNfutYhQR7bc/KmZ8OjlWOs1HPNUgLxlCO
nFDV3XjK+JSA5kEgxJFOyAUB34yq5t7wyzBoFtDLR1xe7MDSCkTt5kJsDeJFtQ2I
Vah7ZL1poSbRym5g/eoL3P+crL0GVpwsfYd/0qgpVuImyk6x2YUHNNoz1TGFSUnQ
WTX11J/6IjmgLzfI6kFy7AcwftwO3FZLtMxhHFLBimfSVsGpLcqH5+gIIBdzCm7G
PGxJpbOfPSSaH8a6KNwU
=yuN9
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============1738571135957428097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1738571135957428097==--
