From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pcm: Add pcm operation for pcm ioctl.
Date: Thu, 26 Apr 2012 17:55:20 +0100
Message-ID: <20120426165520.GO3207@opensource.wolfsonmicro.com>
References: <1335453370-28020-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7736800239062518224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4BBDD10BB9E
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:55:22 +0200 (CEST)
In-Reply-To: <1335453370-28020-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7736800239062518224==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yUmmepPgoWmUqRhm"
Content-Disposition: inline


--yUmmepPgoWmUqRhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2012 at 04:16:10PM +0100, Liam Girdwood wrote:
> Provide an ioctl marshaller for ASoC platform drivers.
> This will use the default ALSA handler if no platform
> handler exists.

Applied, thanks.

--yUmmepPgoWmUqRhm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmX3wAAoJEBus8iNuMP3dSzIP/1d6SfvxaP4veXR31GRfz4ET
Nufl+edp3hw1mU/VrVAqydnMucVpTEVoBvyariak7z861DU+bmFwB2JSx7jzLwWt
YwE9B1fTtRnZ24zuG0gotViyjed5Ex8veUSGBuwUiZbUiBSBiDloXdL92sZUtTdD
ACVyWgYQFcLLNhGSZ+3VvF+hVnZ0Zw/ouZHMSjs9JV2DGl8ZaJoX40pVjCmdiJac
MbfG+PEXf5YqQP6oUyuzRWxdVDaLHsjo12IUVpD6gmHkRZUua5MoOw2U3J4+M3/R
EjEhwUOh74jYqNAjZu2HLzZ4BRxeFdfJyZZb0G0namXq4DZzK+v0BU5DujdeqsSj
3rxyLOvzVHpqLI51wyM1WoxH9Z4inaamZQIF3A11SfL0CpFCQMy2FsjrOkqufgAt
EaQS5zZax62b1XQde07ciLpWLUFG24kY2Mvu56jrYnorwlaJDE13qvZXYeJQHemy
Px09ZDPI+4PxlUjpnnLChsk4cVaJyYCpSqfgkqhwUfT3Uzk6jI2+xawIDLOioxZn
aL+0b2YaHad6R0+ip0IHEQREIsPqibEiJ54vaRfwDMxwOmHZiDKiIBSFxPvSnow6
bRxvGQhteD73sMvhQKbJ0KxQNyamEoYnhcudFBEaReskdCD2o8gP/fxpdZe8GP+V
tctnTmOFdurBTAa79vsw
=IbD/
-----END PGP SIGNATURE-----

--yUmmepPgoWmUqRhm--

--===============7736800239062518224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7736800239062518224==--
