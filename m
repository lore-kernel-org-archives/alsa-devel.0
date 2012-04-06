From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tegra: complete Tegra->Tegra20
	renaming
Date: Fri, 6 Apr 2012 14:18:24 +0100
Message-ID: <20120406131823.GC19424@opensource.wolfsonmicro.com>
References: <1333662894-22672-1-git-send-email-swarren@wwwdotorg.org>
	<1333662894-22672-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5463971847511856515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD7CF24440
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 15:18:26 +0200 (CEST)
In-Reply-To: <1333662894-22672-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5463971847511856515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 03:54:54PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Rename Tegra20-specific Kconfig variables, module filenames, all internal
> symbol names, clocks, and platform devices, to reflect the fact the DAS
> and I2S drivers are for a specific HW version.

Applied, thanks.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfu0MAAoJEBus8iNuMP3dKTYP/2uECndmVFH+9F7bhnzI5Yle
mI8Sc379BSrJQK4MdqOkQmr/iQ8f/wnwq+J37oATIXLponSEecfhefRCrpUoo+Wh
58JsrM6FICFOQnqI4rIS+WsGXEoQ5CfNjEbUwKE3xg3sQmHOFc/t717/CGkk5DzS
2JEuoBSyA9FbdbNwl46gwrKnJ/zr2pYZ4HMqW4YBQqpa7Pk9xuX48qSetOpA0Aqf
dKsjS3+Z9V9XHqyJ5NtoNluYOF29ohX9BQUST27MnAR9dEqjD6E47wrq/L6J/z/N
mdfbo9lx8J4deY1d3zW67OU6qjNsF3Rc4bWixo2DmBbAsJJyljSZJNBqs3FXTV8s
lBztqU6NlSkBVo5wAnbZxudg1QRCEEK25hp1k6aNq1XzyltBelAvDgdRPdSUE/4o
srORruqsiAc4jsbpwmMo9eWFCRqJeH5tHwT8QdbmuregtM4+KmMEuMrG2DPOMr9I
pFt9cVBViqM5C7/yvK9oZkkDVRRpw5UVoQq3RMOyuk0fVIO7xSa8rJFi6HF8PpcE
YhkLAw8zL6wN+12IYz8AO17iUseM7QbzjOBy2jcnbxH2vOK+5HHj4uLqDh60etbC
KeVpJTMxOjkPpl7fJDOPBQbTm3xou/7llL5ARwe+HIPP21FCV2lR7B1JYulVn6V4
9NyISMpWmftOEOxm+FBL
=AOil
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

--===============5463971847511856515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5463971847511856515==--
