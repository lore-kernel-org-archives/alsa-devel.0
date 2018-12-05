From: Mark Brown <broonie@kernel.org>
Subject: Re: [resend PATCH] dt-bindings: sound: Add
 documentation for pcm3060 property out-single-ended
Date: Wed, 5 Dec 2018 15:42:29 +0000
Message-ID: <20181205154229.GG6205@sirena.org.uk>
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
 <20181204214313.GA7847@bogus>
 <7cbf1452-354f-07d6-2310-cadc4358433e@birdec.tech>
 <CAL_JsqLirgcDwANbORiez0xtO1tEHDL-O8XdbZSP6R+WZF_HLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4554455705623965617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FBFD267A75
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 16:42:31 +0100 (CET)
In-Reply-To: <CAL_JsqLirgcDwANbORiez0xtO1tEHDL-O8XdbZSP6R+WZF_HLQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Kirill Marinushkin <kmarinushkin@birdec.tech>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============4554455705623965617==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 09:28:51AM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 1:02 AM Kirill Marinushkin

> > Mark already applied this patch, with a slightly modified subject:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commi=
t/?h=3Dfor-next&id=3Dfd7de6370cb62b147185834d60069568a21acacd

> Humm, I wonder why I didn't have Mark's "Applied ..." email for it?
> Otherwise, my scripts rely on the subject matching which breaks when
> maintainers edit subjects.

Probably due to some problem contacting patchwork, the CC list comes
=66rom patchwork so if that (or the network to it) is unstable then the
scripts can't get anything that's not in the actual commit.

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwH8eQACgkQJNaLcl1U
h9DWJAf+OJOWPgoV+KEapu9aBDq3wx+p4krlactixoGKLRZdy1B4LbFyTjHAPom/
S8FqictKN1mSH0ukT2pYUoGz6YfrFV4q0pzX8+VQvvBjh97x+f9HvG1WC3AVwUgQ
Z9SkBEUfDxU3j2i4HSALDvcraf/+Dr6G7o/dTSOaQcfu9sLvk4lrcSap8HTOL90q
EvYclU6B5xMPaA4WIKWqd5B7h9+REDDF+THSQrOY5O5SWjOtT+z+WQlHYCg3vDD+
E4MZOYYKtYDR0xK1dC8iVA56c7j1IeRZHYg984xNvWca4A/fo6VfRAGeTupyQiNI
5M0XAglUr8vBXx1o4W/smtSPjwTm6A==
=VSjm
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--

--===============4554455705623965617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4554455705623965617==--
