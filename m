From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm5100: Export wm5100_detect
Date: Thu, 23 Jan 2014 12:22:02 +0000
Message-ID: <20140123122202.GG17314@sirena.org.uk>
References: <1390474406-5790-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7766938686884030057=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B2C2625D4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 13:22:12 +0100 (CET)
In-Reply-To: <1390474406-5790-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============7766938686884030057==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2yuB1BHEISck7NW1"
Content-Disposition: inline


--2yuB1BHEISck7NW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 04:23:26PM +0530, Sachin Kamat wrote:
> Export the symbol so that it is accessible to modules. Fixes the
> following error:

Applied, thanks.

--2yuB1BHEISck7NW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4QlnAAoJELSic+t+oim9Sb4P/1x2nwxcaZhlknsSZNede4an
WwDzPbxE15sHLvWrH4NEcW+1nUn/oFqu2XylcX9EH0w2PFvFK8NUo3DooLkIc69D
zAgVdq4bhEBtR8JXPiXjisgq75eEfaATrBUXlxs0K8JYNduoHnj1IlTkwPtOdI5b
pfMxfVjxK1d+LVS4sg+8DogIU74xYZd0L0IZPvWVHV1gsAaVbEigml1yA4k1ikdp
7r0zMmfLlzvduukSc90MTMM48hRGGfHsSein0zozep0ntvzsArppRnnYt1S5lNqE
N5pwqRGUdGH2jJi2wmBlABiZFgwKM7Mo89dLqKmoSieTctDLokRBspOWOaba7wEH
JtLnAh0USAScrbDsnSPbdqnI33P2qHDQ16V9WKJBscyY8las1uT7Od7YeiJcR9W3
XVFZryW92lxstVr3/gH1MaH9O6licvYMByY9ac57BLLTuT6gJDbdHm09kA/uGFf0
PQ/S9f+Db6IAMeSRh5W3ex5F3rnaZpd8v7mWluzS0fuCIwI1HrKH8dPd570O90s2
TEHM2TI0LSCza5D9ByTyxvpPsrCYABZTrp4EQPZRZrL8sUFAO0CSs8Bh/v0HzJmZ
DXUD/DaV8XPO+21p789umxs/B3L+yE0PdDdqpVHNFz2SX9rbCRd3qyiuI4048Kg4
DWyhB56EUtwZG/jCx6Rh
=0a45
-----END PGP SIGNATURE-----

--2yuB1BHEISck7NW1--

--===============7766938686884030057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7766938686884030057==--
