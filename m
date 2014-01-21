From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Do not print 'baud
 clock' error message all the time
Date: Tue, 21 Jan 2014 18:48:46 +0000
Message-ID: <20140121184846.GV17314@sirena.org.uk>
References: <1390246540-23082-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4338279393995340025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2222F2625EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 19:48:51 +0100 (CET)
In-Reply-To: <1390246540-23082-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============4338279393995340025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NfurIl5WXYRpyXXO"
Content-Disposition: inline


--NfurIl5WXYRpyXXO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 05:35:39PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Currently everytime we get the following message on boot:
>=20
> fsl-ssi-dai 202c000.ssi: could not get baud clock: -2

Applied, thanks.

--NfurIl5WXYRpyXXO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3sELAAoJELSic+t+oim9EqAQAIU/l2NC6nYlrAsary+gUNMT
8Vh4Oau6YvvFC+jS/ArftZIS/lgBR97WkQJWAwEzB3azdQgmoe/rN52z7WzQLs5y
OavkQ2RXfAFWz9Q0VYnWEb4ZwbSXZcPC2vx3FopM7jmznbVB3dkjYtMs2AywzXmA
m6lGv+CNK7ix/ZqoqzoiCq/o7Zk+c/8AtwYeo2+Ak/Jx1gskk/uWKWYyS+NaW3lg
V0bD8gya4RoVI31tp39gVYr22wXGxGU1/foujNRUu49hE+WevuGQEH5wvD5MZf+m
1lVrte3wg0VDaTQ84rXyd2gGl0d3Z8tVhC7ICSmA6lwlo+SuuUX03sK+QxYVNSv/
hCLpz9Php59POcXfjn2kaIzSkMaISV4u7yngzjiAMuK5kHbc1nQyFHQUCm6JDvE+
+V+BvtW48sk2KI5CPferr5ppWpAGhWBcR3vcYYKmu87pM9ukozi6/QvkoRwwtDsG
h3LT7ObKfXPd7fjKSOpcJJw2DOA2nWpMDbG0u4KuHwYF6TdF1XtbPC00/bN0KQ5y
3B75+k481RsD4NONVlUvsWZo9WnpB5TPlzNbLayPh1OWlKZLLCw9aEXM9Rlrjgkh
TP7bbQDW+PCAEFQvsJXEz6feey638ikfS6nfy+5+1c5Rd3CfrsSjgY4gEPFiqW/6
a0W5CJeB2YBQ8OtZj2Jp
=ydad
-----END PGP SIGNATURE-----

--NfurIl5WXYRpyXXO--

--===============4338279393995340025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4338279393995340025==--
