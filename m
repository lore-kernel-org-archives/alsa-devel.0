From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: rt5640: Rename the function of
	clock checking
Date: Fri, 28 Mar 2014 12:53:08 +0000
Message-ID: <20140328125308.GK30768@sirena.org.uk>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
 <1396009710-21324-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0940006038620641529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 151742654C1
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:53:20 +0100 (CET)
In-Reply-To: <1396009710-21324-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0940006038620641529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="seGp1e/yLldw2teC"
Content-Disposition: inline


--seGp1e/yLldw2teC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 08:28:26PM +0800, Oder Chiou wrote:
> In order to identify clearly, the patch renames the function
> "check_sysclk1_source" to "is_sys_clk_from_pll".

Applied, thanks.

--seGp1e/yLldw2teC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNXCwAAoJELSic+t+oim9g+8P+wcl5ikw9kHj1oR9/AltjWEy
fhaJxTRCW0A5xD7dnM9/Z5sDBp8qXaGRlkqo71A55/4eVuOmhuIfbH59UJO2pHSd
YPik7vGM7NOjF1zMh/92+UfaUrMMhJIfL0ByzR/a10GBt2hhw8sYUszQPiXFmNxl
wJ6Y79WEnJOyzOGcbA4XtnHBIuq4qJ8HLd5gJKtTLuCRVkqc7eroNzPHv/b4jWhF
MHnsMzJlqBFFvh1MQzE1lHD6kh7LcmmBe5P+YUCPRYkmqVf98kHzAYy80ebQDspJ
Cv0QU1OG2qz/3YblA/tH38Ow13kktqQfNx06e4XmNNxnKfuLbMKzhETDx5r4NZYN
wowK4YDc7Mj5r4K9Gn3vHaU5aFHngAtu87F+TEfNMwayovTmFTvaaKQS4oc3jwcb
Q6xmsEbekODGSXrAT8b3ABwwJwYcsqwVLwn3fHnzvi1J5Owr7Rru5hS/Tfsfl7hw
1L68fSTL0zSb+HrHO6QbwkpKbzHzgKVUV90BBO0wC+qT7ZQ69eie/TWFMrsCJd+5
M+iEsQOxdjeT76Ucb35t4E8Ugg29e2IIzpXp0Yx6sfck+VDZKygP1083fHUFICgI
njPUjxfMjJbFqejl03ckhSi1g5C16yhWedp68ohcWbmE3WvwxT3EUdqt5jqqy16Z
UH5OUPfLkl8ytl/6fMdX
=sei3
-----END PGP SIGNATURE-----

--seGp1e/yLldw2teC--

--===============0940006038620641529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0940006038620641529==--
