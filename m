From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/6] ASoC: Intel: Add helper to update
 register bits with attr RWC
Date: Wed, 8 Jul 2015 19:47:23 +0100
Message-ID: <20150708184723.GC11162@sirena.org.uk>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6300184387664148062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F85B265A3E
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:47:27 +0200 (CEST)
In-Reply-To: <1435919647-14049-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6300184387664148062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NSyv3PxMn0vTUI/G"
Content-Disposition: inline


--NSyv3PxMn0vTUI/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2015 at 04:04:05PM +0530, Vinod Koul wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
>=20
> For SKL IPC, we have some register bits with attribute RWC. So we need to
> force update them. Add helper to force update this type of registers bits.

This doesn't apply, the header already exists.=20

--NSyv3PxMn0vTUI/G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnXA6AAoJECTWi3JdVIfQCYUH/A6Jrlff6fdVIDddfS6bt8Pz
xLywfakJ508XJV+kKxkxJZ+nl4nWHW1F1erlcODf1Wo++LKuhwcZ9gNzzknwQ+l4
O7a+0bClcGbVrh/tV1dsygmPWwuCFKVRKoG3gZVqGXqkbFSC6oalLfQp/AYC6Mwt
BIixDpjURo2N28wEn1K0XoUd602R+7GWhhaQ0ZMg18l+FqHj9kEqAXJgl6wBQZ+b
zBWymjL+8PYIvuY7obDuk2URDCgwn2IVpKx14pWcae8Sf5YeDdy66KyWFQmuU+Hy
Jh/K20QaZSX/YPajETiKKsnkhp8FbfhxTSyTW4XCQBTR1de6X8NZI7Q3XefFDCs=
=27Q1
-----END PGP SIGNATURE-----

--NSyv3PxMn0vTUI/G--

--===============6300184387664148062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6300184387664148062==--
