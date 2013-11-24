From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][RFC] ASoC: rcar: select REGMAP
Date: Sun, 24 Nov 2013 13:42:15 +0000
Message-ID: <20131124134215.GV14725@sirena.org.uk>
References: <87txfofv47.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3292783452525599432=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7360E261676
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:42:19 +0100 (CET)
In-Reply-To: <87txfofv47.wl%kuninori.morimoto.gx@renesas.com>
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


--===============3292783452525599432==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VgNP6wxEowREGVu+"
Content-Disposition: inline


--VgNP6wxEowREGVu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 12:56:28AM -0800, Kuninori Morimoto wrote:
> 55e5b6fd5af04b6d8b0ac6635edf49476ff298ba
> (ASoC: rsnd: use regmap instead of original register mapping method)
> support regmap/regmap_field on Renesas sound driver.
> It needs CONFIG_REGMAP now.

Applied, thanks.

--VgNP6wxEowREGVu+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkgI0AAoJELSic+t+oim9nlEP/36CR3RtFhcNYv1PmSdg7BA0
Tn241+kF+zoeBRPqjaoHc4pPjeWlE684/o9K96RBhFIRE7VVyrqoj/fwUz8ovufs
Jz0Y90NCy5QsBvSDWtThbVhTfWftIQbc1Q5e+O3TXPGFIJDJpQm9thd3l6ik3Lrq
nIEpb4Sd4knclyG5Yo9zRQDHYpCotqT/8PnHVER+BdLeUgz3skubIbOP/38W2V8b
7nXH1RUMkqnoZiwWgtTkMZKUWwPszTGbGmWL89xsATMmh+PkiWPJgPr5v3XmVwEm
FLt3Z3j7xSi1PhOzFbLbLDN+uwH/XZ13tufc6p63nkI4qRAVPyNngJb9DQYJtm1R
/m1sIpXzQ84tgXSfQBbMp7tiGl4erDWWtF6ktF2mFYFLOKlxzJln7x2hHIJKQCeF
KsZhbEolpVWUGDQUK6Vw9cV+mhYzwc6RsUV68dr6ylmcKd7Y4poR4UwG9qVLzlrr
lwZS7/ysEtVyiNb0EcSmLRAdIJ0YBPmPrqZqNmZLhWCUBe84ft+okuBMOShD4ty3
HF/TlYcK/rhpRsaOJe4UYYmSlmjAlfRiK3r/KtuaIPqkqMLSc84YL4AFoIlBEnmb
JMBDqXZfYFRDrEQrw7NLgdQNMsAgwVL3ecGaaLgoXakceIGiNz19Sn0W/B71j3Sn
pKp///9vdEJO9kBryFNt
=Epyq
-----END PGP SIGNATURE-----

--VgNP6wxEowREGVu+--

--===============3292783452525599432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3292783452525599432==--
