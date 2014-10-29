From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: dw_pdata can be static
Date: Wed, 29 Oct 2014 16:57:32 +0000
Message-ID: <20141029165732.GJ18557@sirena.org.uk>
References: <1414597228-7070-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4468445694780622452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6CB72604D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 17:57:56 +0100 (CET)
In-Reply-To: <1414597228-7070-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4468445694780622452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MRsaTmjSwsfaYi3Q"
Content-Disposition: inline


--MRsaTmjSwsfaYi3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2014 at 03:40:27PM +0000, Liam Girdwood wrote:
> From: kbuild test robot <fengguang.wu@intel.com>
>=20
> sound/soc/intel/sst-firmware.c:172:29: sparse: symbol 'dw_pdata' was not =
declared. Should it be static?

Applied both, thanks.

--MRsaTmjSwsfaYi3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUURx7AAoJECTWi3JdVIfQ1dQH/05sBoxhqyB0DZYLO6NU0l4H
r7MqLBlI93e/OecGGYrWL0JFWIUsDw9pmDrba9cy7VbLBsfx7+6aXTq2nPk7N+ey
JbNxPtszpmxgfdz52U/SvWbO3TbDvsBkhMvu4jxjg1IDsO905az9DEkP5F/DJZrg
H+Ciu+9RyJ8vRJhFoZe2Rr7ySZeKgtbBF80UMomrw/PAmRKpFCaJV70h3XKoFNO0
11orUmpwQFO2KNUln5M+a6ZFudE433bI9JM3u+aI9ME7tbh5vHTCYUEO3QL3Ob4I
T4dsucxZA4NI4xRjtXb4gdEqgOrZ1VkCHxfuSb5znyuZiaB9hy7CJ1XRrX51QB0=
=rrJO
-----END PGP SIGNATURE-----

--MRsaTmjSwsfaYi3Q--

--===============4468445694780622452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4468445694780622452==--
