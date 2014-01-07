From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: fsl_ssi: Use '%ld' to print
	'long int'
Date: Tue, 7 Jan 2014 10:54:41 +0000
Message-ID: <20140107105441.GT31886@sirena.org.uk>
References: <1389088813-14405-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4250847843868456047=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C53E62616FE
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 11:54:49 +0100 (CET)
In-Reply-To: <1389088813-14405-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shc_work@mail.ru
List-Id: alsa-devel@alsa-project.org


--===============4250847843868456047==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cd004DbFpHlNXMQI"
Content-Disposition: inline


--Cd004DbFpHlNXMQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 08:00:13AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Commit 6873ee464a (ASoC: fsl_ssi: Fix printing return code on clk error) =
caused
> the following build warning:

Applied, thanks.

--Cd004DbFpHlNXMQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy9ztAAoJELSic+t+oim9UWUP/3CH4OqJH2bm1Pb2m0uCcCw3
iyuJvCUCSZASDaMjebvtFg5VSnqTemcODxgU/rMFiRkpTS4YEdmPGOymfCqvZhe9
nwZ5nc827hh/tiwKAorKTGECfWFdgDvCY30wpyfwUbquligEzZkHFknwk+euczTu
pp0VnjGh4J9dwsLLnd/kQ/156FC88feZQIcgiNaxUG9+twk3Tztfnv3TwR6LmvEA
03D315z26bHa4Ivk5FElTpUdsWlXos9OKBmeo8XF03TYcfMdXCAT+96lKEBqFeLA
eyRDhspYtTrU/+n35sebYKR5Y8zRO2Hln9ioD9azfIaadJDfTyHGKVVnlyg6CFyK
3j59Uqw7k5Ms0vJ02DXAFB7vI2FfAuH/z+1QIjFKMijbOX7cer3uTsBBCJzAo+Xt
rqiQ0Hb/BYOBl4XsDQ4TwiGQPkcZqkwhn72tV83hzxBQy3AZYgXiIGuXOMXTga8I
sOZpGcAC3W1Dtx84k7C68e0r0v04rKypCcD9XbmsI7rCfRAjjJNKm6G8qhqhQQwR
NrlDq3JUnQfqYvOmWYFDzPD50o6/7EC79Rai4kvedHgblKNQHJnoj1wItn0KlHPl
+hlJzP1t7DuXf3XpKNGdj3IResD6tNQ5N6kFYWRNJdaNkvQwC3q0OWtxP0r4yCZE
Oij0ZICSvRYypdhkphq6
=fcFx
-----END PGP SIGNATURE-----

--Cd004DbFpHlNXMQI--

--===============4250847843868456047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4250847843868456047==--
