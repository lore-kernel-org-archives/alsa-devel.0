From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] mfd: arizona: Integrate wm8997 into
	Arizona mfd
Date: Wed, 12 Jun 2013 18:14:43 +0100
Message-ID: <20130612171443.GR1403@sirena.org.uk>
References: <1371054560-28770-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1371054560-28770-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1059284030831770367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 79589265095
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 19:14:46 +0200 (CEST)
In-Reply-To: <1371054560-28770-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1059284030831770367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dwlrTrmaMopxYcLA"
Content-Disposition: inline


--dwlrTrmaMopxYcLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 05:29:18PM +0100, Charles Keepax wrote:
> The wm8997 is a compact, high-performance audio hub CODEC with SLIMbus
> interfacing, for smartphones, tablets and other portable audio devices
> based on the Arizona platform.
>=20
> This patch integrates the wm8997 into the Arizona mfd.

There should be an update to add the OF device ID to the driver in here.

--dwlrTrmaMopxYcLA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuKyAAAoJELSic+t+oim9rtcP/jhCe6mmPld3sKrPd3TUG5N/
2nR58NBemdTIFxLiD4YPQGu6eommCugxN2Hfu/Dgixz3RL0LsST+S3cna33SeE7n
UYM3Q91HTvj+eqGVPStFw8wrnj+kT5iDZoiC+1aKNOcRESAEKjegv76I8mz2ivdC
FpnSGZcbiLVQeLxsM0ynwlwkpIC9uiPGSO5OjI6EUC6olrI417Zi/DEowe5CfGxH
wPhmS2eCULd+H70tZ00Rv7FBpjwXZrXqz1bO6OahICx2WEMCa5cdhU1azUPUSGr+
tcVYp0Crv49ogecsSFg4armt9/7Dr3n4ULFk8uilKSjUPBm4WyX4nD6oMXKINKA7
UDJqdLHz9qFJ5AZR+nkMM7GjIBliXcOoRL1QgQK7YPfh78RxyzEwaNoYLmOQFeDP
AfjHpJ1UeOtnlCz054kn9IRzrwu12zfn8/6RIsWrn3I97DO8U1JbTYuVAlGpSZQ4
jUzd9jR3HOHo0ilf9+APBXUyoWYhXim81rMcDMFDOPHFWaNwfNJRXXko5hZW2XF9
CS8Q6Kefu3xEBqwyfQIYZBHDL/TfwspvI3+N5GrXswjwfPKeGnc5TR/crpPNCFh7
ce7KTcn2q6OiKwjubyA414ZSTVTlloUOlReOnb7tXaxfQ/VOVF1MTPcU4k7rT7Um
EAQSIHyVGn6fkswOrvcj
=lCSg
-----END PGP SIGNATURE-----

--dwlrTrmaMopxYcLA--

--===============1059284030831770367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1059284030831770367==--
