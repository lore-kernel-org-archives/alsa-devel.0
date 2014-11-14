From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rt5670: make bias level more
	reasonable
Date: Fri, 14 Nov 2014 11:11:48 +0000
Message-ID: <20141114111148.GZ3815@sirena.org.uk>
References: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1797233258211256565=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF7CD26660F
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 15:03:47 +0100 (CET)
In-Reply-To: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1797233258211256565==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8jeM6GlsTyYq3Gb"
Content-Disposition: inline


--c8jeM6GlsTyYq3Gb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 07:54:30PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patah separate bias level off to standby and off. The standby
> level will provide the necessary power for JD and push button
> functions.

Applied, thanks.

--c8jeM6GlsTyYq3Gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZeNzAAoJECTWi3JdVIfQdmwH/ieL1UfHLz2qAZZPd3p6BA0T
kV77kU/V/BjDN3ROd9uNVGW+b/xLTRzH+u7jRDdT2X9OW782mMxFniU3XLX85MXu
asIFnPSD2b8oXSEQZsNI2GeHRiSsy7ivGWHQF5itiH/TBsRce9HMytGwmi3R6j3i
OmOl5rMTyWP6R4d0TheMfKtldhReI2YSQKURZBX21RRiCHy5MhyvzGZ434xwNQ0X
b6CcXLdxebvkUt1XhcG+32t2vEo5h29kO0TDdhxppbgGBMuuV5zQ/1k5iboWb4wd
NIMLrLrdr2gW5oMfMHD7dt8SZNvxMMkXOVQL60JX3Tx3tqZk+73zYGr97sgeobQ=
=JENf
-----END PGP SIGNATURE-----

--c8jeM6GlsTyYq3Gb--

--===============1797233258211256565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1797233258211256565==--
