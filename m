From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove unused variable
	'min'
Date: Thu, 26 Apr 2012 10:29:24 +0100
Message-ID: <20120426092924.GD3207@opensource.wolfsonmicro.com>
References: <1335415919-28526-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8201359513893853715=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50F8F10BA01
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 11:29:26 +0200 (CEST)
In-Reply-To: <1335415919-28526-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8201359513893853715==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2012 at 01:51:59AM -0300, Fabio Estevam wrote:
> commit 4183eed2 (ASoC: core: Add signed multi register control) introduced
> the variable 'min',but it is not used.

Applied, thanks.

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmRVjAAoJEBus8iNuMP3dVhEP/39h3kvWp5XoDfPgaIOVtxck
7Ct08UAIcGqU+is6Qak34DrzCDbnOaFPeRVPpqOGywyVg4wCKYsJ0qdGQM5jWEUN
LeRWGzPmBhE63F5IOZpUsCV+YFaLpSCMQuFA87MmXOhAcDSk9DEltPknD+ivXtO6
TM2NVQeWv3qARhC5RTpTlElP022aXDJqgqu+YqJ3e5BOZVoHL9m6RTMKlcajl3tl
kAM8IjgD7TCeieDks43Oa6p9fNgfKesDJLo18ufNPh4Sr1ConlISYhQIRw/Rf5rL
uTlUIz1j1YYbFb/0Rqbps43kADv8sMTi/iYw4PdeMeC+dcpEmBH+HjFKqblw3oHJ
2XdpabNHT0Ucas8ZUKriAIDBwRqXWyLTymls7+pK6e+cWEu1eXxHEsnVpsDsiCjg
SlCx7ks8pgXLFx0CmJGgbyC+lMCMx98BtMhxh49xyOu20QWqBplwFpMKF1e5xNfp
2Cz+JXQmWnH4iROiRNj0pFppR/UIoaVz3yoDyGoD3NztyTOKRKQzfGaPzynJ98yh
LVMmRX34zvblz8z3m0vMR84+AytDYiIVdMH2De8UfbNEJnsAbGelfvSVDsPNGIhV
ky+EGnuOeQaEH4Ux6F5nU9vllQKxahw6UkCfrhRrShthoP+F0NQ+uZG5wkxIW3Ve
H6dGn1fIeMwXZXO+HhCO
=crur
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--

--===============8201359513893853715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8201359513893853715==--
