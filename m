From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: add Renesas R-Car Generation
 feature
Date: Mon, 8 Jul 2013 12:29:37 +0100
Message-ID: <20130708112937.GS27646@sirena.org.uk>
References: <87a9m6ixgp.wl%kuninori.morimoto.gx@renesas.com>
 <8761wuixf1.wl%kuninori.morimoto.gx@renesas.com>
 <20130703111034.GI27646@sirena.org.uk>
 <87bo6j1706.wl%kuninori.morimoto.gx@renesas.com>
 <20130704092636.GM27646@sirena.org.uk>
 <87y59lx1ci.wl%kuninori.morimoto.gx@renesas.com>
 <20130705093404.GO27646@sirena.org.uk>
 <87pputim6o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1239812955430199699=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 68309265336
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 13:29:52 +0200 (CEST)
In-Reply-To: <87pputim6o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1239812955430199699==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4WhozBcz+A68xwf9"
Content-Disposition: inline


--4WhozBcz+A68xwf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 07, 2013 at 11:46:11PM -0700, Kuninori Morimoto wrote:

> Can you allow me to replace it in next (?) kernel version,
> or should I do it on v2 patch ?
> (using regmap needs big exchange...)

Should be fine, it was just a question since the code you had looked
very much like regmap.  Ultimately if you've got something that looks
too much like standard code that's the issue.

--4WhozBcz+A68xwf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2qKeAAoJELSic+t+oim9H6sP/36P4UPad4zrWd7M5NjaP7Fm
6KdqiUHR77x0g/wwgeBvNrUZUdcs16tg9jTXD8ScHszJCoPdYb1ptuhKncSnaemj
1Z8RD4gBy+YdAD5/MFAxIL8ko++yUWOc0ZO2vVL5ZSUsfy5R0GDxa0SYfyYbksXE
TELNf5ClB7NUNb5BUbfG6oq7N47YEHlpeOV8xdZisA0sKwJQ/3Gpv1RfqQcd/ipr
TEdGKWlX3pggfexGk8xmrRtT72rt19yMm4KJTBDGQMVJZFv580RIbZdmO5INbw0J
SrmXMk+ef/vNbOiT9QzySOW3u8KwDo5wwGdWRu0SOnnQ3KGKVPVj5LBuBfmWWHtc
M1hsvqLkrx8iR1xVNPuOEWS2bc5gwUMRouWu/Pp0ORQEI+8JLumAhk/bz6WauYIs
JRTP1vvB4urIjitcY5YF7ji2hZUFQsx33h19+bSbfnUXJo3D0Ea2dWtgxnp0Fa0+
RDbdrxRRtD6ABDy46MFczrOjxyg9eNdCeuL7Hnss58UQ30vKSWa/0RhrqHBpDqod
mOuMwCqpMyKDjcrCwQuA00oAaxkdSQFZZgoAfOtXoRsiRf0deqY2yz8Uu/+Ha6t0
aG8qoTBwnLj/Zld5qST0WXrCjTfGfabACKdUgxuQnVgXQtKDEpMv83CQxw8ihQo5
91C1eEleFxm58FaDXdnI
=jWeY
-----END PGP SIGNATURE-----

--4WhozBcz+A68xwf9--

--===============1239812955430199699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1239812955430199699==--
