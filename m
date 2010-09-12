From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] ASoC: Add HP iPAQ H1940 support
Date: Sun, 12 Sep 2010 15:15:23 +0300
Message-ID: <201009121515.28492.anarsoul@gmail.com>
References: <1284288909-5961-1-git-send-email-anarsoul@gmail.com>
	<AANLkTinSr6f8ikds6rM-yUUpaA6M5DzA7Wk4PjRN6=uC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2294988025522317599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 79098246ED
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Sep 2010 14:16:20 +0200 (CEST)
Received: by eye27 with SMTP id 27so1390821eye.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Sep 2010 05:16:20 -0700 (PDT)
In-Reply-To: <AANLkTinSr6f8ikds6rM-yUUpaA6M5DzA7Wk4PjRN6=uC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============2294988025522317599==
Content-Type: multipart/signed;
  boundary="nextPart1798741.p8u28LHzlL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1798741.p8u28LHzlL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
12 =D1=81=D0=B5=D0=BD=D1=82=D1=8F=D0=B1=D1=80=D1=8F 2010 15:14:27 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Jassi Brar =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> On Sun, Sep 12, 2010 at 7:55 PM, Vasily Khoruzhick <anarsoul@gmail.com>=20
wrote:
> > This patch depends on gpiolib support for h1940 latch access,
> > here's link to patch in ml archive:
> >=20
> > http://www.spinics.net/lists/arm-kernel/msg98042.html
> >=20
> > I hope Ben will find some time to merge it into his tree
> > before 2.6.37 merge window :)
>=20
> Do you want this too to go into changelog ? ;)

Nope, will send v2 with cover soon

--nextPart1798741.p8u28LHzlL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyMxGAACgkQRM6pQpltKE6vxgCfesE6JkKO8lrjvjpgXnAhCRI9
TQEAoJP22FXUajOkdhePqorK0V1Veoc3
=iU3W
-----END PGP SIGNATURE-----

--nextPart1798741.p8u28LHzlL--

--===============2294988025522317599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2294988025522317599==--
