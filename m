From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: constify snd_soc_ops structures
Date: Tue, 25 Oct 2016 15:08:52 +0100
Message-ID: <20161025140852.GV17252@sirena.org.uk>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
 <1476543351-17858-6-git-send-email-Julia.Lawall@lip6.fr>
 <20161024173423.GL17252@sirena.org.uk>
 <alpine.DEB.2.20.1610250754220.2084@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vBRosIkLXbYTRpGW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610250754220.2084@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vBRosIkLXbYTRpGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 25, 2016 at 07:55:00AM +0200, Julia Lawall wrote:
> On Mon, 24 Oct 2016, Mark Brown wrote:

> > You split out a few drivers as separate patches but not these ones -
> > what's special about these ones?

> If it's preferred, I could send them all one file at a time, or when the
> maintainers are very similar just send one patch to all the maintainers.

For something like this it doesn't matter so much, it was mainly just
the consistency that was bothering me.

--vBRosIkLXbYTRpGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYD2dyAAoJECTWi3JdVIfQyFQH/2reJtBjxKHyZw1cpy3P+eBZ
cpyfQwjv9rAgx9kygQH9AKylMKBjsIm7Ovfl9sudsA7UMTQyh16MtTgjMKSGI370
9ki58iFkg8L0BlZKilOUS7db2wkWiT31lyxetncrmeiePRmNh+NDHuo4ySuLxrYE
CsPjQXak1lBGOWb1icxJnRrP7OZjIkNLPxGI+o5oXDQTGJHU7Fbub9Xn7+5BmmrU
O9VhzqRldxH/YEGp+P2e8O5iUm2L+ZHNYWsEkcvQyXZR9eKtQfX6U+upoWJD2zvk
ZmOKLGwB68vc06E3nYjYX++FlPl3VoWuVAoFNLtZDXc1s9DbuBQ+9Td/SfEE5DU=
=xw73
-----END PGP SIGNATURE-----

--vBRosIkLXbYTRpGW--
