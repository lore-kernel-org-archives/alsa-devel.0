From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend 0/3] ASoC: Intel: Misc. fixes
Date: Wed, 3 Apr 2019 11:40:17 +0700
Message-ID: <20190403044017.GC5748@sirena.org.uk>
References: <20190402102049.27975-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6051876545964359017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52BC2F8068A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 06:40:23 +0200 (CEST)
In-Reply-To: <20190402102049.27975-1-hdegoede@redhat.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6051876545964359017==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 12:20:46PM +0200, Hans de Goede wrote:
> Hi Pierre-Louis, Mark,
>=20
> These 3 patches (originally 2 different patch-sets) seem to have
> fallen through the cracks, hence this resend.

Not sure what makes you say that for patch 1 and 2, they're already
there? =20

8a68a509ae6b5d7d18c6bfc88553ca7761029ada ASoC: rt5651: Add support for acti=
ve-high jack detect
a0cb2d4357e483b7bca3c06f790d8f5d4cc20d84 ASoC: Intel: bytcr_rt5651: Add BYT=
_RT5651_JD_NOT_INV quirk

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykOTEACgkQJNaLcl1U
h9DuPAf/TPMtY3WZqJtrh9u6jbzbYVUSlWaa23D78nWI3/1TtGxYmEVNtVtMFY6D
TYFRCTqkJFb8/Urnum8AjGLWbJY+JFhhMMDVxg7qdd7LFYyvi98QIaYFQH5oKSxU
zsNTaNrKY+BSf+DMm+xSd37sc3cK3cQLo+HJYglUF7wNznbgmeLEqcz7KoPtRO6V
gxbslsZqV9Eo92NbB1X5uvZXLPzPFY2V9vj4zCnyAKb5yjqexxqEYjc49Oqq0XZc
FYzroCve5FAkqcxxjv7WMmQqEc+DyFWtkWjUolU1RYmSXNL8plQBVi5p9+s0kpEt
LF96zweh9Srkh//Mx1NGshQCz9dHqg==
=XrE4
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============6051876545964359017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6051876545964359017==--
