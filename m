From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 039/102] ASoC: mc13783: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:20:48 +0900
Message-ID: <20140223022047.GE25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-12-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5403253499367274202=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D813264F29
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:59 +0100 (CET)
In-Reply-To: <1392723517-12772-12-git-send-email-tiwai@suse.de>
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


--===============5403253499367274202==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8M+gQFKLhTGBxzRu"
Content-Disposition: inline


--8M+gQFKLhTGBxzRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:55PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--8M+gQFKLhTGBxzRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVr8AAoJELSic+t+oim91xoP/igQgc4XiMnVSAwB57J4jXD5
u/E5ajxIR9uFEDdF8HZkzv1XKcZwEHRGqHUWjv0BoeU82lpU+7TjV94yeSrcjPGh
RfY/dTbHnhclPeU5AZ13vIEgb0wQyCm/LxM8KlNSlWukPxegJqabcD6F5iOjNYAI
Msxxg29Fw5fKIeH5BySkuoV/Pz8IspeS+EXeUQ+53IPT03akUOwWKkcYidZ3TDiF
Z3iijAkVcopIFXNB80dsLBYPbF3jebGGWBdggjrgnZzZ1KnTKYVKTn05iiAj/8Wn
5u5qTEu8OA4YB6cG2GNmnBCnRpVwZcQgAZqercA1bb7wbQnmiB1fbwSOESe/gYni
ONE+8pyxTxcQus/URMqst7nIwNHRqqEfKm+YSBg9hf8Jq9+tDufsZ12FH0n+P6BW
KpSCuzJ81v+9mqA8+fIbO2h0XFNpGF+5PM0Dbu/go5v7eugF2gPbK17Kn8F0BUnP
J+XCs3IVd71b8vtMwsxi5+w3QuAIt51phuJuNGFJ3kqS2RH3U4cqur7wIXcDJdbQ
CF8R39qibbjZUn/nQWkL7ztfq6xywwy+lJspvGQh2XmlOFpXXslcUarWv3OQE4uB
DDNYeg3mCaA0F0eXuK1kMnMcvBS27wa7Gy//KDhyG2yJUYUkd8ZGKT+k1HEo/FTF
KipSmb4RVoJRsx1AmcJI
=BgRF
-----END PGP SIGNATURE-----

--8M+gQFKLhTGBxzRu--

--===============5403253499367274202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5403253499367274202==--
