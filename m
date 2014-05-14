From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: ak4642: Add driver data and
 driver private struct
Date: Wed, 14 May 2014 12:33:11 +0100
Message-ID: <20140514113311.GU12304@sirena.org.uk>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
 <1400053058-1115-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0034097498060307154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CBDEE265457
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 13:33:22 +0200 (CEST)
In-Reply-To: <1400053058-1115-4-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0034097498060307154==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XoO5jQFkz/fkcUT5"
Content-Disposition: inline


--XoO5jQFkz/fkcUT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 14, 2014 at 09:37:35AM +0200, Sascha Hauer wrote:
> Currently unused, this is done to let the driver distinguish between
> the different supported codec types in later patches.

Applied, thanks.

--XoO5jQFkz/fkcUT5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc1R0AAoJELSic+t+oim9Jv8P/1c8aCwlos46n3E/S4AZVPVT
alHLmtorW7f+Fks/0jTqMmfl80W17kWRbvFifYaJn49mvDTUoOtQnGmi244FOHSN
ixnXpmjXf74SVHTFHNILWWhqUIC+v6uLs3mvFY/Nm2qqpuC1R9PiehAkAkXTcosE
KpO/ekT56am+JBShaaxSRlC7MELEjamWaNkxaheS+CITPFdqlpEb0lyM2OAgAmsP
8o+NbzJ0L7rxux1wK+aRyq9OKFvkuqQdeb65P6MxI7Yr/Uy1BtwiUsSuCnve3Swp
hhcNcMAALxSCa3bihkQsjBwF9ulHqI0uUW8j4G0VzxoICGYXcmDq/+R10twkbd/3
X20FfytPG+IEjwnH5kEVwwuXxjtHrdNj+xNCSCHKABMX+LNwMZKNQ5fdSCdni79C
gfHcB+XpRHka0j+nGrNf6NxA+PkQAeoQGWHn0DR2O1Ffrja2m+urXwG+CREZq7iO
AvEZzKi9ELn2lMQgejGVZGHRFMN7KJKg6hpJ0gITXU0HPWixen4AopjyqDuDeJSK
INhCyGn2Bo2/SafAudIdSdTeGhTrYEtqwDpzxUdmqtaoUkX7OYUt+tST0R2We05T
WCYYIdp9P/CcnC3gz6+EzCF3zmQOPla2ziO+Ss3qnwwUmoPM3IZg67cQZJgeCms3
98MOb+zJPepiN8CjQFgx
=Yn3e
-----END PGP SIGNATURE-----

--XoO5jQFkz/fkcUT5--

--===============0034097498060307154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0034097498060307154==--
