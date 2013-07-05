From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: sglt5000: Fix the default
 value of CHIP_SSS_CTRL
Date: Fri, 5 Jul 2013 10:46:08 +0100
Message-ID: <20130705094608.GQ27646@sirena.org.uk>
References: <1372978863-4872-1-git-send-email-festevam@gmail.com>
 <1372978863-4872-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8566347118529587553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 15CA5265847
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 11:46:13 +0200 (CEST)
In-Reply-To: <1372978863-4872-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org


--===============8566347118529587553==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ev8sd7IJgyh4xyID"
Content-Disposition: inline


--Ev8sd7IJgyh4xyID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 08:01:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> According to the sgtl5000 reference manual, the default value of CHIP_SSS=
_CTRL
> is 0x10.

Applied, thanks.

--Ev8sd7IJgyh4xyID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1pXdAAoJELSic+t+oim9IlUP/A4K28XZ7Nt75oX7bPcG6uJv
A0ldsttRmODgU0F46e+LSwLCpWeT8qQQ/1LbKdR6Z0rJIXZTVqK03N1jF8UcA0Kz
/9n4BKeDXIzNm5wVHkKknN+i2vrbk+Scd+tPGk6ccSPVUIRZ+7+NreFuQcMuJJdI
GjNcJH9SpsFoVKFpMkCKXAK3vlHXgIxRekRLxsV7Jvsy1qKLWaj5ml47axjFekQM
2lCC/1TsSVNZswINXQRXVcKorE5rZVQnbqXac944/t9EmlfFjcgTbJ0Qi+1soZ6D
0e9YeL9/ZMIYR2XOqBbzgqx79FoZEp0PBsVruJCWMwWimsCEmmmV1H7y1yiHQLYC
ecYwyWe58Cppx4g1uEk1U99zOYwDoxFyKs2pBh239+tkz67W8zFvoqcJDmOPefcM
74ZvI8GC41OabLuV40GyqyxxAITFPH4GwrxNaK2Be1nzix658sVgjmg4bg1R7RZ/
aBVnJzOtJ2NwHrYb3DvB/4WTpQwpcG+vukstlcgnP7ktYaO6hY2GqvbUrfdEj94t
aGXIVHD1OmnHyTiqBqLqAseBQUa8wPqvWGsBm2ToHLc00RqPXazk+QrzAIFX2QWm
fsP3f0I3v3TMvcJBHrr1cyf//GXhQPA58SOeTjx6SLSztD6SJRw2ykLkhHsyyri6
51AL/upJraklSJ0y6jrK
=iZvU
-----END PGP SIGNATURE-----

--Ev8sd7IJgyh4xyID--

--===============8566347118529587553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8566347118529587553==--
