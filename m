From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: ux500: Fix sparse non static
	symbol warning
Date: Wed, 8 Jan 2014 12:22:37 +0000
Message-ID: <20140108122237.GV31886@sirena.org.uk>
References: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8503559090535983979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0158626513F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 13:22:56 +0100 (CET)
In-Reply-To: <CAPgLHd9fB+tA=uAfE2s5i2ygySUyqG=DNpe7RQFNOv-kBxjL2g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, fabio.baltieri@linaro.org, linus.walleij@linaro.org, lgirdwood@gmail.com, yongjun_wei@trendmicro.com.cn, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8503559090535983979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/iItXaCv0tvGsnvo"
Content-Disposition: inline


--/iItXaCv0tvGsnvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 06:13:35PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fixes the following sparse warning:

Applied, thanks.

--/iItXaCv0tvGsnvo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUMJAAoJELSic+t+oim9u3cQAI1vxXzf/luz5b1buL2Ku7ub
LYUIhVSd3siBEWDClH6RmFC8gYmF3gFYSZZHiPAxJ2zPQKD2UxsGw1GODzwnOC6T
orEa4v9AS6vhuHfs4ZBNqKjNQLiQ7PcOOtOujt9pnQOl3t0Ax3MzVqIdfSi8rCYU
ZpbqffJMHyNQG2m2kEa8jpodYQ91RBJ9ERkQBOFfVZZHyWoSsBzc5HwC98uv5DNk
Slh5HAHgPujBWerPgTVGhk4lIYlcujaD5BhjWyqkHpj22k1XN0mf1fl3k7Gx+t7s
E6YbRkvoReUXyChixU7+pHqAwVhbok+a/cVPXDAM+MNy1eS9w4toux8qA9Rpz4mr
wQpDh5TD4sD+QNPD5NCPwOmIDJO0ovdXc7lAjQMQ88myIY8YuE+8Tamqe3vie6B8
n20FMfZjRlrBotH8oHdB/A+nRv0eQ2Bi5yMYWIK8Iv6PoMNVG8pS3dkL+X5QeaNp
0780e0jbl2ncYtczybx+pUxP6tKpJfd50lDirJL2sOHNG9omyGC3fL7xE2hLaKNK
x0QrvTtmNwZvnekOgY+p7kNMhRtVjct0Wz+YQHT59qg7u3+sEvXp7ileKOUPxSui
8svy6iVUydtpaNEd4L8+vS9JZWaDEdzBUcMPl/H8Q/eGEkYwhhQ7m3QhGNlE7uBY
fqJqOtJeplYsgnb+MJwZ
=SwHJ
-----END PGP SIGNATURE-----

--/iItXaCv0tvGsnvo--

--===============8503559090535983979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8503559090535983979==--
