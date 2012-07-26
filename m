From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Thu, 26 Jul 2012 13:00:46 +0100
Message-ID: <20120726120046.GH3099@opensource.wolfsonmicro.com>
References: <1343221751-29863-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6245475064791398815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BCEB265E85
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 14:00:45 +0200 (CEST)
In-Reply-To: <1343221751-29863-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6245475064791398815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h2J70RNbM0WNXG3M"
Content-Disposition: inline


--h2J70RNbM0WNXG3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 25, 2012 at 04:09:11PM +0300, Peter Ujfalusi wrote:
> When the board boots with device tree the driver will receive the name of the
> card, DAPM routing map, phandle for the audio components described in the dts
> file, mclk speed, and the possibility of detecting the jack detection.

Applied, thanks (for 3.7).

--h2J70RNbM0WNXG3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQETFnAAoJEBus8iNuMP3dc70P/3Sj1yk/PR+jQWlqv6+Dp+bg
drYjU3riCLRzBq/PoKQqf3MBYKt6hrJd54S/ecM8SLVkGf6sPyWiyz3ymQQPq7pD
hfGOBAT4YL4EWAZzf7+X6zL74iTmOaKm/D1nnjJgiWbw9fwaXQAakJtC07CbjC9O
I7bOMXLpJWxYD+VLWjratDDracPQd1GbcOwSmSlgubQVgkG+8NWjJtnI2nFzYBKB
LzWJ39qOaCW45hB2xEsakgsZUNIr+aZB7Ku9wOqKK0phvHh7ZI1VBj7Ybcdj0YnZ
2F8UWIXMApZWUKaROhntb8rlDB7oIbHkGB9tGQiGEaRPB5973MDWLTKcxd0BizX3
D6RanlLQEp23v/GFxniowaNjy4MyuwG+w1Ic2tNnSxoaiBzvbre0ByExraI696Wg
r1c+r1cUR0UpkvwaLY37a8d1fuZH+eizdrCpLrlil46IXUbKoa2vHYnq5lTIT8wh
4a38jMWf5q8YiV+o99psyMDdGApDYpzCWDQ6GkgiyexeNtUZvBbJcTTkrNXlupwQ
aBCSFrg7qCiQ5Leno5bidjV9HDnSuwTTHoHM/BHx1O3+eYzJkmIP6g8UeqSgXVXu
UEnVplJ/vv5z74SO6Z8Nd6Wo+CnXw1MChSBnltz+nF8Pp6s0ybqGU8mZ38B62+Sf
xmim6ySwgXuYJGHNu6D9
=Suk5
-----END PGP SIGNATURE-----

--h2J70RNbM0WNXG3M--

--===============6245475064791398815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6245475064791398815==--
