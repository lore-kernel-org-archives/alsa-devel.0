From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: simple-card: convert to SPDX
	identifiers
Date: Mon, 2 Jul 2018 10:59:21 +0100
Message-ID: <20180702095921.GB18211@sirena.org.uk>
References: <8736x2f93c.wl-kuninori.morimoto.gx@renesas.com>
 <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
 <20180702094852.GA18211@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4810597141705295067=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1432677E4
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:20 +0200 (CEST)
In-Reply-To: <20180702094852.GA18211@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4810597141705295067==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 10:48:52AM +0100, Mark Brown wrote:
> On Mon, Jul 02, 2018 at 06:30:28AM +0000, Kuninori Morimoto wrote:
>=20
> > +++ b/include/sound/simple_card.h
> > @@ -1,12 +1,9 @@
> > -/*
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> >   * ASoC simple sound card support
> >   *
>=20
> The SPDX identifier needs to be a C++ comment for the tools, and to
> maken things look more consistent I prefer that the entire comment get
> converted to C++.

Ugh, sorry - different rule for headers randomly :/

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls593kACgkQJNaLcl1U
h9CLVQf/TjCc1qzDvHJDomhXoMrnXvkAjqU6M7oS1JcYc6xnXeiEJtvUQc/ZhUf9
7KpMF8PZkP53qf+K5qgZxbdS7LdprkkjUPmawvhVb8NCKMb4kTvilaqeqaZ9Yr4u
QxCIAhzZqb+eIGSkdJHQOfW5nHnygbEDrdqYfa8owahKv9+Yjx3A1JlwqqZUmxBn
VZ7ySLCW1BrJkWgeMPBLAPc8q9nDNVmfU25RGMDKnmdFKaZkHjrREvKZfKTkGS4N
JU5PugtjsAhlWNk5D40tbEtXm+II8Mn+hsHsFXcxlwnkhRIuj/i1P69WoxQDOw3d
2muw2bIvAF9eIwroT2dD9alqiKN/iw==
=+HYB
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

--===============4810597141705295067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4810597141705295067==--
