From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: Add support for Conexant
	CX2072X CODEC
Date: Thu, 2 May 2019 11:26:59 +0900
Message-ID: <20190502022659.GR14916@sirena.org.uk>
References: <20190428072550.31087-1-tiwai@suse.de>
 <20190428072550.31087-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1504920989372867966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 619F7F896AA
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:27:08 +0200 (CEST)
In-Reply-To: <20190428072550.31087-2-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1504920989372867966==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zj18g9eElA7rRQh+"
Content-Disposition: inline


--zj18g9eElA7rRQh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2019 at 09:25:49AM +0200, Takashi Iwai wrote:
> From: Simon Ho <simon.ho@conexant.com>
>=20
> Initial commit of the Conexant CX2072X CODEC driver. Some features are
> not present.

It looks like this raced with me reviewing the earlier version and my
comments against v1 still apply here?

--zj18g9eElA7rRQh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKVXIACgkQJNaLcl1U
h9CQvgf/eEA8Rqg+J/hXBuY5uGTB2ZqsRYWjWnpgfP2g8PeT+NDWHlw6rVt7Yzua
hRiZqVeD4qz93rQyE6iMz9KhcwkGQl+Fy4+9z9lCvTWzFAZvTYrot2CNd6IlgQBH
e3Z9TytqEXc8bW34FHmiGiuIjPRxOXiU8bN2GtNkc7LyzBqOewlXzhqONBc2A9vX
Xo33jz+4Q+NQ1zIVvuLgxAGIoFiw5inHqkcPV3YdIK3pU/ujGCY9p5o7DLsk/bND
z+JJJQecf/ltwkMSp+Ad3ZtgSdQkG8Jea24dwl9K36R+NG73wEz4qFF1yl+h+6CL
c67L1xSoWvwwTI/4Q8L2pWf41dVrvw==
=PDS8
-----END PGP SIGNATURE-----

--zj18g9eElA7rRQh+--

--===============1504920989372867966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1504920989372867966==--
