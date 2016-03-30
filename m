From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Add I2C dependency
Date: Wed, 30 Mar 2016 14:06:45 -0700
Message-ID: <20160330210645.GU2350@sirena.org.uk>
References: <1459365788-18711-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8109398217500119616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4137265065
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 23:06:55 +0200 (CEST)
In-Reply-To: <1459365788-18711-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: ckeepax@opensource.wolfsonmicro.com, festevam@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8109398217500119616==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L7QcuKEPlEDqpLxW"
Content-Disposition: inline


--L7QcuKEPlEDqpLxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 04:23:08PM -0300, Fabio Estevam wrote:
> Building wm8960 codec without I2C support causes build issues:

I already fixed this.

--L7QcuKEPlEDqpLxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/D/kAAoJECTWi3JdVIfQMkoH/j1t/lV1nvkn9A4gPr5l6a1U
vzsThk1RYBTw1rvGVJXpLB2UsMDNs+k0GFdVRTo3OLz9dh6MLpfv/QZTeWIxOWuW
LG4T7xwG2aGDmbJ6IdCOZ+pANHSDIk+vyjNKqnskFXb6d48i4P1MCn4RPdML5qoW
LUPW6pFSxPNY8hcGA0t0FhRQBpGpuDp9e+J7BImwAUhDgPosC6/2Tme8lPnK/dlL
H2EaGfDef+OwyvTYtvPK3JvGw5EUJ6GAUX5IDuSqKHLHeXkV+mqxBF+AqArnISMZ
gf1LdOLjI2YA+CSFwyO/sDpKGlB6vhKoIXcLwzNU6PghGq8ZlVZ5tNgHtMmopsQ=
=Ynht
-----END PGP SIGNATURE-----

--L7QcuKEPlEDqpLxW--

--===============8109398217500119616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8109398217500119616==--
