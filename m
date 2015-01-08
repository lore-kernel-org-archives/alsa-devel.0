From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: fsl_ssi: Make error message
	concise
Date: Thu, 8 Jan 2015 18:35:03 +0000
Message-ID: <20150108183503.GX2634@sirena.org.uk>
References: <1420645476-13193-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6832225555236331830=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A28D260504
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:35:08 +0100 (CET)
In-Reply-To: <1420645476-13193-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6832225555236331830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ijl6cC5PotpeSsNi"
Content-Disposition: inline


--Ijl6cC5PotpeSsNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 01:44:32PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Currently the error message uses 'np->full_name' which leads to a very ve=
rbose
> log as:

Applied all, thanks.

--Ijl6cC5PotpeSsNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrs3WAAoJECTWi3JdVIfQlPQH/js2Rf6k096evcsLjOE71IaP
XiSLWMu0AwRSIR3Ja/tnSsKg2x+M3cSc7EQqDKwF7T8te59HMRb0EDV+dXJdyr02
KV3/4TsNneRHl7x7mQjH18wmLrVXBxGpNfLff09/hUBRoubXyBPA2uvuiZVFYtLx
Y52DJg7oLQYBSWo8wobvDE0w5RDLORHOVnIVHF4utuZRejjNgI9xjJHP6f+Y1QbX
KUUtAl/kPL5AVo0v6qUYDiunqP415KIgzpD5dW/CQzAPN4LgSGUFbx6OVlHMK3RY
mMu//SLCI+EzmLXMW5Yra0hwt9O92ssBX7W9DbX4m8gLHj7WW0IVEEDbJd2yrPo=
=cZaj
-----END PGP SIGNATURE-----

--Ijl6cC5PotpeSsNi--

--===============6832225555236331830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6832225555236331830==--
