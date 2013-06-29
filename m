From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoc: ac97: fix multi-platform build
	failures
Date: Sat, 29 Jun 2013 13:24:58 +0100
Message-ID: <20130629122458.GN27646@sirena.org.uk>
References: <1372443469-20191-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4890897747718113458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D42D261A5D
 for <alsa-devel@alsa-project.org>; Sat, 29 Jun 2013 14:25:02 +0200 (CEST)
In-Reply-To: <1372443469-20191-1-git-send-email-khilman@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4890897747718113458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L339ydo2OqXZvxFp"
Content-Disposition: inline


--L339ydo2OqXZvxFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2013 at 11:17:47AM -0700, Kevin Hilman wrote:
> Hi Mark,
>=20
> When building next-20130628, I noticed a few build errors for
> cm_x300_defconfig that were introduced by the new multi-platform AC'97
> support.

Applied both, thanks.

--L339ydo2OqXZvxFp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRztIXAAoJELSic+t+oim9e24P/A5MU7b0rHv80hsXeZ77gk/s
0XuNOAQqMZd/P4xupLR53O7tC9saeWaeYUSLtBw9UZXPp+HVeh1xc4F3iBf9eDjL
x0TvQCAvv3GnjV1HDyN97Pjka+khHZ0n0h+gZEGvIinzLtwz6O8YB/XglUiQMqYB
iUc9+QZotLxdUeC7gSjANxB0v9XMadnfxvVCJJsRJFazCeX/UcKIS1+IuS5VDXTJ
GpONMURRPQ0iuuX0VxXESuIP7BqiXoaJoQ5TbuCI35SfuaYDeTlREkbTWWvqToTD
qwyaUl47K4cZUU7sq25k66JaI2cXyuMVm5fG/ZY5sw8yyOUyiyk1M+DsaI4P350f
cXO39YMvR3OQvs18h3tK8pcYfykcAyDHO41Kp9AYKCE9BQvgpkua5GlxdFLbi2b+
IepNlSZVCL9xMkpYdFy0Y2El+a6TFvc3IZi7+c7mLjWYgiG2rO0I8bqOfnbmS0kv
NWMdHzlHqKX/6OcpLHpTTGrszjib/mZhQqGJxsARNXMuFIiPnXCRQxGw1W5m+diX
jNIjirmRR0z6uJf8CTNa6ew1mS6vEUvz1CuzONiDZE+klRU7E19Zg2HGwqur8txN
C9Wyv5wZJhPVEoE4JxtVv5PiF9GRczayMO5XfRQaI0ieygW6P0OqMSrmwM3XdFfT
mcjyQ9Y+Q59EzpvtCJ+x
=M5hY
-----END PGP SIGNATURE-----

--L339ydo2OqXZvxFp--

--===============4890897747718113458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4890897747718113458==--
