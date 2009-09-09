From: Tony Vroon <tony@linx.net>
Subject: Re: alsa-lib 1.0.21a release
Date: Wed, 09 Sep 2009 14:58:58 +0100
Message-ID: <1252504738.3282.4.camel@localhost>
References: <alpine.LNX.2.00.0909091444530.12929@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4984653341171836711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 12C1B103862
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 15:59:55 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0909091444530.12929@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4984653341171836711==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-aFltteFu9Os4Fpd7q2H4"


--=-aFltteFu9Os4Fpd7q2H4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-09-09 at 14:51 +0200, Jaroslav Kysela wrote:
> I made a quick release 1.0.21a of the alsa-lib package to fix=20
> regression for the configuration parsing (makes some device names=20
> unavailable).

Could you stick to numeric versions if possible please. Arbitrary
postfixes like "a" or "b" are hard to express in the versioning scheme
we use on ebuilds.
This could be unique to portage, but I wanted to speak up in case it
affects others as well. 1.0.21.1 may fit your "newer then 1.0.21; but
not quite 1.0.22" needs.

Regards,
Tony V.
UNIX systems administrator
London Internet Exchange
(also a Gentoo developer that touches media-sound ebuilds)

--=-aFltteFu9Os4Fpd7q2H4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEUEABECAAYFAkqntKIACgkQp5vW4rUFj5rPjwCWM0dhTTARBTzboHg/0kERmhX3
VACdGEpJYpZZNnXAY8dznivpZhQk6Eo=
=qp8R
-----END PGP SIGNATURE-----

--=-aFltteFu9Os4Fpd7q2H4--


--===============4984653341171836711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4984653341171836711==--
