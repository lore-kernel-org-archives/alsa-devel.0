From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] sound: soc: intel: remove unneeded
 dependency from Makefile
Date: Mon, 12 May 2014 21:38:18 +0100
Message-ID: <20140512203818.GN12304@sirena.org.uk>
References: <1399526771-28422-1-git-send-email-prabhakar.csengg@gmail.com>
 <20140509074942.GA19551@mylly>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v4oV8TgUiTp+fDAp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140509074942.GA19551@mylly>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Lad Prabhakar <prabhakar.csengg@gmail.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--v4oV8TgUiTp+fDAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 10:49:42AM +0300, Jarkko Nikula wrote:

> This hit me too and was introduced in 1eee978f4258
> ("ASoC: Intel: split the pcm and compress to different files").

> Vinod, do you have something coming soon to these Makefiles or would it be
> better take this now?

I separately discarded those commits since there seemed to be this and
other issues there so the patch no longer applies.

--v4oV8TgUiTp+fDAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTE3AAoJELSic+t+oim9cpQP/3NCbmflmhIY341f4/NE1GaH
22Dy8eIQLiz4LS0N/915XXgasiSpWDJpUfAz/NrUosD8eJdDW0A6vBQCpjfHAD+K
xmP09skJh6DHuCIadovifzMXyQZkb/wuZp6DtnCpsawp8JshdVT07Ou82LofNxbT
mwLrfRpNcQptl4gW+JS3MUocwr0OZQWDLTI501jGNMioJ/XsCpM0YMPAi5aATLf2
2G036U7mv4SQqSdYQltzNnX7/APL4+yNZ21Jcb+pSgxlxIOCm925vu5HZqgTXylE
MSB9hCMNKYhTRA20tpaEKIcqYRgG2rSERbx+1JbsgnI6SIJ6crr/oa3MYJrWbPCX
RghyXg+EmiJSICjpXarZAwEamz0WCl/DRsfw8O1xc5UpOXItBG3SjjQyg828JEQD
hKrb5ffe4wq4kmHSNXkxa+8sCenxgfT5cIWYtGAfWeGbnfCI0yZUol64d1PYlapY
kZupzbDAQGtnJpDuFWKyzeLxDbrVjVVBuzjD1+0eaNRgNuzIM2fX6w6RERW351av
QSJdeWUUxNJ2uWrFWu5YyYBW/gOQqA9YnZC0zfRdN+yTbPlhGE5aAEvDQyGhzLfl
73QZRDR4fxjfQp2ic8i2QDwZMPMMgnnguhn1DbsDLXcgFemMUkuI4j//kqHk44yr
YTpBRNzz50rgZlY+4rpK
=5UeW
-----END PGP SIGNATURE-----

--v4oV8TgUiTp+fDAp--
