From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 079/102] ASoC: tlv320dac33: Use
	SOC_ENUM_SINGLE_*_DECL()
Date: Sun, 23 Feb 2014 12:06:14 +0900
Message-ID: <20140223030614.GT25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-52-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8470473659509154462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C2DD261606
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 06:08:18 +0100 (CET)
In-Reply-To: <1392723517-12772-52-git-send-email-tiwai@suse.de>
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


--===============8470473659509154462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qAYG3HKTbif+kJGg"
Content-Disposition: inline


--qAYG3HKTbif+kJGg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:35PM +0100, Takashi Iwai wrote:
> Just replace with the helper macros.  No functional change at all.

Applied, thanks.

--qAYG3HKTbif+kJGg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWWjAAoJELSic+t+oim9xvoP/3IqBp6wOth0V6701VkefJ2S
k3sW2nY7c0lrBNgX3k/Wd1/Bu8WfXc4pSPg9ww4lgd9o1cuIJhSybLjyoKSEcVG+
0aCD3p5ZixmDbZXgDgWSWbYVgaZi8L+AM/zk6uLb9Hm46nPv8R3Krh/mjpTQgy0O
hjZgEob2og3AhahnFdhbHH2TBCQIslKpb+1J3z648AvvJhKX9qju1zYFe1s48pl0
2+H1IdxjaJuBh78gvWsOpkh+gwVU+gHETp7cUVOywFQJx4ViAwlDDHKn5e+YnMeD
gsDxTPO8EnYQG85CJrAoMd+EQO/3AKCUOwMuWnTb8Kain1xI8D8A/JmHHYUtz/RK
2le0ReDef8b+HNJU+5RKVAzziB0bNgY4W+J4ikGbhX1rzJGxJd6cAXgsbB9XPh+8
1PeNd5p7zjurVR8mVWp9mvHNH/N1GaFQ7BEWSnR2Rv+j3jIotRM+Z6jFHTODm1Su
8992Z6lVvc7yyua4nRIOPQWxdpOx29RQUcF4+ivsanzoTNlXBBvp4VmXjEDRKPOR
f3U7Vngfplz3mx+nVALjbukdppgRHGNwhH7bQLEsSwul/QII2AJdg82Fgo3XfUSN
K4oay2T9O8jRGxMJw9yrjyD5p+GzlIOMYRXjKTvE0A+BT39UiIOaSq6jmwHOQh3z
FQbyjv+n0SzcktiXEJES
=LuEA
-----END PGP SIGNATURE-----

--qAYG3HKTbif+kJGg--

--===============8470473659509154462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8470473659509154462==--
