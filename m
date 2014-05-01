From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/15] ASoC: Atmel WM8904 codec support needs I2C
Date: Thu, 1 May 2014 12:09:53 -0700
Message-ID: <20140501190953.GA3245@sirena.org.uk>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-13-git-send-email-kaixu.xia@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FerRj+SnsihDQL+M"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398770316-19715-13-git-send-email-kaixu.xia@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Xia Kaixu <kaixu.xia@linaro.org>
Cc: linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd@arndb.de, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--FerRj+SnsihDQL+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2014 at 07:18:33PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The WM8904 codec driver needs I2C to be enabled, so the
> SND_ATMEL_SOC_WM8904 option also requires this.

Applied, thanks.

--FerRj+SnsihDQL+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYpv5AAoJELSic+t+oim9NUgP/iEggjNo2fHtTV4n2nJBMw/F
KjwiW9DpLsG3IbAzNRi880Q0ikRavFgVy1/F/JQ/I99BTvJjsN2WDxV6rCDeA08G
JnWIxewT5cmN/STwdT7M12wOgdOOXhBHM5n8/gmsPxlQnuZjLfyoKUJFGLD4KHyi
thWCTNZiCHjuqv0Q+nK2LxqrrkzObTYfENwKfH6bUZky2E2AguqBpaJk2VuwOavT
RKHR/p4jSDoIMudaZPrDTqNBHvK4nju/NmieaRrRv6ufOD5SVuT2JpGjGEodm3/q
UyMhSVmlmG2J16DQ9trn0KRB87bZkrAdFgf51CoYAscNMrgNwIAWr7oHnc8GAwPv
aoAgWfjElhJwSWBW3lKSla90C3TR8ePq8pdQfIXrQxkoSam5G/BGaMZLyrofyntt
G6ksrfTaFLUW8cF4+u454jGobMhbSET2EFWwolSo9vGRcbu6d7qYH+8qKbA3yDaj
fjAAKxxMdwmlRfLhREOqGslCTz/Og6VcPfGCqo8rrmtYQg5y9wuG7FS/uBmWW0o2
45YCAKfdIUB6IMQi+YNgc1cvLyseZ8dXwYEehn8YMYOeFfpcqzW9BbtJ6x4wshCd
xMI4xRTifmov6abeoxbDAkXQYa8stf9xNqeI0N2zfexnqiI1J9KZzTR05GZZlOe5
o20hdt6DMDr+t7coTN/K
=FCj3
-----END PGP SIGNATURE-----

--FerRj+SnsihDQL+M--
