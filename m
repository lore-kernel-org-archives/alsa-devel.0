From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ttc_dkb: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 19:13:48 +0100
Message-ID: <20130702181348.GV27646@sirena.org.uk>
References: <CAPgLHd_CJUYf8Ry=J9Y8ZPSrCgqPLTj74rDr__bxoymQ8GR_1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xfLSUI6RYrtWMjtK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd_CJUYf8Ry=J9Y8ZPSrCgqPLTj74rDr__bxoymQ8GR_1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xfLSUI6RYrtWMjtK
Content-Type: text/plain; charset=us-ascii
Content-Description: s
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:26:40PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add missing .owner of struct snd_soc_card. This prevents the
> module from being removed from underneath its users.

Applied, thanks.

--xfLSUI6RYrtWMjtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0xhZAAoJELSic+t+oim934EP/0gqEBh7DbsLG5Sk0lJCw5WG
MvCs7q1cHOS2kFUioQIU5ojBLA1AedsuMVHCfMQzUwTssiiuLTDjoBxUAFlrZCFt
OkU61b4ZMgoscSOqHqA1eqCX1HUPQ0m4qGAQjBLIlMQ99ugH++8EtCriNXuBf6Y/
GI/l9APoXVcUhczwDbs0Zj9tVO00yMp90AOW4tk/mxXLjeB4HXYI/bvMBuOGY1gD
vfwKoMo96qu0oPZtQZ+K8KW1YhjxdwRVtVGYgN9T5fUst738eFJXM3Cq2r7vNjvj
ueFTYM8BjxAUtNJcwfC79GZJJH9vCiMBHOoGnM5IG3LDhwigjxp3FgwtcB6lmFS5
9NiWLPOu5tK6Ls0ehDUEIKQ2VhNbZ3C5jYW10XBRo2cOsZ/sY4ILeRVsU8/+xyQy
rm+FYWPfkyHjSoMXzGVFunnURoyvTPfnSXODbW5c75Ej/PdvjxP7Xbrmc6P8APbP
EfcpczgrUXMoxQwDLKUYKhpfGMmMXxVUeazxnQM7Q8tWQk2cS8vSFFy1jYECm4bp
SlbSRuImIkcXBS1St3Dp5vt8bxGsC4dfr4MnmN9dw7NV03WobBglhdMo5SsTOpcV
Ouwb72JEgL1fLBwY7mn7phQuyF2Nnb5bGUyisNj1LL+YbXXCVXn9yOyuIG/kgnY7
QVUKjZ24wV0MEcl2mKoz
=F8C9
-----END PGP SIGNATURE-----

--xfLSUI6RYrtWMjtK--
