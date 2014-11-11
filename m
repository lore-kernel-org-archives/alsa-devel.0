From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: remove unused
	rt5645_clk_sel_put
Date: Tue, 11 Nov 2014 12:16:00 +0000
Message-ID: <20141111121600.GV3815@sirena.org.uk>
References: <1415676688-22528-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5699788359321619151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D9E265054
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 13:17:32 +0100 (CET)
In-Reply-To: <1415676688-22528-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5699788359321619151==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjVLUQoZNzLrdBRF"
Content-Disposition: inline


--wjVLUQoZNzLrdBRF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 11:31:28AM +0800, Bard Liao wrote:
> Remove rt5645_clk_sel_put function since it is never used.

Applied, thanks.

--wjVLUQoZNzLrdBRF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYf3/AAoJECTWi3JdVIfQfJkH/iyepEFzwoNbz3RsJ9suxLYi
NB6BTnBo+mWNKLYujcAtqPMMtUM/2X8PdBaCKFyg/5xIMcB2iqDe6AlVCCnzaKTq
OdywJlqsv7cHGxEUZ8mpPvFujyggYqWxo//AqsJhffBAhmFbk/86C0PgB9yKWdHI
Tm2HZCzErXC+raasT7i5Odvsg/PSfiOjjdcxvUKx7o/k3dBBMp1GEY6hE1H61GuZ
O9nLUITHkZb+DhWGPVYIjLQIl2SYrA0b+avwjw9/lnqaMxe22vNfkdft2Uf7im6M
maVbNiqfHgO4iCsrpOVlHBzAMWWFzIHhU+oI1JxRTtyrA6jPl4xTRx9i141P5xA=
=uK5b
-----END PGP SIGNATURE-----

--wjVLUQoZNzLrdBRF--

--===============5699788359321619151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5699788359321619151==--
