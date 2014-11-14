From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix SMALL_POP bit
	definition
Date: Fri, 14 Nov 2014 10:35:32 +0000
Message-ID: <20141114103532.GT3815@sirena.org.uk>
References: <1415938487-20196-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8809035192189473889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E8DA266623
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 15:04:08 +0100 (CET)
In-Reply-To: <1415938487-20196-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, craig.mcqueen@beamcommunications.com, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org


--===============8809035192189473889==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/1KIQvsSd9dqOVfA"
Content-Disposition: inline


--/1KIQvsSd9dqOVfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2014 at 02:14:47AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> On a mx28evk with a sgtl5000 codec we notice a loud 'click' sound  to hap=
pen
> 5 seconds after the end of a playback.

Applied, thanks.

--/1KIQvsSd9dqOVfA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZdrzAAoJECTWi3JdVIfQip8H+wRd2qB2zLkL8JlWCRsP9a6M
xMZMNZkfEj4GPtcUiN92oberLkiH3C8NWzBFkvYMCaAZ9M54uxk5nTS+wDVhNkT7
fqmbymmEUuGigR5oKfodFD+vLYmCuJKps6Pi4AM88mr0qw3x/AT8WWM8HFQPXjg+
VMQvyWmEsze1H470DDkrnum9wLGTYZ83EmTcjM688Sw541E9Tg1yF33+RehgnS8e
29fb5zYYmO7BCf/ffknLwT29YRl5lRwzImQ53XFAsKHs0RdzpB1FhsuoBacuGF5a
sRWmSAK5f/vOZx6gEakMz/JGkhhT8J3dwo6j/OyohD9KOWDd6BqTY3VaDefp9xM=
=MSHe
-----END PGP SIGNATURE-----

--/1KIQvsSd9dqOVfA--

--===============8809035192189473889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8809035192189473889==--
