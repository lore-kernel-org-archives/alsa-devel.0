From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/4] ASoC: simple-card: dynamically allocate the DAI
 link and properties
Date: Mon, 17 Mar 2014 16:24:43 +0000
Message-ID: <20140317162443.GP11706@sirena.org.uk>
References: <cover.1394883134.git.moinejf@free.fr>
 <1cf50fea2306bcb05987533042dbf1495b2c6f07.1394883134.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YyxzkC/DtE3JUx8+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1cf50fea2306bcb05987533042dbf1495b2c6f07.1394883134.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--YyxzkC/DtE3JUx8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 15, 2014 at 12:09:39PM +0100, Jean-Francois Moine wrote:
> The DAI link array and the properties (fmt, sysclk slots) are
> hard-coded for a single CPU / CODEC link.

Applied, thanks.

--YyxzkC/DtE3JUx8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyHIAAoJELSic+t+oim9u9IP/jza/XEvg9qVx7LtJE7B2B8j
r2IDAzp4Wxw3xwAe2NyOGyiFUpOnBw0C3nrndvWWk4Lk6ju42jcSjLeQLo8/5qSO
DF4/NfnAtDxQeGClHeqqVVNAbb9hHRsFfo5yQ5cSJb/efW3LPY3C5T7FiBFkAqbi
j+99rGPXtxKZlWG1ci6e7dvH3gIfIzlBS3rM8vh+o6fKOVdu1XUWdt441Tw6F9hu
HwjZjxtNaryY5D4Qp1XUbZ1ZYy+ETz8wpS/uRzmDr9S+FaVS8FquLBmsiu96bVe+
EKzgVgEoaFzfYUJ5XkmpzSDMfrTx6Rj7HrJvvZvyZ9xM/QQWO4asRy9OhpkVMP+O
8iJsVbhlGzAVrCVgNIOQp0Y/EXmghOIU47emGTO9dz/rAxN05+744LTt7jt2P1eb
YDIi4RJ/0uBt0gPhQ19BhhKbxdeKdbHY+scexuU31PFb3w9erdzEpNw0oAZPo8fS
25jRlX9rAzLvo3oW7h7ZfxaMKxPdHwTFj3qkv46re1k++0skV2mFpPc/pa8jbD0O
f8huo9FjVpOP0qhxGVnXWc81YgjMI5rPQxKEeXnCJim+m1W086z9TBi4zovyMhDR
Sm2FzRf+vYnqPHOwTN+ifJ+HTyNH399/fN3kFTsl4etGKozz6qzefVgx6vT1hzrM
5fI0V0fZiCisQdmpQnvg
=7obH
-----END PGP SIGNATURE-----

--YyxzkC/DtE3JUx8+--
