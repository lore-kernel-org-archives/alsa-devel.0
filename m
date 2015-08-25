From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH]  sound: Clean up docbook warnings
Date: Tue, 25 Aug 2015 07:25:41 +0100
Message-ID: <20150825062541.GC27431@sirena.org.uk>
References: <20150823035036.1c5614db@xps.lwn.net>
 <s5hzj1is09b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hzj1is09b.wl-tiwai@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 23, 2015 at 01:38:24PM +0200, Takashi Iwai wrote:
> On Sun, 23 Aug 2015 11:50:36 +0200,
> Jonathan Corbet wrote:

> > A number of functions and structures in the sound subsystem had incomplete
> > and/or obsolete DocBook comments, leading to warnings when the docs were
> > built.  Correct those comments so that we can enjoy our audio in the
> > absence of warning noise.

> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>

> > NOTE that it would be good if somebody more knowledgeable than me checked
> > my work, since I had to fill in a couple of things.

> All these are ASoC ones...  Mark, could you check this?

I don't have a copy of the patch.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3ApkAAoJECTWi3JdVIfQCYIH/irtTlVOHNJTOdI4ZVf6BKtB
PCP1cvn0qfKwDrpZiUBsz6zzpHKhgQZMlrhBbdyHWnxuFUJTXfNYZBxHTgMVNJqU
fpR2TYk+Wt7RT6KSPF0pjUsjneCKxYXf5vo/uwgmvTk7Z9DrH7rmK2ovw2H5p7JE
GkOItUgXDegiOZhze8e5Lgt/O4SzNqP6O5nWvOfXDb8VtiP5pKxu29OQinJhk6VL
ai7DIL/oFbQQlfEYiqN8vmV35p+hC6Gxk65rVuAIfNvwk+HX9lMCm/rR1cNGsRqO
4MjVTLXwg0przyMT1la0rE8nIeh7kQwrMyzIXPn44sCSSYaRKARplGzKDFyxcxo=
=dDyG
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
