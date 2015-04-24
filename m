From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: add register patch for PLL
Date: Fri, 24 Apr 2015 11:07:12 +0100
Message-ID: <20150424100712.GK22845@sirena.org.uk>
References: <1429859969-25258-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3652697028811788728=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE0C5260555
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:07:22 +0200 (CEST)
In-Reply-To: <1429859969-25258-1-git-send-email-bardliao@realtek.com>
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


--===============3652697028811788728==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+vvLrYJBRPXjEjJt"
Content-Disposition: inline


--+vvLrYJBRPXjEjJt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2015 at 03:19:29PM +0800, Bard Liao wrote:
> The PLL output will be unstable in some cases. We can fix it by
> setting some registers.

Applied, thanks.

--+vvLrYJBRPXjEjJt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOhXPAAoJECTWi3JdVIfQl+8H/ikiPvzEI3zAeeMb5StYlcn/
b83Gf+w38N7wViK7bgVZlKBaMj/GN0RytXd37zFQl+zYhob77xo/b29Ec/O+rgXk
BWgmrUnk4Rm+SaFveAFHbcaGDvDww/TBZHd2zWYLtCbIt3QjXDBgAuD7jlMYATLq
2kOymGQylIcucw5QUeA7pFWak6WPpPJ07w5LbaypVkmexqWEQvqrprlDif1LGp8q
GKwxitmABFHi9ug1wA1RS3JspRCWHHzLAWYUoNp+0CyGqq5TxRc48d53HU8ZeIUp
qdXK6AkMBOoDR7Ie7GrgBmPZlJgRPgkLMwUifl/o9MJf0247nGzEBfCqEVBVVbY=
=kdp8
-----END PGP SIGNATURE-----

--+vvLrYJBRPXjEjJt--

--===============3652697028811788728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3652697028811788728==--
