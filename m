From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: cs42l73: Add Device Tree
	support for CS42L73
Date: Sun, 20 Oct 2013 23:10:34 +0100
Message-ID: <20131020221034.GU2443@sirena.org.uk>
References: <1382124601-3317-1-git-send-email-brian.austin@cirrus.com>
 <20131020173039.GQ2443@sirena.org.uk>
 <096B5FB2-DFF9-4F95-9839-0DFF3090448D@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6058804198833097624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5CF2619E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 00:10:36 +0200 (CEST)
In-Reply-To: <096B5FB2-DFF9-4F95-9839-0DFF3090448D@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6058804198833097624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="97LDRFDfwTH+2c++"
Content-Disposition: inline


--97LDRFDfwTH+2c++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 20, 2013 at 10:00:22PM +0000, Austin, Brian wrote:
> > On Oct 20, 2013, at 12:30, "Mark Brown" <broonie@kernel.org> wrote:

> > Applied, thanks, though this really ought to have been sent to the DT
> > folks.

> Ok, so pretty much when it's device tree related it goes there?

Yes, that's the idea - if it updates the binding documents they should
be in the loop.  Though it's possble that this will get revised during
the various discussions this week I guess.

--97LDRFDfwTH+2c++
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZFTXAAoJELSic+t+oim9ybYP/jrC1n7oPrYPwTa0k+1YmllZ
zVrJtPSUqZ+fXI/lO7TjYmYtZ9G90pkJ5pk5RuxyZ3ZHoVC8UhW9uJI5Rdbs/d+M
eQ9AYyWnIEkoMHQbK+DiunLYExTYcwR/laf/075BU9iF7qnm9hjV3z6qh48+2W9U
q8JQCh+BFFbfp2Dj5PKRLUpE+hzSSbqGT1ICC6m65RrlZm7YeEWjsZjnO80xTx7e
o++or9Qz+3dtZAM/dBe7h7DOzMaF0t6nCvdfklOYMtq7yi9+6s0nHmgBTJ6ZIJLk
FtVpDe45K62PVIV7T7BXWLWUYkWfazkXOPhZSwprCuqB4XZJYUnoeD2Xams/EKPF
Q4Qyd1zaQbVMPYVFdZ2dJ5u9q9vtBE2HaJktfXXZyIZQnnB4Pnrg+bK2CKj5LOxa
kqc50DI2jQ7Pf9XcY3fXDobwrv0LQD2bvypphi9G3Xt5SdhB04Pd7TY6AdjKX+/M
a7MHPPh+3NYCqRZzsmXWNJ3OJ/nH0Yj4xMFL51H3xkui8oX0buQm1nq+kG4gtGJw
eKiYK2iU1sf3v86mGwOOPPEMcheRjCwekrRls+YVG+1/ulHZBv6t9tm2gYlMR8e5
40n+0KjR/me1XaVktWBxBbqMKUmpn5+x0qfaJp2ilz8b1cqA1HboD/WG+9fbmcwh
ssc3TF2mupFWYgiawOwc
=TWIn
-----END PGP SIGNATURE-----

--97LDRFDfwTH+2c++--

--===============6058804198833097624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6058804198833097624==--
