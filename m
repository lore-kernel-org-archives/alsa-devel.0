From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: atmel-soc: make it buildable on other architectures
Date: Mon, 24 Dec 2012 15:49:22 +0000
Message-ID: <20121224154922.GI30837@opensource.wolfsonmicro.com>
References: <1354973002-13588-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354973002-13588-1-git-send-email-manabian@gmail.com>
Sender: linux-sound-owner@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: voice.shen@atmel.com, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2012 at 02:23:22PM +0100, Joachim Eastwood wrote:
> Not very useful on non AT91/AVR32 platforms but it provides
> more build coverage and prepares for ARM multiplatform.

Applied, thanks.  Would be nice if this had a different subject line to
the previous commit...

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2Hl7AAoJELSic+t+oim9P4oP/1PqtnWSjxTERNQQcLeN/BNk
127nP0SyR+YDR6UY+ipXPvQDghvCSbY9NsTDewDXL1aFDNcBOkdItjjJvwMGFoa2
X/PojDDTvFnfoOcVQREu9CTo7AO/kCgihzve0WOhE3AahmmEAzSKQcq6sgn0TYFD
q4PUlbcznpNPvNmFSZ0MhW6s0+/faMYT5i89Zc+ANPpjJk/vPvREWy2aMXPH2jQ1
nWQ5JjYziSw2+MZ26B2SKVHD5uE4VJrFVEkGe5pDZ9LPJrGGfDy4gfJTTdWQ5pn5
1RG0+JI363YrtfH0VgKJE92YaiKWw9pYSKemCG7070SD4tmBRI6mDYeFs1IYizQC
TFq94W/CcW78J33HtC3f+/8eGHd1iYGeNnYTmGRl6/8N1TZ2lm8roa/fqizvfvur
gyl3pC/WZ7xYELeht8IwfBmZiZE1nKnBu+CPHpg7Lz1HJqeOqn9Q+c4OA/ewujrz
4W8Vxd80NtZ53sw634WNIYC3QKKqC33e/OZaZ31L+z6uSo7P6FgXao7mi1v+5p5P
re0dHfIUBU4YsBs+M3Y7E1GLW2qY8wv43lFiPd0VEX9nRHGSlarGx2rPX8iIhJa4
l++1FtQy51S5oYayao1EjxG1U2+uFUdLyK5/+bLOUbbwo2qhf20jCfk6ITo3H/O1
FIs0+ImZ1Vofw1u8tCnU
=oIcq
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
