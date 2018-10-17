From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio miniconference schedule
Date: Wed, 17 Oct 2018 20:12:25 +0100
Message-ID: <20181017191225.GK24097@sirena.org.uk>
References: <20181002195849.GA23818@sirena.org.uk>
 <20181016204852.GK2340@sirena.org.uk>
 <s5hefcpk2xq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2921659788934872020=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BA9322675A4
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 21:12:26 +0200 (CEST)
In-Reply-To: <s5hefcpk2xq.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--===============2921659788934872020==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 11:16:17PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I've dropped Y2038 from the expliit schedule, since Arnd Bergmann (who's
> > been driving a lot of the general Y2038 work) will be in Edinburgh and
> > may be free to join I'm suggesting that if he's free we cover that
> > either first thing or just after lunch and otherwise Takashi and I will
> > try to coordinate with him during ELC-E (unless others have a great
> > enthusiasm for the subject).

> I haven't registered ELCE this year but only the audio mini-conf and
> maintainers summit, but maybe we can catch him on Monday.

All three of us will be at the maintainers summit so I think we'll be
able to get some time to talk if we don't manage Sunday.  There were
some TBD slots at the maintainers summit, we could see if we can get
ALSA Y2038 ABI on the list there :)

> Sorry for the late action, here are some items that came to my mind:

All good topics, I'll add them in - Charles had some ideas for the ASoC
refactoring already which I managed to drop off the list (sorry Charles)
which is mostly the same thing at this point.

> - Testing:
>   My pet peeve.  I'd love to see some stuff, especially for ASoC, that
>   can run on VM, and let fuzzers whipping on it.
>   Also, USB audio can be virtualized.  What else?  (not only about VM
>   testing but also a real hardware testing.)

There's a whole testing summit on Thursday...  :/  I don't think there's
much argument with the ASoC stuff, but I also don't think there's anyone
with the right combination of time and enthusiasm to do the work at the
minute.

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHiZgACgkQJNaLcl1U
h9C7oAf9Gro/mCW0NxA9xb6l4vTqB0rKWb217vPnVol6lXblyLrzJguJm1xPiRBZ
V/PiTC/r3sIshQPib9e7bETco5uP3n/Ofb7I1Ir8mBjLTVqEcJh0+aLhlYaYLA4U
TnS9im+4Rz4t6BtV3OgOSVoM3mb9RNZ4Yv7tzaUTwmjO4hgSLKDg9LujjJUoMf4g
HKnYDJ/axrAj2UX2eEYHwjwq6KHO+689w6Ih/kxbQvtu+75Xe+dNUu/4+kW08Baf
+RbT053X43OST6u2mUu8uxQqVQqPQtbH31e3+BR0GImY/Wy6FcDOoKJqXud3I5t8
UNn/NRskhHbYOJlIUQAcYYqbG6F1Tw==
=HlU/
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--

--===============2921659788934872020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2921659788934872020==--
