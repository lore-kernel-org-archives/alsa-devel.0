From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Fix module build
Date: Wed, 31 Jul 2013 14:59:25 +0100
Message-ID: <20130731135925.GU9858@sirena.org.uk>
References: <1375133852-15248-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6068297398208230785=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B1D2615F2
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 15:59:32 +0200 (CEST)
In-Reply-To: <1375133852-15248-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, g.liakhovetski@gmx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============6068297398208230785==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tQK5n1rKJ9fMEY1c"
Content-Disposition: inline


--tQK5n1rKJ9fMEY1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2013 at 06:37:32PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Building imx_v6_v7_defconfig with all audio drivers as modules results in
> the folowing build error:

Applied, thanks.

--tQK5n1rKJ9fMEY1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+Rg6AAoJELSic+t+oim9UQMQAJFqW1g0FXM39UmsjFZxhIo+
16ZkwR8fo7sZSJYNWksZ0cFwkbrnfmB8SJEIiK6aX8GfFTdPcE+cqG/qc1ntFgH/
sAbV6Y77X1Hv4a8mSKiEE6f1hGG3rSh6fGUzbA5tVE7SmkrBkeYRrOEjRGHxFs+w
gB/mWSagoYfKgerhR0T7lTLnOwV0NeNXFLDiE7fFmfBJOXSavMpl//yhMwNg4MKZ
5v4ZRwbCbBoi2qkMnDw6MRcjsE04vKla/uaYM0aV6Em+2Zk/6sgMp+IoCQLEEkvk
EUzRwn7IyDWa/geyjCtSxCmJJ5mD+QooOIpeUwHuvwYHcUC8hM36LWPiGEka/1Ce
U9Z46rWzjIfPlxfqdCTFmWDRJvTHVXWGAmv9PZqHAI6h3v7Dpr85WSQuJowA12tb
fHpmEGCGOYv/OVoh5cIZF4Odp8f5AdpKL595b99cSwfv8K4/k8n1nL2Hs9xZReLJ
gdw109FkeipPjAcnn5OjwMi3u4by+uLydxcymw9nasMeP4l1vANT0jPEdhxcu9TI
s3Te6Z2r+QK18q3JKUsXwUrC5Q37DKQGRvCkaY7RgrpUrHcMru4FO6TRTct/8G47
tFUmIoKNOoE2idr0eWot1ZlvvGizdTvtZm70Oj+IXxmUgU5QYNl0NhU8kZw9sof1
TWamg8dEKL33ANewpw/F
=eDdP
-----END PGP SIGNATURE-----

--tQK5n1rKJ9fMEY1c--

--===============6068297398208230785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6068297398208230785==--
