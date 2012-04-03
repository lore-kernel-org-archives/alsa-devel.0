From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Initialize err for
	snd_soc_put_volsw_sx
Date: Tue, 3 Apr 2012 17:07:36 +0100
Message-ID: <20120403160735.GA1260@opensource.wolfsonmicro.com>
References: <1333467752-19132-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8426956443098087385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A70BB103B5F
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 18:07:39 +0200 (CEST)
In-Reply-To: <1333467752-19132-1-git-send-email-brian.austin@cirrus.com>
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


--===============8426956443098087385==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 10:42:32AM -0500, Brian Austin wrote:
> sound/soc/soc-core.c: In function =E2=80=98snd_soc_put_volsw_sx=E2=80=99:
> sound/soc/soc-core.c:2600: warning: =E2=80=98err=E2=80=99 may be used uni=
nitialized in this function
>=20
> Acked-by:Brian Austin <brian.austin@cirrus.com>

This should be Signed-off-by (change looks good).

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPeyA1AAoJEBus8iNuMP3dvfEP/2EWBmtPwVnoCw+WocsBLe6v
Tl8aNkrvXK28CWNqZRMGkigQRMZHgQL/5BHD6Vn7M0Wf/BFXK05qTxYBn7mwWpQY
bTIbLb1CcSgcn2+4edLtmpH539DhiouCx+drksr0KNSdhYO6W2fzEU8wqAP3jUME
t7YqIzHsOJerQ7+8CUjIaAhT0xjRduxmE6v7fW+7Tvn1pxQk9yhfQNeBwxETtyDH
XySieORd4/JFYDzlFgm50y9yaV5UW6sS4iSwb31GZsFLsDiVRiQ/oos+Nd1RulxJ
HBQUeRj900Bv2WP7IIe2xp8HkILmsWlaTPBmq2oAPvj7Xy/JgAeFPqy9jEDLVg5X
lAl3NV2/rlT614E3ZdTd4OBQmgRrVCydSDuFPwa3eBa9aZ+a6b4v0BQ+Wb4B6+L5
ES4XbOYPwFrPT3CUTYNaD3UCykW5EjiLqEOjNHrV5yepA0gtzluL1EfGTk/0unGO
PEOAqRJdr8yvoqcOU2zAK2zXWoXxtZg3NUBDvXvWUnpMEow9cohFsBmICT1gkuoD
QO+liqwIo40bY+j60xABA3ocb+OOYIfL0boTIWndKXzjd8MWMKg9G6CDxzvsQjHl
UVHeS/QTf4E2c9FR8kdCtiehD6rQNs5ltjOnOHFxMfA125buio80BPCGl2f8zzD7
lO4plkUtau6sYnzKzkq3
=OHCj
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============8426956443098087385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8426956443098087385==--
