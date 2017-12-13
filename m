From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: ASoC: rsnd: Add device tree support for
 r8a774[35]
Date: Wed, 13 Dec 2017 12:20:52 +0000
Message-ID: <20171213122052.GG6416@sirena.org.uk>
References: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 06:09:15PM +0000, Biju Das wrote:
> Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
> (r8a774[35]) sound modules are identical to the R-Car Gen2 family.
> No driver change is needed as the fallback compatible string
> "renesas,rcar_sound-gen2" activates the right code in the driver.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxGyMACgkQJNaLcl1U
h9CvIwf5AfEblxZgAIcOpdX4JqZrUTrTEa1j+mwvodabYWZmYuZ0X3iY+yYmqvz2
VNaKMmMk3nKL462fsRZkw9jaTmoxu5QxOKvi1rB2NU2BjFriwGDmtmiXdX+/EoRa
RqKo5XksAce6b/K+HDNgz+4LFooc8AFRxwH9jpx/c7W0dFjWsNzAY309hA/MKugf
nVXSfcg+Ufn4StKmZZPNRNS0sB9VUMb7G847iaaTzdATqV0nmDzBqWydDniBGNuQ
/Jq3QXRZjGWN8UaYcxROXm8XxH2VxNKeyymEsHojqRU9XpT6Si4mSI+1OmRyjHng
htWp2Ro9wcgfHRyLwf4l9wXyBmT40A==
=ZeZ4
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
