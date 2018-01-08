From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Mon, 8 Jan 2018 11:20:46 +0000
Message-ID: <20180108112046.GA11698@sirena.org.uk>
References: <20180107141943.y5hh3cob2uak4sod@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8684861326148961744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 881A826698E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 12:20:50 +0100 (CET)
In-Reply-To: <20180107141943.y5hh3cob2uak4sod@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: alsa-devel@alsa-project.org


--===============8684861326148961744==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2018 at 08:19:54AM -0600, Steven Eckhoff wrote:
> Currently there is no support for TSCS42xx audio CODECs.
>=20
> Add support for TSCS42xx audio CODECs.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpTVA0ACgkQJNaLcl1U
h9BDyQf+KAjkajZcneH0vBdstVHBTjsQDMp9xmIaWl0qiXYzYc7t05Zl7cRhSSTx
+ITw4ft3m/dshAshZR8ZM6QzKpyyJoFX8TmfW6bS0666aLeKuSsacMseIEW9aTEo
/U/OmvQDYnQ6M1hPKtviKDglvs7KCsTUvwdoqRU47s+VtNopBy7OHrWlE7X4IHm1
kUOD9sHGDSFiw9lFbexrkCVOWlOqIM1mnjopMZ5vaSZpwjOdhptRUpcNlSZI9HUs
+U3nxlo+8ZAlqby8lhSMu2gB93vfVjli01a8g4RKLOIkO59GJxwpwmQlrOvMtorf
DM72hGd1WGZYuP9YgdwU6XA+Bdj7GQ==
=YMTO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============8684861326148961744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8684861326148961744==--
