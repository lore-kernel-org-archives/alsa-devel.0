From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/2] ASoC: da7219: Convert driver to use generic FW
 functions
Date: Thu, 23 Jun 2016 11:01:48 +0100
Message-ID: <20160623100148.GV28202@sirena.org.uk>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
 <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com>
 <2E89032DDAA8B9408CB92943514A0337D4644644@SW-EX-MBX01.diasemi.com>
 <20160621232116.GG28202@sirena.org.uk>
 <CAJZ5v0g47+igo+Z+gZZE9sOix8oCs7Jy+H-i=HcBUB+RVib3+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e+JRL32uBeeWnrD4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g47+igo+Z+gZZE9sOix8oCs7Jy+H-i=HcBUB+RVib3+g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--e+JRL32uBeeWnrD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 03:05:26AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 22, 2016 at 1:21 AM, Mark Brown <broonie@kernel.org> wrote:

> > Probably the easiest thing would be a tag for the core change that I can
> > pull.

> Or you can apply them both if that helps (please consider the first
> one as ACKed in that case).

That works too, if I do that I'll make a tag in case it needs to get
pulled elsewhere.

--e+JRL32uBeeWnrD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXa7OLAAoJECTWi3JdVIfQEZYH/iBFpV9Hg8cfJAuLwDD+XYpc
JK0TSiVIhLZTEORKAmOdcgWUijdoZ0bG/X6t9yOPGixlYWRH3TiLeRgaTfPQnJ89
DxmRhkCv/GZNXo/5CK3y+XH7yuscFITsYjIEGk937whJ/W8k6xqnWyygYENFz+CS
2aeemxCoNoEFS2V4AcroA86yNfuBOWIGOoQ1fj00scKzplTvzCv0/XA6BOAS1i7k
91mAxshX3SX413to+pW7TQROI4D76wxkK3bNWUqhE8gfSXY3uBtsMOQau5tx/cS7
+UXsGmJpBVnL9nvTtZ/oTZX6ZwTsnbiMkldx6q+SgE9hyHzF4Tc9oep0+uuezpc=
=GcsV
-----END PGP SIGNATURE-----

--e+JRL32uBeeWnrD4--
