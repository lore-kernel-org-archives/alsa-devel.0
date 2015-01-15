From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/16] ASoC: rsnd: cleanup patches
Date: Thu, 15 Jan 2015 11:38:09 +0000
Message-ID: <20150115113809.GU3043@sirena.org.uk>
References: <87bnm0v5d0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1035403934540270329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A251926046F
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:38:18 +0100 (CET)
In-Reply-To: <87bnm0v5d0.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1035403934540270329==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i483Pv/KqyjCUwB1"
Content-Disposition: inline


--i483Pv/KqyjCUwB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 08:01:53AM +0000, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> These are cleanup patches for Renesas R-Car sound driver.
> I noticed current rsnd driver has un-used function,
> no-meaning parameter, dirty code, etc...
> These are cleanup patches for it.

Applied all, thanks.

--i483Pv/KqyjCUwB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt6agAAoJECTWi3JdVIfQLk8H/26pLHA2OGk9gbZhLd0IQgog
qa4MOm8ilhh14iEuBxG3WePjH/ypJm9DC+Mk62NkUHjm6Nd5RLHYkz7DVvXqVbfv
IHf36okptzicTc/Pay+O8NpZfuRFTF03Sl9aiD7ADITklEV4cCRYfO9QWw5PilFk
0to4N09UjH+hC21XW4QHsm8ICxaMV7xckcjyZQUvKzaPUAfGiyYzb4kM24YtQO2c
0lcXkBCtnVu7xMtlHS1A9kNEKpwOzO4z85soURs3/wi2JY8DwCRxS7SmPPNK9h5b
1r3GNyrlHotflHD16eNxA+aFRdLl0RhyVjFmmPSmVVMwcKJwS49raHsSLMg2v2Y=
=VI+i
-----END PGP SIGNATURE-----

--i483Pv/KqyjCUwB1--

--===============1035403934540270329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1035403934540270329==--
