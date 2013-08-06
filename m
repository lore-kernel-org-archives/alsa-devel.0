From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: twl4030: Remove embedded
 snd_soc_codec structs from private data structs
Date: Tue, 6 Aug 2013 17:42:05 +0100
Message-ID: <20130806164205.GE6427@sirena.org.uk>
References: <1375789171-12098-1-git-send-email-lars@metafoo.de>
 <1375789171-12098-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4510464551349015890=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0773026087E
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 18:42:08 +0200 (CEST)
In-Reply-To: <1375789171-12098-2-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4510464551349015890==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 01:39:30PM +0200, Lars-Peter Clausen wrote:
> It is unused and a leftover of the pre multi-component era.

Applied, thanks.

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSASdZAAoJELSic+t+oim9vi0P/R73gDAzp2+lqPl7BtS6uoA9
szkHd3T5NSaUUwZlX2bRxgM7IFf0rGxBS20lLRpZg00QC8gRieX7Bulm/g+wqF7B
16tlZK55j46uT187s7HkWb8Lrc1AxwnezdLBhfpC0+EO6GjHc6z8KrgyFcg1wkvA
O0Xp/G1ZcxJxxsnhher2O7wGzYKQjy90LYyeI3y1lRCBzMsoZfO8OiVSeM64W4ac
jTE0ZgLQR/qJDtH3wv0CfOeyMGn0euaJg1XvTY9BEGdiEbU0iOeGjD6ai1KE/Dll
iyx/S2LA5m/Wl4bDtyU7q7WzXHYeMTFbMBGbjc5YJz+bPzxAXw4MSyWB0nQ+wJIr
5mjLJcIYeS7D0HrSZAiJx4eE68w2h26ASFQmXDqh0slxhYHWHNIhynT0Ijy2l7n4
wHkacpX3ZgmV2TBTug7u6oxCyP1vndJmGnTt7Cy9cwONHSyC1aW6TvdIpyDbFGqo
vICJj/XXjBEKjUMjBR10HkbrCqwIvHiiCmJvDDdWDPQj7V57WLHfpBqChoOOuLT5
RqL5UQuCBSREcBbGhgx8tNWuvJIs0yZeAiDeJWaoLf1SGXYs1+xSbc5qT5sUv7pG
uRJ/Cbjpn/K1LmUTlXZkbmgGB4CroPSTy4vs12oVeKlqEOg7zBIWRsOym1wAha7R
t2tmGXYe1RKuU4WstiZ3
=z+bT
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--

--===============4510464551349015890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4510464551349015890==--
