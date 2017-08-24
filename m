From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/10] ASoC: s3c24xx_uda134x: Remove unnecessary
 function call
Date: Thu, 24 Aug 2017 11:39:20 +0100
Message-ID: <20170824103920.qdmd4veys54hm5rj@sirena.org.uk>
References: <cover.1503484313.git.dolinux.peng@gmail.com>
 <0d466d509dc0490f82caf5f61de422ad03a95870.1503484313.git.dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wcfgmgkxpyih3rdy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0d466d509dc0490f82caf5f61de422ad03a95870.1503484313.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--wcfgmgkxpyih3rdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2017 at 05:17:41AM -0700, Peng Donglin wrote:
> The work of the function platform_set_drvdata is done by
> devm_snd_soc_register_card.

This doens't apply against current code, please check and resend.

--wcfgmgkxpyih3rdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmerNcACgkQJNaLcl1U
h9D69gf/eCEiViy2sU/4WEjrr5y5Dd/O0/UqgSx9HcpVPKUqsKv07SCb8Nric40L
bUendLQDCSYqzObOtll83fk/7Lxx5+8Mb86MMhGVWEw1TyEROY3/l2u/ZlE9rstL
48KbOR6gPrHThCJKfl5QnyBHAPT0xr3aOhnuinQEXdfFmvNFGQG+EgszxinJkAuz
8laFHXRwSgWO9QV7Gg71tMN/ZRYt5x8qaQnh3S8fSnYDZNfEzwGFd5abViD/AJOG
IHLKx0z89tgkQUuj/5t48z1uH0BjuOFee3uuXJMKM3QPReOglqnyMIZX//YkcjuR
nRuc6b4zKtC4JGBBtdyjc1HKhHm8Kg==
=7h69
-----END PGP SIGNATURE-----

--wcfgmgkxpyih3rdy--
