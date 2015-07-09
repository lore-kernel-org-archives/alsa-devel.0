From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFT PATCH 1/2] ASoC: zx: i2s: Fix devm_ioremap_resource return
 value check
Date: Thu, 9 Jul 2015 16:33:29 +0100
Message-ID: <20150709153329.GM11162@sirena.org.uk>
References: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IAaqE72949kW9Y9K"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jun Nie <jun.nie@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--IAaqE72949kW9Y9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 10:19:28PM +0900, Krzysztof Kozlowski wrote:

> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> Cc: <stable@vger.kernel.org>

Why are you adding a Cc to stable?  The zx driver was added in the merge
window...

--IAaqE72949kW9Y9K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnpRIAAoJECTWi3JdVIfQdNMH/1pKphjOzN4AZZI+DTOULFDH
v64RdneyQWy1UUWMN/BQYZTG3nmztz8F7On66IwsXe9MpPZx+tvcX4hWJ0vZxSWU
z50Hlvyz1vN/NDNZZ5CzlgoF8doWsep3wRZ1Unn031AkpV1/4T4KdHP26eAbyrIH
zbmyWK/9Y1eVuhY8sEzhv37sN27wgRakAmNMQBnL0mfGS/c2IQ+vvS3lQRZQ9JXZ
g7YgATGnTFADD9CgwXqp5vEq75UYW+KNTTTwcgq3kpSn2ZfcwxMfP+yEzw3IJXxp
uqXLPK7BSEhyRwT1GM/FwpdU0N93+hWJ+NiSjdUDB1LaU4TXIv5qjQJLZMdSk+w=
=CzAT
-----END PGP SIGNATURE-----

--IAaqE72949kW9Y9K--
