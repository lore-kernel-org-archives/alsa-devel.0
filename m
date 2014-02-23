From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 066/102] ASoC: alc5632: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:56:26 +0900
Message-ID: <20140223025626.GG25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-39-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2707601908925305318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FC08261631
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:56:46 +0100 (CET)
In-Reply-To: <1392723517-12772-39-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2707601908925305318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fJBj1Bdbt38M/nmO"
Content-Disposition: inline


--fJBj1Bdbt38M/nmO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:22PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--fJBj1Bdbt38M/nmO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWNWAAoJELSic+t+oim9OLEQAJJrDWzlhWPOzwlQJlJ+scvm
O0pf03/ht52cv6xq0UnDFBguZy3kChACYGONDqUcwLd053dffe5GSg+6O2sqgym0
4sfvjAHFTgf9eAK4ZJfeUgYobyY/tzr+1/w/n4+HB9hqRaxj2CdYcEiYEzsweoyF
8DtuxqT7Q9Hc+naYa4BMVAzV/bNnqg30gE1nQAIJEgSacBwpRylyJgy6BRdZxR/J
+slSQXo99r1bJ612VYKTITBxqILZo0h0020xc6jr9JfzcGfiCW5FhNkVCRcENqrf
Q3wJlRlI7v5qfyBjZXQflyTgYYKewaWRuuUDII1VMcVY440W2Yg/khUYPbEx2iYl
+34zI+y3uYqCOnWb9cYWXw7gVi3UpbcdpgkwHsbq1D7bl48xXTcOCsLLFa0ttPfc
xKfLKUTtwwFVlYqxcTTS27oZrvtmbvShYb0wiAoKMktNtTK4EcrlcLnIyduqeLfa
NEpX0Qftl5rzM7XiPTo5G9o/U8lHoNYdZDnSxlYdqA1rQqW8ldIwq6puNK0vATdO
V5VmMI1EURHmPWuHz1G1RFBz+ZWzt8BDAgSckm9uKW4FkhIEdL0QF5SWzI9Tqlt4
avF4MPFDB02JazQ/f/IyDV6b3OceWcd6MI2qPbkL0caam9BLrprVBNLosr0vnbIE
B6ijWZXn/I2NTfR7+R9X
=t88g
-----END PGP SIGNATURE-----

--fJBj1Bdbt38M/nmO--

--===============2707601908925305318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2707601908925305318==--
