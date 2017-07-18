From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] Revert "ASoC: ux500: drop platform DAI assignments"
Date: Tue, 18 Jul 2017 11:06:55 +0100
Message-ID: <20170718100655.topzzdu6n7rd6euk@sirena.org.uk>
References: <20170712155530.17765-1-johan@kernel.org>
 <20170712155530.17765-2-johan@kernel.org>
 <20170717145127.ke5o65as35itamaf@sirena.org.uk>
 <20170718082118.GG29638@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yk27v4klxgzyhn7w"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718082118.GG29638@localhost>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--yk27v4klxgzyhn7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2017 at 10:21:18AM +0200, Johan Hovold wrote:
> On Mon, Jul 17, 2017 at 03:51:27PM +0100, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem.  This makes it easier for people to identify relevant
> > patches.  Look at what existing commits in the area you're changing are
> > doing and make sure your subject lines visually resemble what they're
> > doing.

> I try to, but reverts are special as the default commit summary tend to
> already contain the subsystem prefix and some maintainers find that
> sufficient (or even preferred as this also makes reverts stand out more
> clearly).

Reverts shouldn't be special - they're just regular patches and should
have sensible changelogs like any others.

--yk27v4klxgzyhn7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllt3b4ACgkQJNaLcl1U
h9ADDgf6Amne17RpkU+5X7bYKTPymcRKWozbxORJ8zJDTH1VnEVA5Q9dn1QdnNBy
i98sNuT2l2yRzf39HiBrpTqaWOQhaBLT9c8h0T/SqG/iSk1lACmIHcBq6ruPeFql
6vDVT+lzj8KCX55ZAgPoYv32JnLfpnKiQp2x+vq+fBp/YpuTksWV3QTT6MkGQEFB
Fv1tjTvNL1PNJv2r3/M6p9U5OTV2wU9Ovn8kZ47C2hNweNG83dSJxuoObY/btweY
1mXWGpU+fMmlGw9KTH1OTzNsDZTNFaIUaK95yW2YVfE0PEF6ogfdVR6eA2tv8v91
IgbKs9/dYbQcjAZc5s3qTJl7cyJ6KQ==
=QWHk
-----END PGP SIGNATURE-----

--yk27v4klxgzyhn7w--
