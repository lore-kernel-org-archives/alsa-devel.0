From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] Removed deprecated ENUM/MUX macros
Date: Mon, 14 Apr 2014 20:40:27 +0100
Message-ID: <20140414194027.GM25182@sirena.org.uk>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3922385490421790714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 571F926575F
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:40:51 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org


--===============3922385490421790714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 09:30:55PM +0200, Lars-Peter Clausen wrote:
> Hi,
>=20
> This is a follow-up to the enum consolidation series. It updates all user=
s of
> the now redundant and deprecated macros and once that is done removes the
> macros.

Applied all, thanks.

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTDmoAAoJELSic+t+oim9qrQP/2MxPCDtJcQ/SUj1FrN3fKRK
4dP52FfRWlUQuVGJEthhGZN6Ga+tR9vwslJIM1+0D1WKA0ie2Dqr1NDzZEX+bspT
jLojzRfzw18f6emXZW4uWXdcY5ZzkIDWjGcSO5Mi9d++9ScQgtAP4J7UeHhTzja/
r590aY2lGM/ezy7vTOyXZgKRtMMlefe/lsCV+CpCS/9aVk/YhoGms0m1WwGw0iM8
vlHzTsehPke6i/goMzxubW49+ZOiuLK4XuOyuzyOBuxy+6eedyTA3FYUx2d9EpIp
dt1ar/qyN+Zfok3ui90zxfuDXBC8poGb3lQgcRGJ+Xkkg2cjYDoxMVW+37DNNka1
STmKC2TrDDK4C6EtSgz/Pzl4ppPjx5Gty7/OnNe2JHLe9HLkROSDd4LyxjU/YcVb
zHv6OgFVPFdMh2ER8c3/KByEJttJCgu2NQO5qwCuLL8xCTCYwslQ8lD3bLKb8ci/
oX7Gwkw0LhJ4R6OVtEBoscJIbe68F8Gi44slznbqU5poPU65iGjYqJ92Waf54xhs
njURCOsqYdFe8yxmeiHFrFf7hn4snu4g/O5DZK3blFK6euKIASyXtLRvzBKjHL26
7ohQCdETbRo86e8+iT28NaFWtdTcoOeNBvivWikNPbNk42SeDmTS06Q9KxAJUL8q
7K8cK6FHpGPICm4Oah56
=U4IT
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--

--===============3922385490421790714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3922385490421790714==--
