From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Dereference 'edev' after
 checking for NULL
Date: Wed, 17 Feb 2016 19:20:54 +0000
Message-ID: <20160217192054.GZ7544@sirena.org.uk>
References: <1455700199-18691-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3933950996693275788=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C51DB26067A
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 20:21:00 +0100 (CET)
In-Reply-To: <1455700199-18691-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org


--===============3933950996693275788==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dwN3S3mscniL3FCL"
Content-Disposition: inline


--dwN3S3mscniL3FCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 07:09:59AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> Commit 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting")=20
> leads to the following Smatch complaint:

This doesn't apply against current code, please check and resend.

--dwN3S3mscniL3FCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxMf/AAoJECTWi3JdVIfQyTgH/icm0oPPIyppG34r32CpCTTF
gWCxU/PzXUw3S/uftxzEDHAcMhWAJ2XbtOV9I6RRa7wqnHqMQ/er4ttOhiRupVfZ
8bOhg8fhbYFgFPZJu0+6kbbJZE+QPabAJTl6EQbGiSdxZ+wTYu0fcBcrRC03twWT
p/MU0Cyp5cAZiC5apq99KSOAcqT27Xt/O4Uo9LLN3Z6UYDreuXJC/vp9GlNpF870
9y4G1CcuVGi45+eY/u6h3v2faTrc9KzZYIZNDToffV1A5OTq+1rApC/e48rgsY3Y
WFAjQLZSNdFHRwERoGSLv6IMPAVNCIrIO4+KGodmbp6fuOWiToghqunfQA4XAI8=
=1T17
-----END PGP SIGNATURE-----

--dwN3S3mscniL3FCL--

--===============3933950996693275788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3933950996693275788==--
