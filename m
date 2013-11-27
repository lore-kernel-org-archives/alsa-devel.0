From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/18] ASoC: wm8985: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:20:47 +0000
Message-ID: <20131127182047.GC14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-16-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6248412500709187853=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 94D9B2651AA
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:20:49 +0100 (CET)
In-Reply-To: <1385044736-14911-16-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6248412500709187853==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="057lbVXqAl+YS+vi"
Content-Disposition: inline


--057lbVXqAl+YS+vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:52PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--057lbVXqAl+YS+vi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljf8AAoJELSic+t+oim9fuoP/37FXyJOgX55wSv27lCsLpHl
5EzbpbXjLzhg1x7bfTPB3Nv8P/XZkFuYN91N44w685Ov3uuLK+vB64ynohoYy3Jm
5jSO5aObM5uoaIv8rbrvF9BCL59O9q8ND83T+ZQgMoem4qwFDDxglq6SULmc4pnU
7Fs3mDZNq8u4mRyeWVsn3Tbr3F22VKXbcDqKMI/pxArL4cx6+F9Aov+EdaNy69YX
6WtYqqOvXlq9H/j1GExU4APJ++dCHslEXm0menP/bQnrGnNph4LQ9N4/tHkbzMcG
lD8o5AqCIn/fkpxIFJFhQuAluU3IDaF7CGU6htCkOdTGk8AIO/4x0+OFLlef81sw
G1sH5RNTamgA9hLq4yZzoR4QjrIzjehjI0JiLWPfMxw5+Jih5af05k2lYlu3YAk0
pQGhfrqCxviwZo54x+YCKlejElcaynhIg2cRZtGmRm437NaveCLVHbvVNas3/YPj
iPb95o5wGOsu1XApcogi/iOxmKtE8mAvy0LRrsOluaDFDZPRYX9Jwjk0ojwCR+x/
GlWCkErhafsEmvU5LbX7vn3zSrTjI2MeujSjmK6892wvcgHA31RBmXV+cP3CFNET
di92xBfSE7+1eAKrqUsjDv3iPS53veRjudQXmyZ3xcGUdwwt5YqiUGxeD5yVh7+N
agYLcdNhg7UMlAK0ylWR
=1oZM
-----END PGP SIGNATURE-----

--057lbVXqAl+YS+vi--

--===============6248412500709187853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6248412500709187853==--
