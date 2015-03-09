From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH_V3] ASoC: jz4740: Add jz4780 support
Date: Mon, 9 Mar 2015 18:10:09 +0000
Message-ID: <20150309181009.GM28806@sirena.org.uk>
References: <1425903068-60790-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TlDjLAx2PuPdVSSH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425903068-60790-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: lgirdwood@gmail.com, lars@metafoo.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--TlDjLAx2PuPdVSSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 12:11:08PM +0000, Zubair Lutfullah Kakakhel wrote:
> The jz4780 and jz4740 have very similar i2s blocks.
>=20
> The slight difference is in Rx/Tx fifos.
> And the bitclocks for input/output are different.

applied, thanks.

--TlDjLAx2PuPdVSSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eIAAAoJECTWi3JdVIfQCpoH/AtIRuFvNn2E5CXyiEfl5dGT
IELpyauwrZWy+0JYcrTON71YxrbMX/Au5BoiiAUHuVmnCZwM7IoYVu7t/KbmKMVk
AeI2iAvfwtqktZzWnk+opwRp8yOhi2I+I4rDtJ4+htjDR377/2G22Iz7OENEvYHn
vXbhrvvg1aOS2GGDUJQkhT4kgEP07vWsEGV9LyvOncBHcAICBiZ6IboM8NyRwwt0
fRgLLsd3PyLtobBo7vohRciC+pa3xOloEUxwyvraanfd7sBYWT339h3LBjJrYDbk
ZR4E7nJc9d5VnKnDc7GtHU9kEwcZ/7sBCAfQqx0DF+TTw1f0/erXOGzik/tlnqU=
=vc2T
-----END PGP SIGNATURE-----

--TlDjLAx2PuPdVSSH--
