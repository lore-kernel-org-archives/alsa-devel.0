From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/9] ASoC: fsl-ssi: Fix probe error
	handling
Date: Wed, 8 Jan 2014 17:18:44 +0000
Message-ID: <20140108171844.GM31886@sirena.org.uk>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6854132177098091236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B59262625
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 18:18:54 +0100 (CET)
In-Reply-To: <1387545096-2334-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6854132177098091236==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PBrk6O5rlxon2iKO"
Content-Disposition: inline


--PBrk6O5rlxon2iKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:11:28PM +0100, Markus Pargmann wrote:
> This patch fixes the error handling in the fsl-ssi probe function.

Applied, thanks.

--PBrk6O5rlxon2iKO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzYhxAAoJELSic+t+oim9FQQP/jdwqWkt8P32TP8x+jKB3F7s
5TNfImDxr/KBoYrO1yQ03BBOgZNQ116acakz5D4Wj1ICoBrapb1z5GN/bu50eJqf
9XHx0QGfrSeEZMK9spfN4n1acYx959OG3R8kUFaocMWzC/+x90HnWcZ2RzFEfNcE
qavhIfiL27DdEY2cm+bV+7PYnuC/EGIXVnRXqqd9Y4u39hBN3msLjIylypDb50KZ
ubvS3AZ3QdmKX7uvqh8Z7AhIlKxzyKbXK9pTtKPJ7O4udxJOgUA/TJloKW+SJdlf
/DV8lZ0/FQopn+A+J1uecqq86gZM1/m2mjZaeZpt0Btd+hkdIRbwAExy6C51KBBS
hB4FNdPSEH/JyYfRzoEUF9S/xJAgXdB6V8FCDNUUJA6FKw9DOJ3VIBOUGQrppfa5
HmV/r4VfNVJp8o/j2eaS95FjHT+vpbIzIo5vmO3tAO1r1NVpHDSMK6tyS+qRhPJu
xyMfRoFk5YR9xLjXpi+BR0y5zegVg2IHV/LMVfflUROt1/0aQjFX5Ou9PkogYM1S
GCbcPFfAuOK4T1y0/PQabCaLE6KoxElwmNKb7McGXgqkeMhP/hQhWylmoIYGQ6JM
qY8h0ihA6U+5LEccX27VkVcNfxZnbSMxejR935fC1H3zvdDcY9T1nRigCTFCFOCl
EdWR1ZZjnZDuuxSj5pTb
=KXox
-----END PGP SIGNATURE-----

--PBrk6O5rlxon2iKO--

--===============6854132177098091236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6854132177098091236==--
