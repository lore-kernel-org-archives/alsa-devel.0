From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dapm: Add new widgets to the end
 of the widget list
Date: Wed, 6 May 2015 17:36:10 +0100
Message-ID: <20150506163610.GZ22845@sirena.org.uk>
References: <1430496165-13917-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1772495939157195700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFA25260682
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:20 +0200 (CEST)
In-Reply-To: <1430496165-13917-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1772495939157195700==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j4RN9nyOJty92gQL"
Content-Disposition: inline


--j4RN9nyOJty92gQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 06:02:42PM +0200, Lars-Peter Clausen wrote:
> Currently new widgets are appended to the beginning of the cards widget
> list. This has the effect that widgets that are created while iterating

Applied all, thanks.

--j4RN9nyOJty92gQL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSkL6AAoJECTWi3JdVIfQBVkH/irjt0yIsoH0XX3Fufl3ccyq
nBSrtKsnxTvjYCnd+y26homCZ3wOPHN1jNHsXpnTvZKCp8BEyHF1z2O1Cfk/Kg0n
Dnkyzau7cWraw0AuaE0ID2j2ZFsYcJTIeJricRNpNwH4z1ot2eX6Mz0zZ5HlafGi
BOwFySp5RHQ4muzTgngZjLsBXNcAWJH9uW2Pr2l+U4OlH51mLZvdoqSalZMz+/fX
5Mn9hdPGjdqqFd1DvDXRY/DYuDOdDGjce/p27pKek90REbThauZd1sWmQ2ECOOgO
IaK/sPPy01Qj5mj2nRWvbRaySTxPwbbNcb/mt44QsO0fx+7ow10Ba/OMAGoNNbI=
=Vekm
-----END PGP SIGNATURE-----

--j4RN9nyOJty92gQL--

--===============1772495939157195700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1772495939157195700==--
