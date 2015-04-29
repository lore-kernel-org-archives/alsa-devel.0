From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: add i2s asrc clk src
	selection
Date: Wed, 29 Apr 2015 12:20:58 +0100
Message-ID: <20150429112058.GJ22845@sirena.org.uk>
References: <1430191660-2959-1-git-send-email-bardliao@realtek.com>
 <1430191660-2959-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7600834862731950090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0B03260565
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 13:21:03 +0200 (CEST)
In-Reply-To: <1430191660-2959-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7600834862731950090==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l6xxLaA8i41Ex9Hi"
Content-Disposition: inline


--l6xxLaA8i41Ex9Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 11:27:40AM +0800, Bard Liao wrote:
> The ASRC source of i2s are also configurable. We add the selection
> in the existing rt5677_sel_asrc_clk_src API.

Applied, thanks.

--l6xxLaA8i41Ex9Hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQL6ZAAoJECTWi3JdVIfQiTkH+wRcAOnkL3+34uniLbhjfvVt
0C2E5Kc3EAp8/0z4vrc0wIZz6Vt9gpQFOLoCA+A2znbKenRu2/Lmz7P2yr7WENuI
lx+FDY05VU8YFfOX1RJ1hGNYBFGGZQLq8yFKtyV2DVXmymvmFS+/Dwe4FvFj+w8U
zHrSxtpf9ciL4fGiTlGfqsAHErsta5bYyny/ij7RPhZ+qLbXSXtxVGoeHHhXRdlQ
W+owyIv0AWbOXS0KNr7zhZteiER6aBo3w8P/WWgRXMgkROkDcPxqWr3DAOXLxEob
BrF2GklWa9zCYkRVlAoGHhHCjIiTTTzlE6rWbh7HBoaoqqwzRa0mCWLbeumEj6g=
=oXcA
-----END PGP SIGNATURE-----

--l6xxLaA8i41Ex9Hi--

--===============7600834862731950090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7600834862731950090==--
