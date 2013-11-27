From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/18] ASoC:: wm8741: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:15:17 +0000
Message-ID: <20131127181517.GW14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-9-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8388489966933630095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 80C18264FBB
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:15:19 +0100 (CET)
In-Reply-To: <1385044736-14911-9-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8388489966933630095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zOAt2Xc0AZny4u/m"
Content-Disposition: inline


--zOAt2Xc0AZny4u/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:45PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--zOAt2Xc0AZny4u/m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljayAAoJELSic+t+oim9C7wP/0nhYoWvU9ERG0lcEqJRSuMM
LVuYAQFgjs4jaNtjzBUx5FoLiEYXgAUTgeynRB83z4pEfcThmbFEwG7cdSH553iG
jNfBHH0ayBm5HhH+1A64J5g81gYSnkHIpRDtwUtmfIWEENGds7V9Y3OsT2hTU0SM
ENIynImha/ppLbrgqNWVGeID0fU4KTD4xPndfi3xfMexsAiCsv/XSZ2MMeqyqGJZ
2bNlsH/64DU7SmH2dVILM74yHjHxvnNUjpzX5znzsiKiU0C4z5x/p3YjXH36kqU3
ofCersffEO5o045mjDNsDBba6D1Fm8PnZkZcfbgqwGtUug8agLpq+KYGZZN9E50m
lOCztmXNrmqYSyp2D3kjzTO+brbf6uAiAT5bbr+0i6dzzaPEm1ayonkmhvuurPH7
MdDf4jpD2iOc/sTv11TgREOw2KgglkEyCKGPobIBRMhzJWSJOa334guBoNEJ9u4Q
r9J/hAOI0CJXQUzTTalUYCQ5GHne8QroACTmkl8h4lTOjbIVpLbHQ1JBQn1XGkry
gM2u8f6YYHvK8FncqvMpOR1qCm3Q0JXhV8H7xfkuYWPi4qh8aIa42zo5dZEyetaB
+uf7N/BMjfeBYTBLz5HvLUYo28+sjbmP0q1le7FKT04jC6ZpBexAG7gHCniDC7X+
d888u5fRafsopMYQfbt6
=+aGF
-----END PGP SIGNATURE-----

--zOAt2Xc0AZny4u/m--

--===============8388489966933630095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8388489966933630095==--
