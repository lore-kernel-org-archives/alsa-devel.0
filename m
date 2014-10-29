From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v03 0/4] ASoC: davinci-mcasp: Correct
	start/stop sequences
Date: Wed, 29 Oct 2014 12:32:44 +0000
Message-ID: <20141029123244.GI18557@sirena.org.uk>
References: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1056919616810058865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 916AE2604E3
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 13:33:15 +0100 (CET)
In-Reply-To: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1056919616810058865==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmxSQ+XK5f0H4C2R"
Content-Disposition: inline


--PmxSQ+XK5f0H4C2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 01:55:43PM +0200, Peter Ujfalusi wrote:

> The startup sequence for TX and RX was not correct, not following the
> programming sequence from the TRM.

Applied all, thanks.

--PmxSQ+XK5f0H4C2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUN5rAAoJECTWi3JdVIfQ1cYIAIYuFdpT7JG5wkSlYU2eskgJ
ZzAjTO3kkyiNyy2jEgOoEHu5zg9Bsaf4yTYvAlo1CeYX1VfFhdJoVeQ1gx9+ievZ
YqnXiUL6EckE8cI5Zwb1chk25c+iaUMdf1W2leOKX9a7wEMBSKY0CMPICgLNWHCq
NeSRnKkFXynt9kU/ZgT1OplRhFhWBcacXLOzUFul4QJUdY0L2pIx926m6BHPgmw7
PTqPQiRj4TmVnPMOZxK8wOOcKi++GYl9AVmOQpVhe3IgW9D0GJkrCHMgQATRCqhq
g4eA5K4RkFbnpyW1K5+g6U3iRLa+kjte/EM3/RmNQK4z8jU5zWt3HjT9IUuMvr8=
=5CMQ
-----END PGP SIGNATURE-----

--PmxSQ+XK5f0H4C2R--

--===============1056919616810058865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1056919616810058865==--
