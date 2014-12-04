From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
Date: Thu, 4 Dec 2014 11:33:46 +0000
Message-ID: <20141204113346.GT7712@sirena.org.uk>
References: <547F3CAC.9050105@arm.com>
 <2240364.fL8B0EDbFB@wuerfel>
 <20141204110746.GR7712@sirena.org.uk>
 <2090131.rL6S1lx8Ky@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SQKdhnb/5YOpdZ6f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2090131.rL6S1lx8Ky@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Rajeev Kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org


--SQKdhnb/5YOpdZ6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2014 at 12:17:15PM +0100, Arnd Bergmann wrote:
> On Thursday 04 December 2014 11:07:46 Mark Brown wrote:

> > It's relatively common with newer companies - it's like UARTs, any
> > company that's been around for a long time will have a homebrew IP
> > already but places that don't (or get fed up with their existing IP)
> > will tend to buy something in.

> I see, but are any of the newer designs going to use platform_data?
> My general feeling was that the only places that still depend on that
> are legacy platforms and architectures.

And x86 which does have things like PCI cards.

--SQKdhnb/5YOpdZ6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgEaZAAoJECTWi3JdVIfQ6oAH/j7/+GnToU54d8lUYEOk7/BK
3fmMJ7FjjgTy7OUqlnvoGFgz6e6tj2CIiDT/QAH+u9Nifw3ZqndaByf9Shs021gv
MaUlSPjdMQ4F6AO3Wb7ft4J+fCa2N5sRDAlMQXWRWHGr9r3sOuuUe/aYtYhDNX0m
qS8mJ+oCDRgtb9YqD+RMknc+9vY9hzc4Sab445FzghosWVvwnEuYgrhAIyNaixNG
zv685ysEeQD4vFbwzDQBd8R2s+ENWNbpUBSg5d7otfdszd9Qf5RGrZf4ZQeYK5+I
H6bKOC9t21pGJKexMWgv6/KlHuEfzSQn7k7MYHzwKPy13rXE0cWyXg9H9iA60dc=
=HDXC
-----END PGP SIGNATURE-----

--SQKdhnb/5YOpdZ6f--
