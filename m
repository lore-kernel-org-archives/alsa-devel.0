From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Set the card owner
	field
Date: Wed, 14 Jan 2015 17:14:00 +0000
Message-ID: <20150114171400.GW4160@sirena.org.uk>
References: <1421243782-26115-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0336980047112949198=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B18C26069F
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 18:14:16 +0100 (CET)
In-Reply-To: <1421243782-26115-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, jiada_wang@mentor.com, nicoleotsuka@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--===============0336980047112949198==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IfhPODtivl1BCmut"
Content-Disposition: inline


--IfhPODtivl1BCmut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 11:56:22AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The following crash happens when trying to unload the snd_soc_imx_wm8962 =
module
> while playback is active:

Applied, thanks.

--IfhPODtivl1BCmut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtqPXAAoJECTWi3JdVIfQ0xwH/0RIJx4jJdiLgObils11mj+3
fY+KtkbB9DPuDTUknhzZrwwjwBF6dEfZyi0lzq485Wv+CZEG+3Z2v86Kf+ock8my
yJfsSEcOy+LpO37Yia8MNv1lxM7KvQBdyl1MC3xQQa23tOKnFAP071XAMarStc39
beZJc07UKzFWAWmj0IET48HXmBfPbd29JzztVtRLbgPjN0Yrd3jbm8U+uN5u1ihQ
QGkJtzaBpeEtLEJv87Ib57XwkEaxBRmg+q6Pq4Z3P9jSbkA6vnKLC469FWX0+hhJ
3jYk28wZwTkNxLtTcYTs91kUHgnBHquDTRZt2HCdurwSlDS0h3I2PfXb4EAfPwM=
=HrFU
-----END PGP SIGNATURE-----

--IfhPODtivl1BCmut--

--===============0336980047112949198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0336980047112949198==--
