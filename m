From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 0/5] ASoC: core: Add support for DAI
 multicodec
Date: Wed, 16 Jul 2014 23:19:04 +0100
Message-ID: <20140716221904.GL17528@sirena.org.uk>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
 <53C659B9.70904@baylibre.com> <53C65D6D.6060400@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2738160797107026991=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF5026535D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 00:19:25 +0200 (CEST)
In-Reply-To: <53C65D6D.6060400@metafoo.de>
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
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============2738160797107026991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TALVG7vV++YnpwZG"
Content-Disposition: inline


--TALVG7vV++YnpwZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2014 at 01:09:33PM +0200, Lars-Peter Clausen wrote:
> On 07/16/2014 12:53 PM, Benoit Cousson wrote:

> >Any comment on that version?

> No comments is probably a good sign in this case. There is just a lot of
> activity on the ALSA mailinglist and lots of patches to review and this is a
> quite invasive patchset so it requires a bit more thorough review. Give it
> maybe two or three weeks. I'm quite confident that this version has a good
> chance of being merged.

Right, if you make multi-hundred line changes to most of the core files
it shouldn't be that surprising if it gets some careful review!  Anyway,
that should be everything merged now - thanks for stepping up and doing
this, it's something people have been looking for for years.

--TALVG7vV++YnpwZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxvpVAAoJELSic+t+oim90mYQAJFnHV6296Z0XVeNpr+rvHai
q8JO/L1ECxJ//bVDls4AFz/5e37Xf9LaHWyB9YYNufyHIfJi7fK3cyIAJT/3yVRL
PVZftnHZoJj6IqiWj4uUWWUFxOnuZVlTw+FY5gAkxGeg/in63/jWJATqXwu2Y1tw
gKsTNDn82w6tY+BI6GNvvZpFIX0YKqbm9TmwcAwk3Q0XT8VBYLUuvtvpRhiFGHGO
x24Gr4ftovqR2ApayyrnPXdRzO+V+uQ7VsVy4+SRewtKp9DBgko6rOKME/8XLd1Y
i0NsxTsUs+kwFRM6vbuxn5KmGUrKpss2FwXMAKEgc2TiWdiFFnW/Hkw0OvWRy98W
rGZh7Kx7nHLJ6IBDOLNYbWq/FSAkYq2ttBwQ+u+t6C6F5Y+WwKT5cCl6Ti8tQ+/c
CIYMpk0cgbtQa0JB04TVaRZcgHpOWLLgRCFdj0Lpc3NsDCZ73jbhXaH75j0B/an9
0gWRecH/V0wH6eDelIMzgBBnsz34fxuOGqKyHx6J5Va8belstkvWt8HSizolP683
ABJtXHIoD7bgdPXis3n6BmiJEpgOfLOx55e2lNwrsqRyG825gcARo2H3Br4BKWH3
94dLKzC5l4qhwuhtLhCfyySxMqDT+Qmrl0qz88coUQPyhLPF682xcoL6H931skym
aSDAS7HBM8a7ek7WuW0s
=VvY1
-----END PGP SIGNATURE-----

--TALVG7vV++YnpwZG--

--===============2738160797107026991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2738160797107026991==--
