From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/11] ASoC: Consolidate enum controls
	and DAPM MUXs
Date: Sat, 1 Mar 2014 12:10:14 +0900
Message-ID: <20140301031014.GH29849@sirena.org.uk>
References: <1393572672-13937-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7079189923470309095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 472B1265292
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 04:10:49 +0100 (CET)
In-Reply-To: <1393572672-13937-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============7079189923470309095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2014 at 08:31:01AM +0100, Lars-Peter Clausen wrote:

> The series depends on topic/dapm, topic/enum, topic/sign, topic/adau1373,
> topic/max98090, topic/mc13783, fix/wm8994, topic/wm899

Applied all, thanks.  For serieses like this it's probably worth
considering sending a pull request (with a signed tag) which includes
the required merge as well as posting the patches.

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEU+OAAoJELSic+t+oim9y+YP/Rmkvd1qUnCHmch1EwGm6uZY
KPnkdUwJwCxq15SF4Z9iJQJHvgTGPWvyYHhtdetIPEJZ4huaBqAZh3qNiQxVKPxy
jnRGL5ZRT4Bavmce4OQLGPgHsVk0pLpYbZUX3YgwRkpUrZLV4AWqQSEpYGnXnSEw
q22bFjbFt1ekHsRc3Neef3/6HEBzIhLdv7yVoZjom5pnWLWOERNP03OkdEDbPOEN
++MCkQ+Rl32pD3A/EEN04gpLX9fliO9EaIdjqr0w98uACRgnYZ2PZ8+XgF13wjrS
NkYe6OSv/hj21sOT2/HGxwkU2cq6aXN0Eg8wLwAzCZYh/ZVwjGv+N4jLJNalGv90
PrNDgGF5h0TiHOFX/H5J5LEloHBVhrRAAfOMLafSIu7dEgEgWLMBcE8eaVht2Mf2
vTgTKgRK6JBeCr79+PYrPG27SYXgBsB461DrDDTSgiV088UAG6/jeVeCpTPk/zIA
xfuhApSpM7G67rReAf7X5JtMvdKF4W1kOY8MGzbmjdD+KxA1our8gLLCppvP3Ibd
UxGoLT+0qht59ZpL1xvc1kbZF1WlrAB9yn3zY+Gx9Jwnh5m1VW0VKvdlIU/RLzjc
Z0TiOihIF2djucQPkHmZCRoyaxeWqCFEMdfgJJl3QWUc5P3fBECioT0boicupodv
xGscye2vc90LygMr7YQW
=0C+j
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--

--===============7079189923470309095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7079189923470309095==--
