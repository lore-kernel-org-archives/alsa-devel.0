From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v9 2/6] ASoC: Intel: mrfld: add DSP core
	controls
Date: Wed, 15 Oct 2014 18:17:50 +0530
Message-ID: <20141015124750.GO1638@intel.com>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
 <1413356701-8535-3-git-send-email-vinod.koul@intel.com>
 <20141015131515.GG27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1398291262298253884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B3346260432
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 15:23:11 +0200 (CEST)
In-Reply-To: <20141015131515.GG27755@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1398291262298253884==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rex5+51txc1ort/q"
Content-Disposition: inline


--Rex5+51txc1ort/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 03:15:15PM +0200, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 12:34:57PM +0530, Vinod Koul wrote:
> > This patch adds core controls like interleavers, SSP BEs, and also
> > logic of sending pipeline and module commands to the DSP.
>=20
> This is finne but seems to depend on patch 1.
Okay, I have resent the fix as v9.1 so it should appear in the series for
you. SO if you are fine these two can be merged


--=20
~Vinod

--Rex5+51txc1ort/q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUPmz1AAoJEHwUBw8lI4NHFsUP/A0AcDcV7tTCoo0H7/wEXOZL
3HQ/J7MFiRLtooFJFHQl2UIb6ojLAT6iy33AQwilGrQPYmbRPPeYppCRvE918xQz
T8dkL09Kx+0lpLRycDjDreGQTdXAYjE19n/0Q6NsZBUyVJdpt+voZUhN6ySQAKyn
AW6LhSe/HtvGYPo257B9UVB0tlKtLhCj6594oklyVsK7xuO6CBpEPlOZLA9lFauO
HYq/h8lVIP1Q0Io87BadBCczjE56QEfw+ZqwiZkmj8Oz4pPhx5M8pGbk2VPK+HBR
RJJ2f2lRshC0AJ0SwTt9UUN32LpgBv1YN6YcnROKRWSVvudIF6yxRwQmyTqd66S7
buQ4tS2Fi1VEOPdhGsgA+QvaU9OBDNc/sz/Y1PvHyNaLHI2ZxEHbDBxOU5VBfhDF
Uadyyoxy9ZyAoamdnuossr+zUnRKde2mu6aAHMPFLbdKzbeKwywlChQBN6W9HG+K
dv4ymJqDerNk2WFjvsnps21cl1AbgQsdMM4dJdHPMg9BfFDG/HKJ8WNOV6HTrSeB
wFA4T9AeVr/uxNGYLPpxJSlyHfOLlAwPMGe7amCewnDyUSSzhLqcw9onKbcjfr3T
l+NZ882F+dihx/2G2I12//Z8UtVF/RP7qxvObWALC9IPj6LCHYay6w+0Hb7MSDGq
BfQFhaHDImmG6Mz/KAV1
=BJ8/
-----END PGP SIGNATURE-----

--Rex5+51txc1ort/q--

--===============1398291262298253884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1398291262298253884==--
