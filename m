From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: max98090: Remove executable bit
Date: Wed, 20 Mar 2013 17:36:27 +0100
Message-ID: <20130320163627.GS28775@opensource.wolfsonmicro.com>
References: <1363730323.16270.11.camel@joe-AO722>
 <20130320095758.GD28775@opensource.wolfsonmicro.com>
 <1363792936.16270.30.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530948497208501389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2AA4B264F09
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 17:36:30 +0100 (CET)
In-Reply-To: <1363792936.16270.30.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0530948497208501389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPT5DIEyVHz5yXBV"
Content-Disposition: inline


--GPT5DIEyVHz5yXBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2013 at 08:22:16AM -0700, Joe Perches wrote:
> On Wed, 2013-03-20 at 10:57 +0100, Mark Brown wrote:

> > I've applied this but I'm fed up to the back teeth of having to hand
> > edit trivial patches from you because you ignore the subject line styles
> > of subsystems and make up your own.

> Your style rules just don't matter to me and
> you can ignore the patches and fix it yourself.

> Or better, create a tool for others to use that
> follow your silly style rules.

This is just like any other coding style thing - you should be creating
patches that look like other patches for the affected, if there's things
like obvious visual differences in what you're doing you're doing it
wrong.

Automation doesn't work for things like this, there's a good solid
reason why there's generally a human involved in patch; the other people
who submit lots of cleanups generally manage to figure this out
usefully, you might want to discuss techniques with them.

--GPT5DIEyVHz5yXBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSeTqAAoJELSic+t+oim9nDIP/i9X7r+FYLBGD7kkRb0JzT2f
WubH+Xje+uGGA6qm4NQxKkhgck7lrf5xwTk/loxrjb3FKiZ21ehj+AzFs8GWbFTy
0ZgKlrzbKKNgplvNzIhN6W2mbjeqqS9nhz1/JfozHBQHXln+icqzzzfoMapCT77i
GjUZOkLMcdc3QSjWNTR6+VqHc/rRJmmjYy5/9kr0GxF5g6MvC2BcJjd7MQCiiYa2
BBgtkulbvBRq7lnkR318IQrXR2sj/3xiip5ThW7ZND5DOUfAv6BdLo+eVFeXNHv7
FUOmcAk55f4xFMGVTBXvibPKfJRiPnDfuMH3JkH0ihcx30zONUE+nBPwb49gth3Q
dG0dR9WNQFb14DdVcuETpaIOmgbgdBFT3rtDFGL+9jk0DtUKOxGXyi2B+paKg/OB
NjEKRL3BZ5SLNVNvZVux0Wc9/ZUu67hyQ0HesDlTocsupXcy28l3kr80mI5d0CkD
WGgbqyZrDihVbu2KuED3EYh5rM9f2AQ+aE/JP24is7N9V6mxXfQo80JwJxILI0rx
7xiXub2RY/q9/724a01c5H+zicp/JaroB6EUG3Swq1rB4oV74Siqe1UIo5wYYsfa
vicGryfTv9z+s8roz2g1LscHJDGOj2GEvvJek6m17xWvfA4iCRLjcEt1M5LV9uHN
MmgwoLfxH6Z40fZVhpxt
=kpGr
-----END PGP SIGNATURE-----

--GPT5DIEyVHz5yXBV--

--===============0530948497208501389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0530948497208501389==--
