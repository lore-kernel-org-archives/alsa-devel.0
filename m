From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: remove unused function
 hsw_pcm_free_modules()
Date: Thu, 28 May 2015 16:05:13 +0100
Message-ID: <20150528150513.GB21577@sirena.org.uk>
References: <1432824714-26686-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2254761141563963571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B735F2604DA
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 17:05:20 +0200 (CEST)
In-Reply-To: <1432824714-26686-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2254761141563963571==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bepXcx/bRK16yA0/"
Content-Disposition: inline


--bepXcx/bRK16yA0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 10:51:54PM +0800, Jie Yang wrote:
> Remove the unused function hsw_pcm_free_modules() to fix the
> compling warning:

Applied, thanks.

--bepXcx/bRK16yA0/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZy6oAAoJECTWi3JdVIfQw14H/RWSJrnuvB63DOTsaisYm2ft
iHurY7gDDHp1X87UL/rqzvCzARxbqCISOY09ClcW5n2ujtdk5Ta5dI8y9ABvf0iB
b6F5yeDsQ1ztTgYgLq59hHk+ur37VcSnpCYhYx/bPRIjutGXxPTxz3SJzjD2Mnvn
Zv1hzr26EjpVy5bdfuI5zI3Z5BVM3MCYYJ8Al79UTVyEXQ0gAbw47Tx4p1z2ObHr
K37dOI1I1UikEnuBLKn3T7OOQEMdw6/LEzwLf6MbTgrMCDF8zE+mA9SCoAM9TpLd
wtP0xIWgtrmsEzrbwWRbkNrh6piyMhUgmnrKNz4V46bwXKaF1g3PF0Pl7OfR5Gk=
=8lYr
-----END PGP SIGNATURE-----

--bepXcx/bRK16yA0/--

--===============2254761141563963571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2254761141563963571==--
