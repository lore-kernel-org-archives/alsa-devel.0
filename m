From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: wm5102: Improve EQ coefficient
	controls
Date: Tue, 21 Jan 2014 18:00:39 +0000
Message-ID: <20140121180039.GH17314@sirena.org.uk>
References: <1390319888-27814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2870291963811730928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3C452619F2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 19:00:49 +0100 (CET)
In-Reply-To: <1390319888-27814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2870291963811730928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OtP5XuPTaeI2U+qV"
Content-Disposition: inline


--OtP5XuPTaeI2U+qV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2014 at 03:58:06PM +0000, Charles Keepax wrote:
> The EQ coefficient binary controls overlapped with the volume controls
> for the B4 and B5 volumes, which were controllable from either the
> coefficient control or the volume control itself.

Applied all, thanks.

--OtP5XuPTaeI2U+qV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3rXDAAoJELSic+t+oim9fSYP/A3D0y26wbsqcM8Bw/y12oeX
g/Z9v2dn+5DEV1raMwfCUvj2sq9aAY0TCUNVC6wW/ONry+hcGnXPXlAGatWysWGz
d+WW8H3LiEe6UMOO3x+pGBuEiah9qSBWV7onkwJv3CTmBPScjRwP9C5iF62ovL2L
RlWk0lcXpLOYtVw3jlFFjSlSBjTfmz+/b8YMZtL3znSW1PRGa9D0CGiqH0HKcIYF
AZdAgLS+Amf1fWKJV9lkznfrHiZ+cGCgX1wwJRIj/zxxscWn+cPxisppgLaAFlrW
XDQB31++sERqGk43q1pv5mECENHEtc7+j3Qhrrj3QA6rZ5e5xXdub9jkUmXCRSfj
J0XvLZEKBtUhVYrtl+Aqy2JY9gWIME6lCfiPdpUdm0qxE/KIp8j2wh0Zeg1nEQBE
hRKw5H/OL62P0QzqTDnMH13wstvfJS1zP9hZ+e2e7rvEKysosqn3ujSjso8URoom
lenLJsPBDZdG4mEgy106lXrJtRK8MJCqThJPDAudVnTKSiZpl8rajlrJwzH9vbx0
Fu3z4txp22dSGGkc27PECJ4UnE12ATCHX/pqq+xsX0AsRgudDPgUvL2+W9hRpW5k
b0Uy/kC9LrEFZLpJ7s2CDzgANrZbFagsuQIHH3E+tjU+Zl3RNNQYjZdZulS1dkdX
t7Z+9vofm4YqkpF0HKbN
=mVfs
-----END PGP SIGNATURE-----

--OtP5XuPTaeI2U+qV--

--===============2870291963811730928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2870291963811730928==--
