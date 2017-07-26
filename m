From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: samsung: s3c2412: Handle return value of
 clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 17:07:00 +0100
Message-ID: <20170726160700.tffy72uwhw4hilhw@sirena.org.uk>
References: <1500977674-27960-2-git-send-email-arvind.yadav.cs@gmail.com>
 <E1daN7g-0003Ze-AF@debutante>
 <20170726154642.GB2577@kozik-book>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jjzasr4756g3afou"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726154642.GB2577@kozik-book>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, perex@perex.cz, tiwai@suse.com, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jjzasr4756g3afou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2017 at 05:46:42PM +0200, Krzysztof Kozlowski wrote:

> Mark, this is the patch still discussed. It does not handle the error
> correctly. I think it should be dropped.

Ugh, is that the same patch?  Sorry, got lost in the big series.  Now
I've applied it I'd rather do incremental updates to it if possible but
let's see if that can be done promptly...

--jjzasr4756g3afou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4viMACgkQJNaLcl1U
h9BISgf+OcMuuGdqCAvMKuMdGf0Sl2Z8Wt4Ws6noW6eZqXV6rBckAMz/3gUtpksS
e47wN4hWWPsdHrRz5JKojxkWk/Zof4YhyXIEsUSntUMPE/xkmq42fWs02acI3uUs
MmUSWDNpZZyEuleMqbKQnTNrcjQd/Ji3NZRPGUnW2Vef3dIbYYo90boBL2NOl+TV
A+DY7nzDPT2O16JaNS4BVZ9M/Y+4a0HNBK7td9UlEnV+DAqPOgIT82BAhIYBo/wf
ExSoWfFnfy/1hSFn/zNCexQZyn/iVAo5Pre8cOEa+bUsds1KplAJmkD60Mck0bAS
6cgrxyAsYX4hXNQ/dOzYLmLPPTxvEQ==
=jOIR
-----END PGP SIGNATURE-----

--jjzasr4756g3afou--
