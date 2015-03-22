From: Mark Brown <broonie@kernel.org>
Subject: Re: simplify simple-card
Date: Sun, 22 Mar 2015 18:45:29 +0000
Message-ID: <20150322184529.GF6643@sirena.org.uk>
References: <87fva68ckb.wl%kuninori.morimoto.gx@renesas.com>
 <20150217043205.GS9110@finisterre.sirena.org.uk>
 <87oaotrtxz.wl%kuninori.morimoto.gx@renesas.com>
 <20150217161408.GX9110@finisterre.sirena.org.uk>
 <87ioexo2sa.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0941869389367070810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F95B264F8D
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:01:14 +0100 (CET)
In-Reply-To: <87ioexo2sa.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============0941869389367070810==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WbqItKNU/G8FVTDf"
Content-Disposition: inline


--WbqItKNU/G8FVTDf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 20, 2015 at 12:15:23AM +0000, Kuninori Morimoto wrote:

> Can I create it in sound/soc/generic,
> or should I create it in /sound/soc/sh/rcar ?
> "rate-controllable-audio-card"
> What do you think about this name ?

Putting it in rcar is probably best for now.

--WbqItKNU/G8FVTDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDw3IAAoJECTWi3JdVIfQXvUIAIUb/7dDQbxn6eLQLTQRuFdw
xdaVuKv/es5LDFLgIU7hHGVGKDHRTFqd3ePLU66jx0uLHBjn5m6UPdYJY5Me4kRd
UJdxYgbgAW5weY5hW4TFSBRY89BaXJQCKZqqd5DxJCx52e4O2E1rmG9az8VLfA88
1uPwV1+1LBXoQwROH+293WkvwGHGGdQ3gKF4h377nLNm3G8/D1ZumoZDQ+RRwM4v
5q4C8lOiIVhQXwPUARnXx4kNhFdeXCr6LOYfdQl1jyJZrZrcSOpwV3Ex8Grm8a/e
h62tEKE/+R1MtpPK2SvIMnNfID1qG4pjyF+zTX9El19uuRNUXX5a1hnnlSS+l/Q=
=uzTn
-----END PGP SIGNATURE-----

--WbqItKNU/G8FVTDf--

--===============0941869389367070810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0941869389367070810==--
