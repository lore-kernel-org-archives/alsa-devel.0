From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: arizona: Improve ultrasonic
	frequency response
Date: Mon, 3 Feb 2014 16:10:14 +0000
Message-ID: <20140203161014.GE22609@sirena.org.uk>
References: <1391183234-13943-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1391183234-13943-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140203083730.GB13529@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8697147257149083944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B57462608CA
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 17:10:30 +0100 (CET)
In-Reply-To: <20140203083730.GB13529@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8697147257149083944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Ui/8jAYUVG6J+Fv"
Content-Disposition: inline


--2Ui/8jAYUVG6J+Fv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 08:37:30AM +0000, Lee Jones wrote:

> For the MFD change:
>   Acked-by: Lee Jones <lee.jones@linaro.org>

There's no actual dependency between the two patches AFAICT so I expect
the register patch can go straight into the MFD tree?

--2Ui/8jAYUVG6J+Fv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS779iAAoJELSic+t+oim9R90P/3hid7g1vgVIsGLAYIXmglSy
y8I27wnNrCVyPVVlCg2jm74OYbt46PpFtSgv7P7BepBRN1MtJ/6uWiOi+4tLcSPi
Xqmv6NSI6CSmAFxrdUk1Zr3byioe1Jm6mifDipVicLC+ZN0gIhEwRstpFJrHMmuj
nKDpMtAJlmZFVfr3QH+XuY5vVRwWKWl9XGCGjFfuPz9crRAXBPHkA/s+UkVdaj7f
zyuj6ynvMbkYuL3nAkz0cCunsyTKwVmMeP9MpYFjKwlQWbcd3tfYDi/R/PZ2l0Db
gWIqJtacyKlJl4znbbzS7kYZZWMBQnfV09v33WAvwUYftydLtWAR4IJcfSfNiwrj
xVDrSwqSCbzTZQYdvu0Ge7QP+q4E7rXfPBPYcJthMwUnVXAXi59fQVc7dvIBeI0B
upNqOUapaRcKF4rN2J72LKPmtGcPPN6RXUmKmz/TiH79PqAZqKwtdcRPqgYn3ZFd
Nb5h/XIHzACIoQg5A3sbF5xeVcw0E7rOVeEVZP8I5odComfwjSQgwIxS6GNeWoIe
QJ+GOIw8yA8u2Y2r1r0C0BO4swUobcOIN7VxEnMrdH43QVDvTr03RNpPHU3fvXlS
yYhByM1pzEkW3bNH1OwfswTnA2w//Nuj7tgJI0CWTUzjHXt01Y8K9BJzgP/X8BOE
5cO7thDX4B9zh6Dxo/OW
=eDPz
-----END PGP SIGNATURE-----

--2Ui/8jAYUVG6J+Fv--

--===============8697147257149083944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8697147257149083944==--
