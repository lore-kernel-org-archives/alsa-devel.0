From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unused variable
Date: Tue, 21 Aug 2012 15:49:23 +0100
Message-ID: <20120821144923.GQ7995@opensource.wolfsonmicro.com>
References: <1345560719-2704-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1760818898479698177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBCDC26600E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:49:23 +0200 (CEST)
In-Reply-To: <1345560719-2704-1-git-send-email-emilgoode@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Emil Goode <emilgoode@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1760818898479698177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 04:51:59PM +0200, Emil Goode wrote:
> This patch removes a unused struct snd_soc_dai.
>=20
> Sparse is warning:
> sound/soc/soc-compress.c:156:22: warning:
> 	unused variable =E2=80=98codec_dai=E2=80=99 [-Wunused-variable]

Already fixed by someone else.

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM5/gAAoJEFJkBDiqVpZ47/wP/1IKjmm6OwzgKKBMa0autnkR
9fvM3YpDvjCe8/7aChpCv1DLciCrZSuLV38/D4za27br9sXT+J/RW/i9Heq8XfY7
tjF3Yfe+RBI+MmOOUkT4EYrewJ5iRlRNPRz84BcUMTklWaG3KRjrykhf2Vd28l+k
RZL5bGxD4y9j2Yzfr8JqShTGMWpClMjYBgQoO+Nu9+v+uWyQk5qf+4nlbc6etmRO
H0Ri9xELwWkXQFflNQFVAxeZrdwf2CEwA7nlhtqLprO+a0KlsEIq7wKaqHu8WJCB
FD2y5r4/OmDSmnVmoIc7p3V2hiRbrY0HGl/rCFFWkIadGbxwr639STqT2FXJ5bMH
4jGC183ZpMVzRnOQFJ17dsL3r0c6Hm9WOXg+XfZAovrARgH0i5ETZJKf7bv3YRp1
k4kMsRU/pMgPHYfvx3o/X+9Uw/jn+ZBo5aV6fg+/TKCiHK7gWaNu9Z5VEWjK1tA3
BE6jNpnuDbdpli+FL+shpM57FTXSTWToK4ZcxBt7ZBBAJ1gnfv+MFG5hhzTAtRIP
dy4b/dW+sldn6bTUn77wUWxlHy5PGeFSf6SPMJCeDcgrCJK9zQ2eXWRbVUbGaOfe
+s5UACoAEJRzp9oTCn7dCMrMcvUo3P/r4paQUFskrgumnLWvzNz1YGtBOWYJbIB2
p4YW7EUxlHQBIpXz7okC
=YkTp
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--

--===============1760818898479698177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1760818898479698177==--
