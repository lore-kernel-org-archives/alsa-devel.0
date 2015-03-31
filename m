From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: fsi: mark several data
	structures as const
Date: Tue, 31 Mar 2015 14:32:16 +0100
Message-ID: <20150331133216.GO2869@sirena.org.uk>
References: <1427658437-23136-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1427658437-23136-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0418394012623971479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54759261B07
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 15:32:21 +0200 (CEST)
In-Reply-To: <1427658437-23136-2-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0418394012623971479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8rkIIWWTWDRRko5N"
Content-Disposition: inline


--8rkIIWWTWDRRko5N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2015 at 09:47:15PM +0200, Uwe Kleine-K=F6nig wrote:
> A driver's platform_device_id, of_device_id and device data should and
> can be const.

This doesn't apply against current code, please check and resend.

--8rkIIWWTWDRRko5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGqHgAAoJECTWi3JdVIfQOugH/13WGjdos+ztsAFtwjFT4sAC
GkuMKj0WEynSkUUK7+SQonzIwpLGUZ/zwOVnT8F8oIx6H23y+R/yfEt0+iVgC6Tj
pDWkBm5q/5ZW6fUM7tiBFaWswgDBiTO2nwdMCp8Djl64RcscEUqmB3L2z/AXrSCK
0qqWpgY4Hl2TxIEvn2NDF2LPdtBjnnMq204kbbQGxiobDhnBvGC/ZiI4GUjOMI5t
tzN7CoVo3+3UgJoPZAueOZrcQ43xiP6zl2jm7PSlKmeUKG+9O9Y/p062kbgI8vsf
6WCW6eQtbLRZSq6JMgDCLRQszAswuRD2Nh92TUFRSoL9tUUgbkkHfwPoJkgb4M8=
=4iJS
-----END PGP SIGNATURE-----

--8rkIIWWTWDRRko5N--

--===============0418394012623971479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0418394012623971479==--
