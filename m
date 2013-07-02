From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: db1200: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 19:15:10 +0100
Message-ID: <20130702181509.GX27646@sirena.org.uk>
References: <CAPgLHd9kdRD1fJZZWLN+=0ddsb3ZxjovA3OU4Ctrbvj_b3Jw3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B3UyBIKcLn4zZXdv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9kdRD1fJZZWLN+=0ddsb3ZxjovA3OU4Ctrbvj_b3Jw3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, wfp5p@virginia.edu, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--B3UyBIKcLn4zZXdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:19:25PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add missing .owner of struct snd_soc_card. This prevents the
> module from being removed from underneath its users.

Applied, thanks.

--B3UyBIKcLn4zZXdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0xiqAAoJELSic+t+oim9iNMQAJFVNf5ahAWjE9VZb3eBcBmS
OegQLnJUGU3XxokKl1CtHA3LtC8vkb89ZOYRDqLYvkAIvDxHE2UCLCnWez7ILsug
KvmKe3mfjZwKw11PErbKo0JRS9WLfT+85vJq4vS5I4P5D4kp/8q9FX8LN2dqdr1q
AAzJX+GfwCqWRe/yCWHXyg03R1A+0UC+aQHWrFp6IsD9XyrCYVtoSAeKikqpNzf1
B8JDEqO4l086MYUAi5A8HrPmQFRDsRunWJFF2IMxIjJ47Qqz/7In0T+tZzE3FJhO
f3b+K6LCv892j30816ehbYjQwVBu7xy+AP6l6UM9JGUoHn74Zqla0WmecE9nK5sa
oZkp/a5gOzGqw0rPAeDz5kX/HTzdE9kACbvkMvn9Owch5wANn/jdhRN5VclwzJfZ
3TGOvLzPGNFBCkpYCsE3gxdIPXPsK0DPJCmEVn7jzgyyiF5854dym6gpuai2R60u
a7OANkjLhr/6jVQ0oqvOzn/wrh3LUZYMvfhkMSuLYmiubTdIbtEBvE+pUG+nWl6L
PLpjT9vz81E9x72pJmI2rdZKs42sDNjDVM0qgt3fj/k1sfQtz6nycMWQD0/LKlsq
G6NcrdyI6DVZpOUcomfZZ9pyHpNXdjFyTyd20R1RTzsUvQRVcPl+TxLMK64xRv9Q
miXxO3bpmTawGm4V+ekR
=g4YW
-----END PGP SIGNATURE-----

--B3UyBIKcLn4zZXdv--
