From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Restore idle_bias_off initialization
Date: Tue, 26 Aug 2014 09:15:44 +0100
Message-ID: <20140826081544.GZ17528@sirena.org.uk>
References: <1408887415-7942-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5863695606926318028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3218F261A0A
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 10:16:01 +0200 (CEST)
In-Reply-To: <1408887415-7942-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5863695606926318028==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1P7cyhrem92iCa4o"
Content-Disposition: inline


--1P7cyhrem92iCa4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 24, 2014 at 03:36:55PM +0200, Lars-Peter Clausen wrote:
> This was accidentally lost in commit f1d45cc3ae96 ("ASoC: Consolidate
> platform and CODEC probe/remove").

Applied, thanks.

--1P7cyhrem92iCa4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/EIsAAoJELSic+t+oim99HMP/jH6n/rS+zycSRp76cpW6c7z
50JIfSyD2t5xx0sgqzR/XxLj3V3nmOpW1vdrY0TyAnhMSkfQGAeGznZLRJ9Fn6Jd
jRTGueH1sxofzJ0rpX4JwmjqvG5mFuqe2igWc8qYytckce5937HTe+6KXyZaJWDt
XZHqhxDygsJmh5fWXqMTJbw5Y71PHSsqJoz6lFIDLLXrsYWEsKOO2Tqlfxl9Nyzc
jnGA6q0kyz0YHuGuNZssSZzhDA0p5N2dDc/jQCe7hdVQgaliaHaeRU4dYBjjylHQ
yWWbnVgTdO1SHmHqEEY6vLgBmta2rhwfIWji0RsTOI2ts83QxJfT+SpxKQeNYfrG
ilqnpiP0cCHnCuEUhIGRn8yMAV29y/JXvwI4hd+iYk3YDXvhBJNCxd76mMjXZR8B
quwtQSTcD6fAtQ083kSEcJ6EZ1ytDQAV5fS5ojhzTyqtUXK76utRC4X07k7SPOfa
gPmAdEixHdwQSbDx3biecezKdYziaSt+qP5n+8iPW/1FBDPXUjguBIsWx7aIjFdh
boeLbFH0XAJau8FEDK7wX7cPjPwVm8adTL0zpOUagsrG0fKZahDJ+Vr+iBVNxstk
JdCzKQwb4vbK1ZUOk65Jjt90K7P5DlluIrBGukkiceSIocx06SnZRb1xOcsMtT+9
fO1Z/bbX1FV5bd0My40j
=ERd9
-----END PGP SIGNATURE-----

--1P7cyhrem92iCa4o--

--===============5863695606926318028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5863695606926318028==--
