From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 028/102] ASoC: ad193x: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 10:39:58 +0900
Message-ID: <20140220013958.GO2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392728699-14420-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2464048267572612831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 86ABD265717
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:50:23 +0100 (CET)
In-Reply-To: <1392728699-14420-1-git-send-email-tiwai@suse.de>
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


--===============2464048267572612831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H99FJOXRwgwC59Bw"
Content-Disposition: inline


--H99FJOXRwgwC59Bw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 02:04:59PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--H99FJOXRwgwC59Bw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVzrAAoJELSic+t+oim9ab0QAJjPkYZno82ZvLJym6vhQyFZ
BIjeNdBCURy/0M7uS+Yhk/y9vke0fQ7+RtZY9sHOMFuPcWqDJBTnnebHtmuHl6js
ySw7w5mGuVreIF7Vje2bcK4vZ5TPMHMN7k2aGTG6LO3NmYM4nFiqem70F2jUrJ30
NFzEZ04PYOVbWhY+N1CDIWBMNHgmn3ruzP2cou0PYcbYOD+DopnE8XEfdisves7J
NwYO37mh4f3sjrCH1632xTmhDvCdlPZV9SIdIms0Qz9xYnCOA2t6nxF42kxpRVo7
Z2DgCnsZ7FckDdISL5o2HoHw7GCl4lIbojvesog5lda/lLcLuAJv+XrZ60nZ1ipn
eF9b4kLYOV5l4B7j1Pb6d4xUerhLj1TBMoaLlkhKsoa67+2XdpVnnXNQOfcteVOe
20bFLh5RScDylaFMQrGxl7ednHPXShdnZwnfG+76R3D5x6PNlrwZnR8FRqAXUzfd
uFpOzCVRN/oqNL7mRN6x9gf+KLXXHa7W0zXabjzNbLqmFJxeOEYxHH+V4QB+HFWm
kkyFBek/Egzt32yZwC74ihG8Mop4SsLViIEVPJXRJ2k+ce8iNqMryUZ3FRTeZJbo
t0WKMDyuO4NTTmH+SgSLqmxS9//04FDksK9ylpmYo4zw/ZNUh4+G2n0+QyQV1sKU
PqDfas17JOVoXnQqNCQt
=96TX
-----END PGP SIGNATURE-----

--H99FJOXRwgwC59Bw--

--===============2464048267572612831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2464048267572612831==--
