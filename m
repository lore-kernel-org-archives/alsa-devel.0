From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 3/3] ASoC: dmaengine: add custom DMA
 config to snd_dmaengine_pcm_config
Date: Mon, 9 Dec 2013 18:45:13 +0000
Message-ID: <20131209184513.GV29268@sirena.org.uk>
References: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
 <1386105994-16373-3-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3533825415850306292=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 535E7261A1D
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 19:45:16 +0100 (CET)
In-Reply-To: <1386105994-16373-3-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3533825415850306292==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mKE4ioR2x99FlUnb"
Content-Disposition: inline


--mKE4ioR2x99FlUnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2013 at 02:26:34PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Add fields to struct snd_dmaengine_pcm_config to allow custom:

Applied, thanks.

--mKE4ioR2x99FlUnb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpg+2AAoJELSic+t+oim9RGAP/RUaaaob7fd7SAI0Am5H7y9p
ipQubBnGlnJ/shPZB+/by6qrT5aMUz8ERwZd6BeWyNaYF6QL6S/Vmp0wvWKAbjWc
jXtN6Or6FbdEyBEablJnXr9SgGhqn2P3J5+f1TK0n44PxZEj2EwECIA/MLQhnvtQ
1JvXNdPw9m6zttaC46WdIR8rkU248ewhM1YbAwZUpGSBeFHzsYK5lxb+xDNKr2m6
1V6r2rX1fQj0b6E5fbVRrttrFr+mbt/g+1OoLWoZGd/VzIpRg8zDB5PvmQPrugkd
7IxaTvlja00I0ciCwoUMn09mXDmhDXmjJ0cm1nio1PVsdoq63K33c0NHouhjt0KE
OflFKQkWDgxFC43EK0hnXs9viuN2ltWEzVFZ9bLS80gtT/oXNevCEtNzj/MniiQS
tdCm38wW3/BcbaXUDbyU4qYcszBdTs2Mrh40ZZY3kVaSxiW/G+e0IL8wzi7usPcv
ufVtBk4Viyf8mXIwaohBcNPqhEheXDXMWtQpZyItCa/9aTDP5x/R0fUy0A5DiaeP
q8HiDTZkcv7AL1NcI8muZ6CZNMV3tX0MZNtKlcMhXe3UMsH0WJzueb75kyejefV/
/2JUWFa1qhZuQFhlqNzMG0+NWlsWHTEKNATFQ5iSOd0Bj9BTxG2DmYeaoT/LQgDS
IkEMSPB09U0tzMbEcHPU
=4MC1
-----END PGP SIGNATURE-----

--mKE4ioR2x99FlUnb--

--===============3533825415850306292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3533825415850306292==--
