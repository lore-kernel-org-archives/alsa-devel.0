From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Using UCM with PulseAudio
Date: Fri, 15 Jun 2012 13:28:41 +0100
Message-ID: <20120615122840.GF4482@opensource.wolfsonmicro.com>
References: <1339728813.5228.48.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1746290852155509894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 824CE24784
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 14:28:42 +0200 (CEST)
In-Reply-To: <1339728813.5228.48.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, pulseaudio-discuss@lists.freedesktop.org, Feng Wei <feng.wei@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1746290852155509894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 15, 2012 at 08:23:33AM +0530, Arun Raghavan wrote:

> Finally, a question also related to modifiers -- is it expected that
> there will never be a case where a stream that requires no modifier is
> being played while a stream that does require a modifier also exists? If
> not, what kind of policy should we have for enabling the modifier or
> not?

Yes, music playback plus ringtone where at least ringtone would probably
be a modifier.

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2ypwAAoJEBus8iNuMP3dWV0P/RMhdj8oXgIf5hCeRVwgQ0LK
7zCbYyQ+7voenJeNN9EDvl9OC1Dc1dXYKWl9OXB4Bzts61fJ5TRC3CFo2X9SgkUn
NtnCwm6JRpbFPunIufvp/+jqEZIF0wCHhK1GdQjNx7wEYM0OWGG79tBzhrZM1ffO
3IrQaWxurOQ4lOTcoAU0KDmEy2RzZjy4XQWTOsP/vcvgSZvfMfJiB19G6FRg7+DD
UGUD+vVVdQe1CwJCIXM4qySMClWu7XJfDIucXcjm32foAdXTVj9XT2WeO0oiEnSW
WKSf0DD4NhNzO1Ho0VOyon9JMh3TwGyUX2bN+qlN2a4KGjuYGe2fsxQKb+ASSIw1
jDlKp1rdROSrspvk9xYspXDplFgty5exSC3IpM/gZt87Rhz9p16rLRTclspZOFx3
tbtULXxRTbbirDXXOYDKfjFjS2dG/mY2nvcaIyb3ecIhg9n9XiwMckfviQnSFe+z
8zZc0RqMNkFmUZXE/2TIKQ9pQa2nTF7sbyaaU5A698ysaz7J9cs0BrbecGULO56R
3As+5NCWmZ0RgAR8mB8jO6seGoImtCQBxcsv8RBlA4TaqagUAXmBjPMZXu1RsZhE
bwyfzjN2AA2jeoXpdiefrdgmX74TwVNlzofLwPTKpNoYoWjg6yvecp+tZxcpPK7b
aI/KA6AKj3FsMJmD419r
=UPPQ
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--

--===============1746290852155509894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1746290852155509894==--
