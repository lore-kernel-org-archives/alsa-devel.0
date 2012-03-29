From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: add audio routing for
	imx-sgtl5000
Date: Thu, 29 Mar 2012 22:35:23 +0100
Message-ID: <20120329213522.GD4153@opensource.wolfsonmicro.com>
References: <1333037583-23582-1-git-send-email-shawn.guo@linaro.org>
	<1333037583-23582-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1616363496927169819=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D78C810457B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 23:35:26 +0200 (CEST)
In-Reply-To: <1333037583-23582-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1616363496927169819==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2012 at 12:13:03AM +0800, Shawn Guo wrote:
> Add DAPM widgets and audio routing support for imx-sgtl5000 machine
> driver.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.  Good to see that the code Stephen provided is working
for you guys too.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdNVgAAoJEBus8iNuMP3d3NAP/Ar4ZUkeyg3E7plqjNywkvpa
6taRB/MCDspBsqBOqm+3japweXhJ6TqQmPMfPsXeeg8b6xytt+Qtnv3K3h+LHf6V
LUtc/CUEuZT77jtfYfMlCqzuy64LUAFQxmSmGfzqbQ8291k3i1cGewvQBu30Nxpn
acW4jhqLOPUhmQbHWWKOf1/4kYr+nd3Jy11msdoRFty07ikc6R6qjNUmCzp8HHl3
JWOE6ZrA6qaWfG/ri8pRJzIv5f7PEhS7d0x+hi0UdE0jq0yiIfAM92d+0M5BGdST
mlvmtYEAVDdgmuH+dtpoYgr+WhT7U7pxRajtGFyZjbT4sStVYFQMAs0PmHh3ukYP
Y1BHqCA3h2EoPS6PvyLquVGajRpuvEI79Fh09wgzR9T5cHj2OS1zqTIAU4cV6EXu
jaLpDHWaL9K3g7OfFJLIucPLvY7zEiPB52rM7UejLyF0Rm+TuAqX/y/Ag5Etciqs
aZtco4V4nR5jXZM3cQZ4nMGqcNeDI83klWLmlZFNG+3f7KDWp3cXpcuImt+OsngY
lj0M1PO+/Kzx0bW5ujoKAPpIm/MLPg2bZZe5rbfJOTKQ99iHfMROa3CL7hyZ4uUG
Z6OotOKZc2YxUO35e5QDCBMxUiE33yoL0LHktGZTtGxyNT7H/wioICosO/HUaIGZ
xiTduFBMDXLv4ZAmbpI3
=tcK9
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--

--===============1616363496927169819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1616363496927169819==--
