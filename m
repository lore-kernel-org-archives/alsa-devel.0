From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: simple-card: add asoc_simple_dai for
	initializing
Date: Mon, 14 Jan 2013 06:56:04 +0900
Message-ID: <20130113215603.GD5041@opensource.wolfsonmicro.com>
References: <87zk0g4k8s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1085658480883234723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C419226512D
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 23:02:51 +0100 (CET)
In-Reply-To: <87zk0g4k8s.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1085658480883234723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 04:49:11PM -0800, Kuninori Morimoto wrote:
> Current simple-card driver calls asoc_simple_card_dai_init()
> if platform had a asoc_simple_card_dai_init pointer.

Applied, thanks.

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8y1oAAoJELSic+t+oim9CuoQAJDS3IS5KW0rd41oy2KJjHUg
zrsmKh0uuMVuzBFANPq97mK9ht/2CKmIpfG80bQ60P2angyFZVupyT8EXoJHGMjP
Vpd2cFgDljtJE5NZi/wIXNVW1gZ9hvxlbAKij6pJz22uO5Hsz4dIojXqlGGZN0x5
4VUAHJaEo4mZjDNgsrFNDVTh/itvDPlABV7ApJSJlU9XUuRCOwlJdW50VF909cTV
gMthanW7E1AEI44Cwc6QmwxDTgRFSMwbAAST6Ukh73Fp08/XumEBUdKZDUiF5XF1
cfMbEF6+h1vYR7sUvsS93+Yo9b8WZdmRg5y8RBtoEAY8hurWBI+56IO4zmf+7i/e
05uVnHYwxMv63a7QnXTHZ23PNS5Nbx8cwHoOY4siG3SBpbfXcQ4JHIqBQkwZx0WX
CrtDpyxsrHkrhlSX/ouMqc4M3Ipqk3ejw/rx9+n1ejFolSEwwbdbIW0altR7++w8
K1ir0FyzZZ7kcxaSYxGPEQ0SjElFC43JEfYDQdfL6mPRqSAqouVkJaqJ2/fQzhBh
uwL+qb/g3oFa0QmJ+wqPgVzUmJumFnkNRlp274WAY4wisu2h0ZVOubUP5wlkt1W7
1savOAvVNa0tNvEwCIczBheLljCumUZkIRMt3v7elpuFPO3umkyyxo+Fit0lGEnO
OuA/7MLgQOFdAnUnnya7
=3R1x
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--

--===============1085658480883234723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1085658480883234723==--
