From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: Intel - Convert to use
 acpi_dev_get_first_match_name()
Date: Fri, 12 Jan 2018 21:01:26 +0000
Message-ID: <20180112210126.GF21458@sirena.org.uk>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
 <20180105160935.48588-4-andriy.shevchenko@linux.intel.com>
 <20180112190312.GD21458@sirena.org.uk>
 <1515788467.7000.978.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515788467.7000.978.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 10:21:07PM +0200, Andy Shevchenko wrote:
> On Fri, 2018-01-12 at 19:03 +0000, Mark Brown wrote:

> > This doesn't apply against current code (even after pulling Raphael's
> > pull request) - can you please check and resend?

> It requires Pierre's series #2 [1] to be applied first.

Ugh, I see.  I'm surprised I was getting pushed about applying this when
it had unreviewed dependencies... =20

> [1]: https://www.spinics.net/lists/alsa-devel/msg72463.html

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZIiUACgkQJNaLcl1U
h9BJcAf/TNJlUnpDrGh39TKWonEt5nPLKmj4aWwG/CSljhNFArL+p+KhEoz/z40m
rcp8QUKBDZZXNfOLDTi5RSr+LPiLxv2R76nsgAKgsGoBKyBonADSYJJHbb3x6BVC
j+EVj4SgOGQWne0S3NwxYhGExZnEK5Z8/0/WptLEJJMx5nN7ABNjAiKatHaeB/jh
jvGkMDPZtEuoKPftAmaFdonDDZ1uLXwdR7MtV0+jIGRHmnvmovYmmj7SdEaq9cO/
6VJOudmp5x4coIZFMentmb/T+brtfcv3WzoDG8aPCnMQ3Fv07bhj2hM767X60Fwp
dLn4a6GwbWD8I0keIbXZN3qeLhfFxQ==
=NYMe
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
