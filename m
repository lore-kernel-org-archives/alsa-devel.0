From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 5/5] ASoC: pcm: Add soc_dai_hw_params
	helper
Date: Wed, 16 Jul 2014 23:08:33 +0100
Message-ID: <20140716220832.GK17528@sirena.org.uk>
References: <1404854378-25828-1-git-send-email-bcousson@baylibre.com>
 <1404854378-25828-6-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3906043640666617621=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DED9265502
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 00:08:44 +0200 (CEST)
In-Reply-To: <1404854378-25828-6-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3906043640666617621==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XSfi1pJWPNAvuBPy"
Content-Disposition: inline


--XSfi1pJWPNAvuBPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2014 at 11:19:38PM +0200, Benoit Cousson wrote:
> Add a function helper to factorize the hw_params code.
>=20
> Suggested by Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.

--XSfi1pJWPNAvuBPy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxvfdAAoJELSic+t+oim9BTQQAIWflkDKzZOQ4z18fFuQIUkr
9lzyPUvO9Fyvagu64FsEpXud28Z2DYYmoQ1NbQ/ePuhbb4nE95/njoUTjD8x4Tb2
0KPr6fm81tJ76eV4mCppVQlhTVvnZrM2yvZBe++wFUTdRHZO4jaevbYcoCYE/MSj
oqrhwUi+uLKVlS4NWNUNFVNjAdfYMiKsc6+IS/IRLt8/hQyfJC/MUDO6VGdWleBw
yCfXHn5LZ/ffhRWWvVtQojSu5/p0fiZ7mZSpp4kCXkFntTp+R/DXvlE2a2VRV5YU
V7mClZNnZWOqDvyzBYhjHe3+C5FKFN7EnKOyg3jO6hh/lfrpQzErbKlKgwEoN3sR
qnaQHparVHfNaEgwK/3A8Ca61XMoXSiYE2potEiEyXz1c8pISeErFopdfqxvzGLA
LAOqCqNFDTHU/3o2iXRa73uVZWwP5Kwep3AR4YCbU28X8w1wu7ejvEGNK10vjruG
T+yoh4EgcIYPI84Fl16Js3rDGF8/HE2+Q9TrS6BMFnyxC+kJznNnXRElgQbpFo++
wGOCYzLyBHZAmUoNbSFpfj1cO6wKfEyNqf2STkxmqv5WaX51txsFSTWCfZ31HVkt
LXnjztBmh5toM+fTvTnj4Tw2M+TnUU+GkwS69NL6uBbwrfCxdHVtmFAw3mbLcZCN
pm7m0tIdSNSytlgdE49S
=vlx9
-----END PGP SIGNATURE-----

--XSfi1pJWPNAvuBPy--

--===============3906043640666617621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3906043640666617621==--
