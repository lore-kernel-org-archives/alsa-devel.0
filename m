From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: corgi: Automatically disconnect
 non-connected pins
Date: Fri, 9 Jan 2015 21:06:06 +0000
Message-ID: <20150109210606.GP2634@sirena.org.uk>
References: <1420837413-29306-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7656954097291417145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8703265053
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 22:06:15 +0100 (CET)
In-Reply-To: <1420837413-29306-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7656954097291417145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ou9wORBL2D7rb/hj"
Content-Disposition: inline


--ou9wORBL2D7rb/hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2015 at 10:03:26PM +0100, Lars-Peter Clausen wrote:
> All DAPM input and output pins of the wm8994 are either used in the card's
> DAPM routing table or are marked as not connected.

Applied all, thanks.

--ou9wORBL2D7rb/hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsEK9AAoJECTWi3JdVIfQwOQH/jNFeQ9kNW0gxqpVC7cUHVGK
5hG83hLiAt9QrrwUaud4evc1Cwz3QV9WyIAGUIjmDVRjMLrrj+le4/aQSnNETAYt
2nyjong9SZCmb6123hQd1cFUZJwsY4LH2xMTE7VrGdtGvPPsWKceSqDRYe4QgDnF
MRvooHRTN0pGX/3DoB30V2evHtW76OCozwnzwudb9UfUInCM+aQm6rFltirAo9+a
TaJ5G/2In2dTfHHwDzm9b1rzKHb54Iq/qBdEm+iUXeUnXfzJeLfqJDzDmMySQv5c
NTZSwgCzsAoVrD5U/8kbfmke2T5bTUzHBTpabymBxpjlKJvfNE5ezVu4KPZe630=
=GsDH
-----END PGP SIGNATURE-----

--ou9wORBL2D7rb/hj--

--===============7656954097291417145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7656954097291417145==--
