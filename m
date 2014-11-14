From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670 : Add ACPI match ID for Intel
 CHT/BSW platforms
Date: Fri, 14 Nov 2014 10:34:31 +0000
Message-ID: <20141114103431.GS3815@sirena.org.uk>
References: <7008ba4e47e5b26da2114bfbc65b634e4c409212.1415951477.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3260766490833410262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6AF1266614
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 15:03:23 +0100 (CET)
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net
 ([94.175.94.161] helo=debutante)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1XpHT7-00025w-ND
 for alsa-devel@alsa-project.org; Fri, 14 Nov 2014 14:03:22 +0000
In-Reply-To: <7008ba4e47e5b26da2114bfbc65b634e4c409212.1415951477.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3260766490833410262==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQ3geqO/wycIFb3P"
Content-Disposition: inline


--uQ3geqO/wycIFb3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2014 at 03:51:34PM +0800, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>=20
> This patch adds the ACPI match ID for rt5670/5672 codec.
> So on Intel CherryTrail/Braswell platforms, the codec can be enumerated f=
rom
> ACPI and depends on ACPI to get platform-specific info and power saving.

Applied, thanks.

--uQ3geqO/wycIFb3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZdq3AAoJECTWi3JdVIfQ/MgH/1Rl8Zso/3RwkSF2iI8TIqvD
KD46zDlqZmGr+umhl6zcatXDZQXxCUxHFg5jln9papTdsfAdYEzGVqAz4xaFIHby
0sXymzoJkYxcmnyiPg51QkUTTYzNncgVErZmGxXIVZ3Z52LE7UQ0kAWXAFhp5UVP
VzFTjWigSY2PqEoRaATC0KfOzDV/ZTOsWvqOWHyXof00xdJWEGj40Fnay6tpWh1I
JdRRodTAyVR7YWpzdsDSxB7i13ADQRlcTBWhN4VRXAMNaTMHM11c/mbK92d0vW30
tcJ2zkeO5yUkH8pxUQKGRXihCXGZjO0Ym1Zm4DFSJncSA/sRhewgfk2O9hK5pUQ=
=9T9D
-----END PGP SIGNATURE-----

--uQ3geqO/wycIFb3P--

--===============3260766490833410262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3260766490833410262==--
