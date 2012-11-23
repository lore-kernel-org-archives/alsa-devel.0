From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: atmel-pcm: add dma support
Date: Fri, 23 Nov 2012 23:27:48 +0900
Message-ID: <20121123142747.GP4529@opensource.wolfsonmicro.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
 <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fqIB0bRxfTYxTb/F"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--fqIB0bRxfTYxTb/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 02:14:17PM +0800, Bo Shen wrote:
> Add dmaengine specific routines and replace PDC ones in
> pcm_ops if appropriate.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> [voice.shen@atmel.com: adapt to soc dmaengine framework]
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Why is this not just two separate drivers?

--fqIB0bRxfTYxTb/F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr4fNAAoJELSic+t+oim9/cIP/19P545nZNKhPdg3r0rU/Yvs
zqiT0Q7BDpabIb7B0oohvUox4KUIkZvvt/umqayp0dwaS2EBNB334Iq6X4VggaY3
dQi4UBdHC0MZorkKzG17GeLI+W4noS0H0f/WsfGlYvlLEZPOOENd/sr6nMF0L7FJ
UetEmMf3rgMNWt5kI4T8PqCPvr3EtQC3DqCNQ4fCl7LwngBK+MrfvBLR5O3LkfVf
vLmGUWEi89I+B/qoMfKRK/BMzXpOP/vmDcL1gm6s9v5zl7mk+3y42YeeOorexZmS
9s162/wQhakMfVa4Dv2SGd/05B+3Puapn0boDthWOZh2X4fBnK+kUb96zIPwyn5w
Zn/l0BEYCkGtDgvkBYbEfVGDDNahXJVOfgnXcx21vrXIDHLSNgKAe8xOQGI3NXg1
f6xMUBf8/MEFn5Q+94RDifnORNzGugBygO+gmYoiAzfZk/lZ7hG9Ec+XjOyXlAmq
TT8BSC/0lrvpaPB/6yXmZ/V47sDtPq7loS/2/O9Qg846Tg/oGdhrRueZn0He2SBW
SdvkChKfgu5X2ac+umrJWEG36hyVNHKXXz5+bv541CHREd/0pEZNTNG6ohZ/HiQN
lHeBaYZIC5F9Snytt4NJPRJ5dHIF1Jp/bXp3Le3TvT5MdQDYroixOjIjn/Y4w76J
yqHAm+0zcinh1Nszcf5C
=TedW
-----END PGP SIGNATURE-----

--fqIB0bRxfTYxTb/F--
