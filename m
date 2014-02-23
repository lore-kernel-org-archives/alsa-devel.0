From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 049/102] ASoC: wm8523: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:33:41 +0900
Message-ID: <20140223023341.GO25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-22-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1085994998140701039=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA4C0264F53
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:34:03 +0100 (CET)
In-Reply-To: <1392723517-12772-22-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1085994998140701039==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FJOUHINv8uyEJFmS"
Content-Disposition: inline


--FJOUHINv8uyEJFmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:05PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--FJOUHINv8uyEJFmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV4CAAoJELSic+t+oim9r40P+wdcfQjMh2GSA53aUk5Pn3ht
9vm3hxbQ8CewY4c8RRq+R/aH7Gt+I1gkgO66zeIxD3ZfyhrxmQUjqg0yVJzn5zSw
HT4fF9KkpBCierqTAJ/gSIjjzA/oB0u9w6j11885NPfyS3Y/vexaDJckqE7b8ngZ
yASjcotC4nYCgrwybA+BjK8gvsjhWGxkHBe1BWjNf2gGjIR1CySkpNU0Wh00/Jlm
Yc/5Hpxa8AgAcU4iA5LgQH2TtodGo/hc2oQJQAKlDAkCBpxE/u1jjUpTFRerBfzV
8B6HRMBISgX1xxpG/3YXLl11aFIW7oj4+0XU4nxjTh2NQCkZfLkey2bW1i6CiGPf
j+z3nv3HYDdZ6QYJLIaaIvL6k+JgpOrCsqj0heaa8Y6V93anzHcI5BEUzaGRZQTj
UMMxi2CvAT58o5WzkkxYpjjTK0vxDmIi7ZxaAnDxH3XpM8JF6he13uvC8k7MO64a
BcZbt9WMqFLKBq972zHC6RKzG9qDwWE8wiHWwT96wWzrr+eLWIrOLRXtQbCH3HIM
9cCSnYo+Q+iZTAPdJNw6b8hfBsbxfWZzsjoBrN1sNRxjO9Sj2lq+WDNRRAGbvNdN
KqJVWSqOzDI6SPjbx0beZn2UCAD24q9CFimQnVVx+hGUyPZVFd5Hu4OJHEvFibyq
IrHaT52XFFnRnczJO9cV
=w91G
-----END PGP SIGNATURE-----

--FJOUHINv8uyEJFmS--

--===============1085994998140701039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1085994998140701039==--
