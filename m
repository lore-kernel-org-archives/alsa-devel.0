From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8904: fix DSP mode B configuration
Date: Wed, 18 Dec 2013 11:31:00 +0000
Message-ID: <20131218113100.GJ28455@sirena.org.uk>
References: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="56fysGXq5VVjE/ND"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387337183-16814-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--56fysGXq5VVjE/ND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 11:26:23AM +0800, Bo Shen wrote:
> When wm8904 work in DSP mode B, we still need to configure it to
> work in DSP mode. Or else, it will work in Right Justified mode.

Applied, thanks.

--56fysGXq5VVjE/ND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsYdxAAoJELSic+t+oim9BIcP+wbKgeptx7SeE/AxeLaacdNi
+KyQLa2slGXzxs7xNivXXJdHdjjapI4pe6olE+qw/yUvon47+prHKczw7XziF7+X
6jCR28svh4yLZCxM0sd3+jVFtIYJl0IX9wmplbM2FLwn1m0VP05GhusYYpKuZW36
nImGeiVa5WYdIuTvK9fYmyc4v+i/R1oWBkK9Xzi6ubJOIL29scNkS2M+XjLgxb0k
X3Ee/HsU7eV8POHOHJTCe45ttPbMk00KZ2z7LdwwGZ9SOupDcHY4HEwhk0fLGDY2
HCec8zRDRj76FcZLtQIbLdHZzPvFYhYJ4gz+im4VGYh6s/rXwNPH43NFVk/AW66H
xbQuYjX4NDo4In5Nd6gSRSyUgpmPrQhj5uCOQ0YDlCCRsimiDpALxwVw6D6QBJd4
mivwFx2gL/4PW3D5WSxhPqnYdEyRokn91xcZo8M72bYk0dng8l4KX7tVEgF1GtEO
ewwnk36PQvj49J3NmAMN2/J7DDzq4cCOxxbb1LbQwLrZL1PNcdm0hJZhuyMnhtCe
RDvkuDs8yu04syk8t0b5cngIIdpGTJAezk00PohV5pjgCVSim6QzvDRrAa1TujGG
gEpSDmq/uDusv8TSi1apzmTdpvXCaI8484zxkx+Wyu+IGtwWV03VuBQA/yDfN8Ha
G+SIEAx+qlc0g6cyeW2x
=tPYQ
-----END PGP SIGNATURE-----

--56fysGXq5VVjE/ND--
