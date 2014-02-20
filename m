From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 031/102] ASoC: cs42l52: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:15:07 +0900
Message-ID: <20140220021507.GJ2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6654624277284084853=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C1F19265607
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:23:02 +0100 (CET)
In-Reply-To: <1392723517-12772-4-git-send-email-tiwai@suse.de>
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


--===============6654624277284084853==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gjwOtLmhtxDwk9+W"
Content-Disposition: inline


--gjwOtLmhtxDwk9+W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:47PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--gjwOtLmhtxDwk9+W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWUoAAoJELSic+t+oim9NHkP/2wX9eR/8NK7baW0mWGtroBK
lE62LCz7yGXJwJXJ2YhL8Q1rhKOBXGdgufMIAXAP49fC01pxmkoHhodGq236JY7c
IESbxe7zerhtYi3XblRn1L3zfZXH0CbiV/WdybzPSZV5Wk5qsaK7+3V+4qTwWbyx
7p0Lby2cuu2j8Ul8Uais2+sWEfWxIKdj6uAzHUJWLobQpfB9C0jdHhVXiYbIF8uE
1i+d8OAr+iLWTOduJNAA62WUw8GdR4qdEwigx4odI0pBNlW6RVto43JbTt3tbDPa
8dop+PKiEFX6Oo6iPxSREtRarD/N+tE4ptnyEWKBrmk68ceIQQG8bRlJuT3UNkbQ
BWZNtE3PP5Z0M6ClTHNNBTVMq/i3bxnPj1lrRQPp+PEFH524MW6hFRYJxPtW3qkV
cMV10X+Zm8mma17rrz406S0RvsToHFBXowe1DKakwuKoZVQ4ONI1OhiVuYYiDSlA
t4YBTqPOizXZD55uXKy1QiNPJaQp1QCdD+MOP6DCdlXnjvdGc7rL5IZvEWDorIDM
rC9VuboTw+OsF3Bw1q1HaJi6zJ+lnl/8tNGjnuHmdGmtHn4bDMr5xhd8vsd8/xSI
lO4ADh7VK6LP7pw2iS/YvHzATwOjj6W1aF0WLUaZ6ixn7DstLx9SAFBlENclt3cr
RmgpwfAqNX2wQgMU7h8J
=I+uG
-----END PGP SIGNATURE-----

--gjwOtLmhtxDwk9+W--

--===============6654624277284084853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6654624277284084853==--
