From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl4030: Remove suspend/resume soc
 driver operations
Date: Fri, 11 Jan 2013 23:55:41 +0000
Message-ID: <20130111235540.GA7873@opensource.wolfsonmicro.com>
References: <1357920101-15179-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5266201222082076723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAD8A264FF5
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 00:55:43 +0100 (CET)
In-Reply-To: <1357920101-15179-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5266201222082076723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 05:01:41PM +0100, Peter Ujfalusi wrote:
> With idle_bias_off these are no longer needed.

Applied, thanks.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8KZ2AAoJELSic+t+oim9H4IP/RbU2iftFL1L17MfsnQcX51k
iRZvIleTvtmMwFhV2Yzk6AgmvYGK9iV+8CiBL3CnZxY6koWfWaOk4tXn2Ce887g/
6arPmRyV80plbYiUet5+EObAH9ZyIiW23jd/v1Lqv0ToSRn0PdYxht8x5/xTY/6V
8r9dsvalVXH1Vc/w7+Lwnu2GldOTz11o/h719Aw8Ez80/bshMJMOmQ5AhwqDxO5V
tOZB7+e8flH06o4Tfznjdm7vnXy8nWM8vR9sXwtDsF4uO9jiDTVKhkg3h+iTN++P
GI4UBRwaDKsKIZkTKYJOTIBZEf/4LpiRGXM4RONR7qGbc/xlHTC4XwH4c3TFN9XQ
no4DV9E/msG3Hd1reQtypW5oNzpoiwHtZ2+22QwnEh9iOaHqbwe7Ininlhs79eGu
+Z7btuuyMbstfarR/cUi5l+CcbtIdXI8qajqjc0/Km4jZC0OFI7hLhXD1GdtDAOy
8NBo0ssc16y+v79S1TuLhGqyNyM/g0mJUxPieb4BrHWWsmPu9yokzeotXbOlAGPt
VnaqI/a4Yv+7q4Svt3G8lfWaUzq9GF1dIjJR80fB7ny0KM+qrjuNOoRhumoy2jv2
iGZtl8GMMGDTB+nMUzIVm0+7LCLhRRIx3eZ/rgSxbUjkE+EXxicca40ZArQ80vSu
0uBM4hS1+NNdKHEFqr+z
=y/7k
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--===============5266201222082076723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5266201222082076723==--
