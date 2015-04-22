From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Enable autodisable on
 SOC_DAPM_SINGLE_TLV_AUTODISABLE
Date: Wed, 22 Apr 2015 20:47:16 +0100
Message-ID: <20150422194716.GK22845@sirena.org.uk>
References: <1429707527-5998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2240883060817754394=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C544E265556
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 21:47:27 +0200 (CEST)
In-Reply-To: <1429707527-5998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2240883060817754394==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bYB/dvygrOI2NuBf"
Content-Disposition: inline


--bYB/dvygrOI2NuBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 01:58:47PM +0100, Charles Keepax wrote:
> Correct small copy and paste error where autodisable was not being
> enabled for the SOC_DAPM_SINGLE_TLV_AUTODISABLE control.

Applied, thanks.

--bYB/dvygrOI2NuBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/rDAAoJECTWi3JdVIfQAEQH/096lo07XMUbSr05HNzoS4/n
Nv4JSAxh/BQc9J0CJBhO5MDuNCc0nnnGLGDOq8MAB13VA4fHfm5oAYSFuoq/ZxhI
ll/8aU+spVTDKKBmxIb+uvWEPnklNZnxdCZ4MJEwYdCOEB2ODENO4qnP7QIO7t+a
t0VyfjGBhlg6nfEzUNAh4Lf0q8Dd9zGJrRJWXkZwjbu24u7MLdIk9hXCUsfs8x7r
FvmyezrqqBobKwtj3XplfdcpCz3cKZrFIHlujpOIFMDLqGwbEbX8wqzvpCkna3N8
ultR95kWiKXVaCNBitDtAXLSDQqMuwV/88HU2HIv76Xj10AUkiiu0ck+bhuu+qw=
=8QR8
-----END PGP SIGNATURE-----

--bYB/dvygrOI2NuBf--

--===============2240883060817754394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2240883060817754394==--
