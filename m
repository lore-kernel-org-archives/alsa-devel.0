From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fixed wrong printf format
 identifier
Date: Tue, 7 Jan 2014 11:11:43 +0000
Message-ID: <20140107111143.GV31886@sirena.org.uk>
References: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
 <CAOMZO5AK3=d322K80a6Y16xWKFYy9dWJEupF6W8mqLxm0_=j8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5070337601713267917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA61E261723
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:11:50 +0100 (CET)
In-Reply-To: <CAOMZO5AK3=d322K80a6Y16xWKFYy9dWJEupF6W8mqLxm0_=j8g@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org


--===============5070337601713267917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l/rOZ+Iy8Lnw8x9T"
Content-Disposition: inline


--l/rOZ+Iy8Lnw8x9T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 08:08:14AM -0200, Fabio Estevam wrote:

> I have sent the same fix as well as I haven't seen your patch before I
> submitted mine.

I saw Fabio's patch first too.

--l/rOZ+Iy8Lnw8x9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+DrAAoJELSic+t+oim9dGgP/3VSCbG1JXmXstx77Z7ZT4vO
7KVgCsMJEOh0q8mqU2Xd9qKern+kIgsYPawkqgFHaXBdIjHWnXslyuwlzB0haKPd
Obtf9VL2wA9mvcCcMhF5SsQR6AtM66rKkRhn222u1VY6YuhXWl7zYeEpHNqGelKV
LIeAMq8e8vzKm/xL57/vYV/WcDCMv3Jc0wtMfCohUnbZp0Ij7HDhCPGxvjTKN6DR
1P+FfLJSuKMW/2R/C3i/NMvtMfkQjvajC4IJncrFXyPAcY1exRR4fo8djIYAbjha
bAK2t38G76XIQ2ekvV+mUMDH1DFVbDglv6SI+yUooT67cYcreUUy+ok/c0JDQNh8
9c3BKHEZedsxGEd1txJl6TVh6bC/AJw0ZMHj0fs8/ElwC7x+/CjjMBB+I0Au0J/i
0r9sX1PkR4eFtDAcUh8ReXU6DFGg7cucy9P99HefdCRHAdbp8d4KYXEFERR/o/cK
yFpTPtJfHyYGgafW+E4XA1yTqtvaiX0tDcfPnhwSSCRoXULaf7xxN4Icrnj2VHPd
1n7d+TsCNybQ9F4cxc+EvrQqYqtLcSE33C5JNvkygMlCsHUjumeuUUUVer5yoB5I
NC1FJ8hDz0+xM/7XtJz/eS6yDOQlvQiPjiSCUfNu4bJdtoHeEQrVC+tTci7id1wW
sZzMqA5R+UiaFKz+Zvfr
=30H7
-----END PGP SIGNATURE-----

--l/rOZ+Iy8Lnw8x9T--

--===============5070337601713267917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5070337601713267917==--
