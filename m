From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC fixes for v3.19
Date: Tue, 16 Dec 2014 17:49:02 +0000
Message-ID: <20141216174902.GU11764@sirena.org.uk>
References: <20141216171204.GT11764@sirena.org.uk>
 <s5hppbjy0hb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3851931160498597248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 175BA260674
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 18:49:20 +0100 (CET)
In-Reply-To: <s5hppbjy0hb.wl-tiwai@suse.de>
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


--===============3851931160498597248==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I6qdtgfjj9z6AdGX"
Content-Disposition: inline


--I6qdtgfjj9z6AdGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 16, 2014 at 06:21:20PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > A smattering of driver specific fixes here, some more cleanup of the
> > Exynos7 and Intel ACPI support plus a fix for register cache sync on the
> > pcm512x driver which has been lurking for a while.

> Which key did you use for this tag?  5D5487D0 wasn't found.

Same one I always do, nothing changed since the last request.  Try
refreshing the key if you're using a different machine to normal or
something?

--I6qdtgfjj9z6AdGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUkHCOAAoJECTWi3JdVIfQemsH/0qRPu0cX7UOih96rV1aMLnz
l8Tq4iKAdN2PC+J2MVNHJpaAZUwjGW7W7PWePKSiRYSk+axfzLso9LsHgZke1UBX
Wyut3ajdVNg7bPQWDYar2etq/xUHgPY69TCPYyzzzywjQlisapu/XmItZC2CVWcA
O5ey2FpzyrF+08LKsSwz//0hTh06Nd6AO2qr+jXt6zKg6S2ZDsG4rFQ9U7ru7Yhu
Lpl8XjKxIqMDVpO1i6ffOOGK95df+0jcegxcBZZpo0zwUiUNWYCGVCWPuBskbfSf
yV9anGXMZC6hE+lRKVmRC1i6xGpNWp6UDafDg3KgVikQzOrFVN/pBsgfE932Cd8=
=vG+q
-----END PGP SIGNATURE-----

--I6qdtgfjj9z6AdGX--

--===============3851931160498597248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3851931160498597248==--
