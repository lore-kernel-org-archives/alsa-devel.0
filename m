From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: omap-abe-twl6040: Move Digital
 Mic widget into dapm table
Date: Tue, 8 May 2012 19:30:03 +0100
Message-ID: <20120508183002.GK15893@opensource.wolfsonmicro.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
	<1336479314-27766-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0862457075214822656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7CC4E1044A2
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 20:30:05 +0200 (CEST)
In-Reply-To: <1336479314-27766-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0862457075214822656==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wQkw7DhpL9hyPo7K"
Content-Disposition: inline


--wQkw7DhpL9hyPo7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:15:12PM +0300, Peter Ujfalusi wrote:
> The needed change in routing will be done runtime for the non
> twl6040 connected widgets, like the Digital microphone.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--wQkw7DhpL9hyPo7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqWYGAAoJEBus8iNuMP3dSZcQAIlt2YU6auLnBaa5RQ+fV5c3
W0vQbwEHO7/WgICgzeHC17mAabbqG0yf7ZU6QWUjch3n6nhPy6gMuG72E+cJGCyJ
hg33++2jCAvRQP8FXQ9oRyadBxTQBvJay1gKiVzxVanicds/Wf43kZDvaCvCJ2Un
kOV8clEiU0p8vm74yAcr9oHwx0y89DuOAUCz+SWhHT7YAtv5p6czuJvCiQWHXk6Z
BFc3Ig0rDDobImFk1IC4YF9g8fdGhqMtglAYo5yYoCWfiNDwZZwEzUeHscSvurO8
QkHDWmcWmmJcK9i/CHGixN9uO6jB/sKGp1JOrSw1wlFLaIHWnbtfJrXZqa8wa5cV
0qzlVnaQcYr4S+JGgHpmDN1mxhZPVNQ+fsGmD02CoAoPJ7+qzadzMgVg+Xxp5ihG
HKyiLAMKKQ+Bc1FlKpEY6Vmal4jjaJ0Yt8eNziU+6FkRgHBuIXjGhW9eG8rnc+Jn
BHhudlZ2HpvJK7E9sekpGGVz0pvQfCLx+sd8D1NSfVxP6hEsmhqjjmdpaSZTaiDY
Rz6kjjaPQBmng5wPJYoKtrIii6VHHUgUMP4wVckC0V3ncG4bnpeCtrD9ubK/PfVn
4GCFflpbMQcMWnnXWrlxtAoYQQnat/ECW5vABUM/K7p8cludOpMmglcq+2RjCxdY
WTWm4fWHpGXVW3jizWwl
=PHFx
-----END PGP SIGNATURE-----

--wQkw7DhpL9hyPo7K--

--===============0862457075214822656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0862457075214822656==--
