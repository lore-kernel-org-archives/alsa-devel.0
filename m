From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: SSM2602: Add sysclk based rate
	constraints
Date: Wed, 25 Apr 2012 11:29:07 +0100
Message-ID: <20120425102907.GL3195@opensource.wolfsonmicro.com>
References: <1335346968-6086-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5823896222374157697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE55E104879
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 12:29:08 +0200 (CEST)
In-Reply-To: <1335346968-6086-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5823896222374157697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2012 at 11:42:46AM +0200, Lars-Peter Clausen wrote:
> Not all advertised rates are available for all sysclk frequencies. Add
> additional sysclk based rate constraints.

Applied all, thanks.

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPl9HXAAoJEBus8iNuMP3dJtAQAJe9FO5mE3JCrSQ9JQXLQGeH
BShN5KizUtSVxqHZzO9GosuIvsDEGGUgR0og8G2XuXJBr7acEQoqcZDO5bOoVejk
OrpB9q26U49BXG0uJY7a/DOeiT8MA8zFmc7YFVLU57a9SN4Dvc0VMDkutRJeObm7
IZxjoUugOra2ZZ2TQiavyp+aPjvcERFavLQUtcOxZD+m7IwQV3iXKJHXnnk1qlQ1
qvvg6HMaqjQ2Qtui5qOP2zR+Ix4SFh/B/ywZUk9uFwm6GHdZ80EX7+J34RV9Rd5/
zSWB+Ndzy8xiSpfasjEb/hMUSlNKOIbB+rZdJW+VbsfweDby4f3z8R+7BEF1nfLC
zFBLvV5qRlKkQAysWnx0awfLCL9YMc2k/lmZ0tn7UBxICg4X1fCLS/hvBQZ+fLQa
HRgKstEQ2uhgMTI/DBVRk5QwxWapMGf4vreu6Tnn3RPGooHsCNNFni3eNGjrEC9B
d9taHSO+5aJby517YCG90vRx/w1zwWFXGAqA0m0H0a9e4go1wQk/KtzqIvg/Chtu
1iIzwhQ7QZQA6jmd4rcuPAHVEotnMiHBeYCgdQurkLXsb1PaJFEbgAQgMalNOHmm
kOaf3TjgCQJTIgp45szgfRZ9VVsilrqH/WDVA1c8/mpA7Z8tVsu94InsP5w5tx3P
3FsF5B+ryWdyhMLb1Jdh
=kAL7
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--

--===============5823896222374157697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5823896222374157697==--
