From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: Remove outdated comment
Date: Wed, 5 Feb 2014 11:31:25 +0000
Message-ID: <20140205113125.GG22609@sirena.org.uk>
References: <1391521702-15594-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2918594034682839656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B99FD262626
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 12:31:35 +0100 (CET)
In-Reply-To: <1391521702-15594-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2918594034682839656==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qgNrgGfFsws9WDdn"
Content-Disposition: inline


--qgNrgGfFsws9WDdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 02:48:22PM +0100, Lars-Peter Clausen wrote:
> Commit 1b1861ead ("ASoC: cs4271: convert to direct regmap API usage") removed
> the bus_type field from the cs4271_private struct, but left the comment that
> described the field in there. This patch removes the comment.

Applied, thanks.

--qgNrgGfFsws9WDdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8iEJAAoJELSic+t+oim9s2oQAIgfr+SYMovPW4/tU4psug3L
f3tnlkaMqAh0Q5RETZaDO86CMdIT9s/FPvKvA1QnFpgCGSvtEcOVRy/cN9d2aLAb
b6XVPWuss1N56YYeMmqN6UlxZOlX+yy6/jztjMey46JuyZ9zTMgod9411fceL62f
xr1dycDIY8V1rz986FnCjExIZGbinEa+18+CWgn3Ll/nCAyMypxNGK+i4VWDshcU
gbYaHDQ9Cchxn/BaqdLn91/wzk7KQDIUwLG2iShZLmQQ8rlnq4jKVizR7AJym4TX
Sf+2L0OjCJJnl+frKcNhJnZQsuglYeu/6OmM03SOmE2G4hem1n+z9oBakZfEAWIX
LAJ4DfG4wGuXZPcP/qLfJrvR4L6qu31NYawOYw0O01X8yMGRwVcU8kGJ9CR02Kao
rUk+DKzYH5KoZ51yjhAyVXZMWJP7GSJRMmqzBB6lqTYRf5kP6hnkWxhcFf/Cy+Im
udPQ19wMvz3L6Uc5SYZmeb3ACrLW5Sru4m1IJob9x4YGvASiXAxoFVJBl+U+0CGL
ZVR5s0+mvNsOhv0gWLneldal6kQOu9Pv9xuBCIk569ijBoI64uhbWFYsbnc627rg
PGviQEymNL6rZ49mQEYEjpfyGswgn7yisvoix9mhGQlXafI6SGWIXovo7alVYtEz
N9oiu7rMao+mCXHfhxXX
=3mER
-----END PGP SIGNATURE-----

--qgNrgGfFsws9WDdn--

--===============2918594034682839656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2918594034682839656==--
