From: Mark Brown <broonie@kernel.org>
Subject: Re: [ASoC]fsl_ssi: fix of_property_read_u32_array return value check
Date: Wed, 4 Mar 2015 17:27:36 +0000
Message-ID: <20150304172736.GS21293@sirena.org.uk>
References: <54E1199F.3000107@maciej.szmigiero.name>
 <20150224082448.GY6236@finisterre.sirena.org.uk>
 <54F70389.6020004@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u9zu4ykPqKoh11OB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F70389.6020004@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--u9zu4ykPqKoh11OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 02:07:21PM +0100, Maciej S. Szmigiero wrote:

> Against which tree/branch patches for ASoC should be generated?

MAINTAINERS says:

SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
M:      Liam Girdwood <lgirdwood@gmail.com>
M:      Mark Brown <broonie@kernel.org>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

mainly the for-next branch, though bugfixes go on for-linus.

--u9zu4ykPqKoh11OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU90CHAAoJECTWi3JdVIfQIPYH/iuFBdmQDoUP1dAzzUWRjPtn
pQ81azAh4D9Y9JpMIcWpxqIHWB10+2fo3vxlSQZFMDQgm8jwIh5HVFJHHoVtnLe0
dT+7fVcs+rNB5CUCw9qqBNC63nc1An5XnhbMvYScshv4wP5d9SDxLB5JmFJi0fxT
nMHz5qi6HcFvODbFH5pZaVQMOcWoJPaNGMfIPYg5q7+1wcdzncb50D5K8X3UtBsp
Qqv3mLz+yjqnOndWZAiCFU571P+YU/IPu0xS7PnW9ECoA33Xt4uAqI9w9qNswMbZ
pKpsJ3o+6lv58P1yB2V6c4NQomkPJytSS5OamR09ZHxEuDRAbiHglh0KEmUEZUE=
=dZ5H
-----END PGP SIGNATURE-----

--u9zu4ykPqKoh11OB--
