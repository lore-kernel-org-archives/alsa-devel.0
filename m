From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: DAPM: Allow update_bits use 32 bits
	reg
Date: Fri, 18 Apr 2014 15:53:44 +0100
Message-ID: <20140418145344.GT12304@sirena.org.uk>
References: <1397736776-7569-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1145132781476199586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F0072608CF
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:53:56 +0200 (CEST)
In-Reply-To: <1397736776-7569-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1145132781476199586==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5tKHt8kc6ehPqNw5"
Content-Disposition: inline


--5tKHt8kc6ehPqNw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 08:12:56PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch change reg's type from unsigned short to int.

Applied, thanks.

--5tKHt8kc6ehPqNw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUTx1AAoJELSic+t+oim9TBMP/jcN3MDRqWqP4fTWAqxEPVWa
5AQtEJnFJqeYTB4EclMZmIQ4KItXUO3HPLaI1irTVXDsPXnPrKoc18qwa+H7phut
o/XAiDFdgjc2VfEVsErbZ1GOXMx74jdEM0qCm9k9mZbfkN2hPuNCbUAWAU6c4kEk
eGZI31hBnAKoBkitGcClFAZMZVpU5+sIj2uQ1nA8mO75OfdaYcqcTQpkOUbW+i/1
dY12+MvdFu2lfMEtapqkb2AdEp6qHVeAGEuPAI3xTnbU7zYUf8NW1/54mTQapeIi
AOP4OCKf09u1fvMD4gwLeBGwuvFJv0wJj7xtk/d3UuS+iZymLmcEKvxRwWA6U5H9
L+kKPsm6JqVqdZwgLs8QFFtwkIZc9RttSTuDyGkU0N4GrnZXNqjU8JgmxxhhQflH
hs6JH1/IukeTsO8j4I+VleOxf2CD6/xZsvw2UG6+FBsxSASimOfbz0oFQTXO3lo2
a/FeXt44IhaQbJlj4oVEvWUmyRddKNToBlZvYb0BfxsOhI80b74LMJQIWwXVCdZG
q/UwV7s8Kq8yUzkUJxS5q1IMBHs38NsLRwrtQgUojzUWdmSw8g+p77qfzOz7And/
YABX4bQQxC660hwI3QBClwru1TzutgzXgekFrIPdmb1F4WY62sIcHnpa64xdSiY6
vBXnO5vztaEvnGEr5J+E
=01Vf
-----END PGP SIGNATURE-----

--5tKHt8kc6ehPqNw5--

--===============1145132781476199586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1145132781476199586==--
