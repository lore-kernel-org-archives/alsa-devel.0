From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 001/002] ASoC: Replace max98090 Device
	Driver
Date: Tue, 5 Feb 2013 14:05:49 +0000
Message-ID: <20130205140548.GB4720@opensource.wolfsonmicro.com>
References: <A453F1AE3B5DC14DB19666C506CE75A7108684F402@ITSVLEX06.it.maxim-ic.internal>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F4C6@ITSVLEX06.it.maxim-ic.internal>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F4EC@ITSVLEX06.it.maxim-ic.internal>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F565@ITSVLEX06.it.maxim-ic.internal>
 <A453F1AE3B5DC14DB19666C506CE75A7108684F584@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4289763606005772442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50EA92615DF
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 15:05:50 +0100 (CET)
In-Reply-To: <A453F1AE3B5DC14DB19666C506CE75A7108684F584@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerry Wong <Jerry.Wong@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jwong@jwassociates.com" <jwong@jwassociates.com>
List-Id: alsa-devel@alsa-project.org


--===============4289763606005772442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DaTEgnRu5pEC8TLg"
Content-Disposition: inline


--DaTEgnRu5pEC8TLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2013 at 09:48:47PM -0800, Jerry Wong wrote:
> From: Jerry Wong <jerry.wong@maximintegrated.com>
>=20
> This patch removes the existing max98090 driver prior to installing a more
> complete one.

Please test applying your patches yourself before you send them, these
still don't apply against Linus' latest release.  It's possible this is
something to do with your mail program corrupting your patches, try
e-mailing to yourself.

--DaTEgnRu5pEC8TLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRERG1AAoJELSic+t+oim9sccP/30+JPleT+9sUL4RES1JwZmx
BNAxDwhIOBgAWTdbX1pWofGECJt6gr0v9pRIBUs5+i09wKIjW6dWAECCyic0nEPR
dBnGl77J/KV3lFnp6jyWEMt+egi2B+y2jfPDg7SvBUw0qPCPBMBZcUeBUtkDk02h
//Q4uJhohhr5ha6aUn25y/StefHF0uXq6EJRz/gfGY1g0T2kQU6JMRH9df1DSYEX
Pm9xlAkR7hnbiqmkxXqb5p3UMWfWSoDTawYCSMll5AAs6EHEcG1H9II5mw0HfJaQ
a+wtWH1Laz5XEVf4Qaqho3i44gbotU0TndIz31s+CekxkgvoNjThCkOb5Fb4t1qw
9HzBAvXNaC2Qu7/Kv/2QQ28OrkDsOaLGORK0ZmB/ecpq+Bgrl+MAYdYMmPibk6iP
bi44rPKrYd61dKUbBtONhQGls4wQofWWiEqSmz5n6s2F/VzmXJxfkvV1IIJBh438
BMBRkJpXJmomXPiyMm4Y+Nab68I1h0khQCbJwb+fgQJfRl1KQZ1niv5l1Rhq0Gmt
KUwRrIuKSP2DlxC/n+UEM4wANNucCuMLSuuTHBnu52ngpbTdPmXXi2/9MqHSti/E
VQczEZQB/BkiMv3fLevEWMDWz5Enzcc90uoEfr13c+SA04lDlpCrykVLBV13B6JT
iQyVQbvWqlAAGdSZHaRX
=Fq3s
-----END PGP SIGNATURE-----

--DaTEgnRu5pEC8TLg--

--===============4289763606005772442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4289763606005772442==--
