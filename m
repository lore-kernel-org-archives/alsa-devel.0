From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: fixup rsnd_platform_call()
	return value
Date: Fri, 11 Oct 2013 19:52:53 +0100
Message-ID: <20131011185253.GF2443@sirena.org.uk>
References: <874n8o1e2x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3635156030776420799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 984C4261A40
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 20:53:19 +0200 (CEST)
In-Reply-To: <874n8o1e2x.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3635156030776420799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 12:06:34AM -0700, Kuninori Morimoto wrote:
> Un-implemented platform callback is not error.

Applied, thanks.

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSWEkCAAoJELSic+t+oim9gA8P/iPmsuBBy/QJltyW2g9i2F3V
vVr6N7rAKB8HcvXvlmSUuigggRbfX0GRgHcqYVNWWpw3pnTwZXsfbdE9/YLO8zRx
NtbgETIEBf6ZhHbEo84HRkg7HqhHkQp1OkyQm7e1szPDuotJxHq1MJwD2COQcICR
/a5cG1fYS45uvRwYpVDgcl/XQV6zOtubENXywe8Yx49KHVenYOiIbS6Sz3nqUti1
Iqap6Is76JyBdE4+CWqcR6J2EC//soJCu7T+4dEU3ETVNA+TMG6CNa/iFPOVm41R
kwWh6vg+GSGH7vcDJVlFQG3G3zwNp9UvDnDzBfYXT0ZJmFZhGp1QVyAn6wNN+3jU
fEGGPH5FZITo5j9/5TeDIEcmb42RjVrK1mVE/JaxcpANzb0ZUa+Ka5NEYwZCKNSj
FlfOtlBCfwQE624vDIuagFjHicRxQ89YkjwL/xsD039HBNPvP2/fkMFCPIWZEx2o
6UFPRB0DTSc9MU7ZbZpNld9dqRzvt0d6QR8ne/y9SUIJWPgs1NNRYlYWWgAhaaMR
c9eZw7fD4Ey8c6pUaiO6HoNkYyT5uO1KsxGKN1O4+EwS5jmVcUJGWZbi814JIsF9
qNu7NefPtRdsR1uemIQguptS/adUHlZyO9IwW7oLyfaPEhVxnnYcXMPb3G1nX/aA
9UeCIhAD8WCVSCDy/efE
=QA4C
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--

--===============3635156030776420799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3635156030776420799==--
