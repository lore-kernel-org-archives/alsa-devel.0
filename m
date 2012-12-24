From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove unused 'ret'
	variable
Date: Mon, 24 Dec 2012 15:52:58 +0000
Message-ID: <20121224152041.GA30042@opensource.wolfsonmicro.com>
References: <1356179894-8489-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5670876125661415621=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E1BC261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:53:00 +0100 (CET)
In-Reply-To: <1356179894-8489-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5670876125661415621==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 22, 2012 at 10:38:14AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> commit 9bde4f0b1c (ASoC: core: Fix SOC_DOUBLE_RANGE() macros) introduced
> the following build warning:

Applied, thanks.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2Ha0AAoJELSic+t+oim9+2cQAIxiUGRwP/mjWw9xJyU5Rtyf
qWr62+TRvPHku9nt+1II0yE5+jjjZ1yez0UGgGZNpllSKYRoLefrmldStGeEroRQ
EXd7zoan8G4s8N44a/Ku0UdOsb/S/Ds1vAmslihdqxWcog32gJPQklpB5mk1iWiI
PiiApTjWde74eRoye2xKT5Rs7v+63sURPjk16iTTUIyumzZQcFAuvQ3jR8107sNS
5adqyISZ1RL416szkJp925eue1xcT+PhPQ02/dB0jBxAY+9NS5RXdgwoGj5NBvj8
FgWoM06KZDso87qLhVkzXxZoPlzjcw7/0oJ3p7W8UnZA7Gp0NlxX/nHF2FIn9EYX
hLAXQSRws70hZOlByr1eNrFrJegjxOrRqlktMLi14BwsOJ+JxN1e+drGZvK6iYKC
z2bfxjJ1aUgz4yEtYs0dsmaXOkJbMtVb9W7AQN3eqZ2fSUVUSuB5t0s1f5MA91HU
ryChbaeF1qrO/XhrKGuFFR8Tq26XUvwzJdc3FuW643htXUbJQOJzdEuGsdhXDU13
I2jCOVnMC627pZhHIR3UtOH2slOw92wfsOnxC/bWf721S9VlmRkRA52FIrf2GwBR
lEQKtoDEzJ1aLm1/17pfDjR7THPN3EpsdcjEvftFIBJsyD7TvZVXX69/w5EtdtJe
rBVCVvl+BKS8QoU094si
=eKoG
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

--===============5670876125661415621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5670876125661415621==--
