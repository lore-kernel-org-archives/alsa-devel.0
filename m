From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
Date: Thu, 17 Oct 2013 18:42:05 +0100
Message-ID: <20131017174205.GQ2443@sirena.org.uk>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
 <20131014131748.GU2443@sirena.org.uk>
 <20131014145629.GA17351@katana>
 <20131014163753.GF2443@sirena.org.uk>
 <20131017164331.GA2896@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWGl2Oocib6fGxwW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131017164331.GA2896@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--XWGl2Oocib6fGxwW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 06:46:14PM +0200, Wolfram Sang wrote:

> On the other hand, MAINTAINERS information gets overlooked and/or could
> get stale. Thinking about it again, it is probably less work (at least
> for me with i2c) to create a git-hook fixing the subject line than to
> always nag people.

That doesn't fix the main problem which is getting the mail looked at in
the first place - not having a subject line that people are looking for
makes it easy for things to get dropped on the floor.

--XWGl2Oocib6fGxwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYCFqAAoJELSic+t+oim9Q+YP/RtH19EYuBUnkdv0M8N9vO7N
9H0nBh7lhunYEyOvvWDCAECtMJeWcxSgulfKSbaZACtOVOTX33T90qQ2e0cBTPTN
e5bjP+QR6ZeQ1E4I2h229qAt0y+CM9hbSQau2t2Xmsl6ofvTT8FL0qXBcUpkMPQi
zBE1WCUKj2nzAfSKVPKHawnEZw1qXLoLtxe6SMxiVTCvo7ZAAVXCAD2s9CX+vbOk
3z1YaBQ+8Hg9zT7/MHWSsx7c1Kwj7kd48f+Lv6CXc5tau/he7OjwZG9DDSgnsIgc
7yeA7zDeze8r6kiIUr6Ty+Cv+ZnemS/90NNeicvqViuXxEZXdouOZ9ahCoRgxmmV
A31Ucqp67M5mnVEtB9oKXyOoMhk/iUhN38oRJJu/0kN5X74nwY6VFj5gFI7RtIiM
JUDBs4LEUha1y/fZHCaGWkoyTpv/FT744+Woemuey2exmj1Bg+xOSuhGVdCJzYdA
72x7i55eVHPD5iH7BkAqmkouyWA5t32fvMJKaEtbC6PGnCbly92Sf4AQFCE7bBOO
X8xuJqOxXyf7O5/z3JgVQeVDDihw5sjsBBMjBWuHdwZGhCOP32MgRyi46JI2B100
lUG6lObaECaWv3pJzCvtqtegeyxFdkTnSD5ltqkXOH/C7QDJ9fhDgQJyW9YHMcYP
Ix1+ommmTz6ZUjVWjUsO
=AE10
-----END PGP SIGNATURE-----

--XWGl2Oocib6fGxwW--
