From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: Intel: sst-firmware: missing curly braces
 (harmless)
Date: Wed, 26 Feb 2014 08:46:44 +0900
Message-ID: <20140225234644.GC2927@sirena.org.uk>
References: <20140221085240.GA13185@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140221085240.GA13185@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2014 at 11:52:40AM +0300, Dan Carpenter wrote:
> There were some curly braces intended here, but the code actually
> works the same either way so it's not a bug.

Applied, thanks.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDSthAAoJELSic+t+oim9XmQP/A095RfdPU/slmwJzywaLxa5
pBVHXFpfzmDeodaZXJuddnc/SLckmr9+iL/F1Ut6Ids55NruVlhTZfPtrZ8iBjZZ
CnpfGuE91tWdeeuMXO60Qs35wBMAiZK3VkNSeWy2xJwi8izHS6D+MK6Acl402MOG
f1fGESI8HNZ6g9hT+MpdqwEwTlhfl873qNC8X+oMQ3v+ZtsfHatiZX4eyTm42K2M
E3oCxnU9ErM/7Xc2rryzSjtJvd/BiDbPNCh/v3iE3zlU17lrqFK+32v3naHExDED
Kak6iv/zKIGNRv7a2ugPAyQVfYfbPFJgUqdfYhyWSU0m8bGRQ3e1b7GW+joiLeCg
wN7kJE/hrAkaNlSRyz8GzQwrgDzWvK/MmaIJeoftaHIZ7F5OyHg6V5Vv7nWPZs5C
W2OVjwM5V0kIKtFz/BI/nhqciIlcBgR62Yy+zXF52h3ObI0Jj0KNzr7ivnJPzur7
RRsU1JF+xen8JPwUzQeIch6UtCPM7lYp6UcToMriOFSkzf/pLg1PVAcTqUvk6J6N
ZZucgdfTX/GYLywuECh6JQx1Vj+IRwXwHxDJyhVjI/xnrhyS5csu/DdGMScqFL6j
ULfs8lhhC1OWk35kYjBdcO3ZNFxsUzUSO9TZ6RAB6HiFJU4Rx2vx7aIYODK/wHTe
dc/znZG/Czqdic5/+Gdp
=ZH2E
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
