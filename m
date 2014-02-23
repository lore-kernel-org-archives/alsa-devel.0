From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 065/102] ASoC: ak4671: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:49:49 +0900
Message-ID: <20140223024949.GF25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-38-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4676076464518307160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B63264F53
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:50:08 +0100 (CET)
In-Reply-To: <1392723517-12772-38-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4676076464518307160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+TV/ighyc7Vd8/th"
Content-Disposition: inline


--+TV/ighyc7Vd8/th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:21PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--+TV/ighyc7Vd8/th
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWHKAAoJELSic+t+oim9cycQAJ1dhthYAxd+kbarYGLZX7r5
NeXDCXQ9sRER4mhWPqWHa4Y3kaSMsuHY3kjwp17uyiqd2+CkcQZ5cTS3BSKrZEt8
K/Qtnib+JcPQEl2y+hOKkWLs4TyJ2UAypTQy5Y8mPneDjjilZWbvxm8wyFbOQWKO
Dtc4QGUYb8gksutJ2RmnerQy7/R79YRCXZ+SuFX2yA9rWpA1y7SRPXEfQ4PR2s81
jxfPT8MDLKVCf1rCInPfVDTclxMnDyNtK9dYJVSY/fU7GHw+L287o3mS6K/P+Vcy
qGeepUHQiLb5G3djpY8PhNMRkgjabjKtJwuBoJL1lbb6i5l3ndtInntKaJKEGcrY
VPABfX6yr98pV72QwRJb/uAVVBtdULtkOLaWbjVv5dgV36xrGnwAMIn63GQaPZJV
3J/sZjyRSNsuf+MlyOLHmcJFpBz7fD14zglZmEytCIh+LBPMI5RO3AG4tKO/m6rl
ZFXVlKC5m9GmpToagQobNRPiqNa4IIzq0xv7kGYUk+6dmEG6lSkBHh1925RNg+VT
C61xLa6f6vTYymMngP3PXvTOczPK3+G3714NuU9fajX6/7xV+I32BYk1s/z5947M
ycdXdRZRtso8otWlCK7YeZ0gyjNYbNLnzuIXRtdbkRdfMs9jQ2zrh+R+1kjGkUnU
skJAEtTybTW09oZxg9tD
=BIeU
-----END PGP SIGNATURE-----

--+TV/ighyc7Vd8/th--

--===============4676076464518307160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4676076464518307160==--
