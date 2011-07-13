From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#631963: linux-image-3.0.0-rc4-686-pae: no
 sound out the rear plugs
Date: Wed, 13 Jul 2011 03:44:26 +0100
Message-ID: <1310525066.8783.220.camel@localhost>
References: <20110628172442.30723.36601.reportbug@spruce.test.oeko.net>
	<1309319933.3093.1614.camel@localhost> <s5h62nptdpe.wl%tiwai@suse.de>
	<20110629184502.27095.qmail@oak.oeko.net>
	<s5h8vsjsvuw.wl%tiwai@suse.de>
	<20110701210656.4471.qmail@oak.oeko.net>
	<20110701212201.GG29924@decadent.org.uk>
	<20110701214102.9286.qmail@oak.oeko.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4926269768180852692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id D198B1038D3
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 04:44:33 +0200 (CEST)
In-Reply-To: <20110701214102.9286.qmail@oak.oeko.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 631963@bugs.debian.org, Toni Mueller <support@oeko.net>
List-Id: alsa-devel@alsa-project.org


--===============4926269768180852692==
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="=-lTAqBSLA8MdeNNzTADGT"


--=-lTAqBSLA8MdeNNzTADGT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-07-01 at 23:41 +0200, Toni Mueller wrote:
> Hi Ben,
>=20
> On Fri, 01.07.2011 at 22:22:01 +0100, Ben Hutchings <ben@decadent.org.uk>=
 wrote:
> > On Fri, Jul 01, 2011 at 11:06:56PM +0200, Toni Mueller wrote:
> > > On Thu, 30.06.2011 at 07:59:19 +0200, Takashi Iwai <tiwai@suse.de> wr=
ote:
> > > > I guess this must be the new feature, "Auto-Mute Mode".
> > > it turns out that you're right - I just had the opportunity to verify
> > > that.
> > =20
> > Can we consider this closed, then?  Or should that feature be
> > disabled by default?
>=20
> good question - I didn't see it. Don't know offhand where to easily
> find it: Upstream's changelog isn't included in the package, so...
>=20
> I'd be fine either way, but think that the feature deserves more
> advertising, or, alternatively (?), being disabled by default, to
> prevent bogus bug reports like mine.

What do you think of this?

Ben.

--=20
Ben Hutchings
All extremists should be taken out and shot.

--=-lTAqBSLA8MdeNNzTADGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATh0Giue/yOyVhhEJAQpmgBAApgbcVU9B1Jt/SgyKU9y/H3qchnnfbuho
+AdSyXCNyQXXm9IW5TcdvLv2ID9MvNPN8zQhFoBTN4GW5Eba5y08+9bk5cINg5YA
thFElPuFR/uhtAOu023pH8twLuD+I5SbVswThnbXUk9tV+SRHEynH7Lbsgm6rHB9
jmLURuxSmYAU3LPBX0Eh61VeHi3VeX31GlS/XIK7+x6yCvaEq7PhLc5PVtHYcz+g
ElCUE6aPhVxxJ7pFSMf/z9xo5ROBRlHHZUqHzB1cKgg5yVFTfVHdaaiqI74KIuMj
27Z0Z70iW77vEuoJw31ZC3IyHGEg5ohJE+XMzUfC287iJUjBY6bbCIKGoh+ip+jI
gBAZa/OxFXFwaXjQMdrb/uRkbpa/XvPwqfWFypDPwf32GHcNbv6H2JuSQ003Z8Uk
6kOmy4k03tACtrcAUF8bcU72SIp1Z/QksIyT+ti2APeYUMXCDzkeiK4Czp0bCK1g
m5lOzJ64s02KZh3lahktoB4xNYo6VR4wJ0NSOBsD/ilsV7ziIgkSGJyE27q0155N
gsSksVyRE4cTCnEMGlyYHhUOdBV4YNcRj4czbwXRgcfmce2yMyDBSGEtw+UDmqWs
pXYQTU067EFi6o4wqNV/QF+xeGKauirwmgOx6z3CgxTLWaQoRbMAdNU01InhLF2W
99aZc0ep+/8=
=yQGU
-----END PGP SIGNATURE-----

--=-lTAqBSLA8MdeNNzTADGT--

--===============4926269768180852692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4926269768180852692==--
