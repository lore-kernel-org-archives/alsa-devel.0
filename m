From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] ASoC: es8328-i2c: Add compatible for ES8388
Date: Tue, 24 Jan 2017 12:12:22 +0000
Message-ID: <20170124121222.twygwy2fph3ticfa@sirena.org.uk>
References: <20170124100835.9540-1-romain.perier@collabora.com>
 <20170124100835.9540-2-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fa33xd4kgdi4xzsv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170124100835.9540-2-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--fa33xd4kgdi4xzsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 11:08:32AM +0100, Romain Perier wrote:
> This commit adds a compatible string for everest,es8388. This is
> an audio codec that is compatible with es8328.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--fa33xd4kgdi4xzsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliHRKUACgkQJNaLcl1U
h9BIbwf/ayPr6O5Sp3xnZVKkCx3c2EI/PF/FoM81u3aN0NHm/nhSPbrSWb7WBc7n
J5A4txKgwEJRU1lcYPfoXjn5LUfUePugEsDJSMrBJhpaYwC9hof0AfubhnptMc5X
LN9SL2uQaU0qjA1Wi1LhdMEmw/LJzUWrP2FBmAWXWW/y4lgZRHu3O38pJEZaEPBr
Q1EFcRzy04N+OxsdybuUasC8jQBtKYRLxS/ucuI2NhrzoGkiYGm+QQ8QEmqUd1UL
87S9HljLOiuMeqwUSqBHrCuK5gGFfx8XeDcxr4KyZ5JVJl3MhRuwbJTF1rNIOzYF
Z1OPOpm3+WhbOXIX5XUI8FnMjGvWvQ==
=rXjW
-----END PGP SIGNATURE-----

--fa33xd4kgdi4xzsv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
