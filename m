From: Mark Brown <broonie@kernel.org>
Subject: Re: UCM profiles taken from Ubuntu
Date: Fri, 10 May 2013 22:00:06 +0100
Message-ID: <20130510210006.GX3200@sirena.org.uk>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
 <s5hobcjt1mo.wl%tiwai@suse.de>
 <1368194214.15763.4.camel@penyagolosa.oskuro.net>
 <1368195741.2463.52.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1819817270752131409=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F0242619EC
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 23:00:23 +0200 (CEST)
In-Reply-To: <1368195741.2463.52.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Luke Yelavich <themuso@ubuntu.com>, Peter Robinson <pbrobinson@gmail.com>, Takashi Iwai <tiwai@suse.de>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============1819817270752131409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hkxLWrKAgbGf75mf"
Content-Disposition: inline


--hkxLWrKAgbGf75mf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 03:22:21PM +0100, Liam Girdwood wrote:
> On Fri, 2013-05-10 at 15:56 +0200, Jordi Mallach wrote:

> > > They could be in a separate repo, but UCM config is coupled with UCM
> > > code, so we may keep in the single repo.

> > It makes sense to me, fwiw.

> Agreed, the initial intention of the separate repo was to do frequent
> releases that would be likely out of sync alsa-lib. But I think
> combining is the best way forward now. Takashi, please feel free to
> remove the other repo (I think it's mostly empty anyway).

Definitely.

--hkxLWrKAgbGf75mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjV/TAAoJELSic+t+oim9URoP/36VUWz9cipKTeW9MefsYGO3
QrvnFI2u0t+2rtsee4PECuaYzssVnn06EP4/Oc9kYCaUK81UGeIUR+t8zB5M++MQ
q5a4XH7n6uIiUitRF7kLSwJJqL6hwWZ6ve89A0rfD4dJTndjdmEtK/h1o2mpHYLF
5eQ4IHYwnFHSR+2E2hdTFtlSjZwB4gHFZ7P6SVUFovEqTfeNFFgB2jxQc2eeZgy0
746yw/eDyAHYap9fL2jpv3Z2KvnQPJs5qP59yAAFvBRl9TZW0xJNqV8HsheXB5zI
RCzBpm5ehu5ZIsrIKWI5BMPx0mKMv8qI6DteL99RvoaA8EU1N6B0EHfl1RYW6PwE
AecWKvKFrsET9M2UJ6DY3jCi+sHymeDdJbkV0/Q5aD10ihnfvx9Xvxs06T/wgi0R
uJP16ArfwAWZtpePhQCslsA7wggwA/G/xUwUBD88pheZvtsxL2OXszTInnC8wrtJ
Iwy0TOBP3KVyvs2k/ri5UcNhHfmFkxTU6mm3UrqT/J6Tp4/DCqnd0WxI1wmS10ge
h+rK9n8edN4C2Wlt7Mf4VBeNJdeJEwIaD8A4/9g2ViZJn45sVjhTb54QZTrnVKlp
MFt3Io5UVXISr8P21pFE+5F8LMpj2Dgl8Z+BBpQOjEK+qyKUoocQHu8kGFTs4v3r
RnSBK39GXFvXxD7wMHT5
=qXNs
-----END PGP SIGNATURE-----

--hkxLWrKAgbGf75mf--

--===============1819817270752131409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1819817270752131409==--
