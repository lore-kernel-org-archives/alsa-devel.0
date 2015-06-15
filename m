From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: constification patches
Date: Mon, 15 Jun 2015 20:17:31 +0100
Message-ID: <20150615191731.GD18309@sirena.org.uk>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
 <20150615103238.GI18309@sirena.org.uk>
 <CA+rthh9Lbqwmc4o9Qbx4gZz-OSmuCY275YXdkmumwQxugkENtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6387743690813430577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 579C6260417
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 21:17:45 +0200 (CEST)
In-Reply-To: <CA+rthh9Lbqwmc4o9Qbx4gZz-OSmuCY275YXdkmumwQxugkENtQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============6387743690813430577==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpbaaqEfWJan1gxl"
Content-Disposition: inline


--lpbaaqEfWJan1gxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 07:59:30PM +0200, Mathias Krause wrote:

> Sorry, actually I tried to. It's what get_maintainer.pl told me but I
> tried to trim down the list because of the simpleness of the patches.
> I omitted LKML to avoid cross-posting. I messed up patches 2 and 3,
> admitted. But what else was wrong?

I can't remember now, perhaps it was just the second Realtek patch.
Like I say you shouldn't treat get_maintainer.pl as reliable (it can be
a good start but without --git it often misses people and with --git it
gets way too many false positives).

--lpbaaqEfWJan1gxl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfyTKAAoJECTWi3JdVIfQO7MH+wSu+5MBUa/fJu2QlDps8LQ9
D37lkWYK3MJDgwEZk+FWEkqRw584yReETPWD70h6QvR8oUnTB+UfmERcsDx27dcX
QnQQ5UOcG3n14ITFrs1lUlo/68YYApu2T1lQRwXYEzv8xRHT+Pur7HfcfyPnOPVn
dlFQr9b/5EEBtUIT2Y5HoCxMsA2wCbm0PQyQmIO7wW6oxKGXPDZMLv18l+fOYmF5
vo3sDGSGzilxPm9SfkquXjHq5zRshuDWTTz/93R4QQfRKIKP4HjJnl3h8eyHgpZw
OMRw5Fwlh4uoWvfFEeWmEL/YAemmjVbZz6/abSc0UJQ7Q2Y+I0gdzLXguiGFyYU=
=Qiit
-----END PGP SIGNATURE-----

--lpbaaqEfWJan1gxl--

--===============6387743690813430577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6387743690813430577==--
