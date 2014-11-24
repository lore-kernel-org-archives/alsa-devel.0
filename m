From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: max98090: Fix digital microphone
Date: Mon, 24 Nov 2014 17:13:17 +0000
Message-ID: <20141124171317.GI7712@sirena.org.uk>
References: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513378986124655545=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 233A42650EE
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 18:15:21 +0100 (CET)
In-Reply-To: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1513378986124655545==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 03:32:35PM +0200, Jarkko Nikula wrote:
> Commit e409dfbfccf9 ("ASoC: dapm: Add a few supply widget sanity checks")
> broke digital microphone support in max98090.c:

Applied, thanks.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc2csAAoJECTWi3JdVIfQRgMH/RTKI14PGlHGPGYAc0hwpnrD
4idf5KNF2rdn9kC5t3oV3b+yFqJBfahT44duT1/Z1mRmVNJnIVdWSlFaMfKKjj+k
1dwb2kU/vAItm88q6mDeO1CD7zsxVjbExPtkzfgZv4WvEjRMoKkQyyVzQ7McM10Z
tn2R/sp6VNgrz8PwF0hghsxkDvy21obXTRwAyCcE+57EZ1r4ERpI0B2FBaYzseR2
Ai0PmGpr8r0Cg2PELtddUddlQ9aZD6hHl2zusJQNJfLmpQNLCW2/uBDXiQQr7iO+
ZvaOBejcZa/vUcYm8d4y+IjOu9RF9nQdHksbo/HFWR0CYmVfTKa1vT+ODR+944A=
=E4kI
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--

--===============1513378986124655545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1513378986124655545==--
