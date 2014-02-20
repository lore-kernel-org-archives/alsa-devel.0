From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 027/102] ASoC: wm8994: Fix the wrong number
	of enum items
Date: Thu, 20 Feb 2014 10:33:51 +0900
Message-ID: <20140220013351.GN2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-12-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0816447088440877530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 36247265375
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:33:58 +0100 (CET)
In-Reply-To: <1392723422-12689-12-git-send-email-tiwai@suse.de>
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


--===============0816447088440877530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zI7p2u8k6uHMUvOB"
Content-Disposition: inline


--zI7p2u8k6uHMUvOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:02PM +0100, Takashi Iwai wrote:
> wm8994 codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

--zI7p2u8k6uHMUvOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVt8AAoJELSic+t+oim98w8QAJJmvYcBltYHL5ZoUyB0MX+u
0a1/r5OhS/TsoM9DIfihVOQSIPhqeJcqzpnMYI1myPSog3YZ5hWpUX+CBwJC9lM0
Zrlc5FGA36uHgoFp/hQax/GJsuAUpeSOmbgvssTBmD6vI5mVGKrXUIejHuYHe7bv
37JwJDNDyf4dOJy+E+zq6wT1nUaekdP3iRwzHBAFgaVtE3z0AlKQ0N6oia2f5aVO
GgSbVW2SIewqWunmZ4YzussKmqgWipRMNvoptvNRxk036SJxTQt7qccIRTnmV9Gu
0IKepKywIciRAaXhVSWCjV8lvcRrkQrawzPdsxnJXqf9i29fDPrQq/NGi+jwsr++
FYEWrtMlNL2Xe0j+x9royHdH4RDTjDlaDvYj269mAuDqenmZleNBniebCNhGZZki
wWdI7Tlw978uNlCgq5dKFU/IctSs8l2q9sWIQ2fXuRjdvbYx0/mLNoT7HRFtC+Sr
1S/gvnXNybR6lw2o7bif8jj44iLWrjx4CyiAGcSeB5Z//nFJA4yseNpC/5r6AtGL
FD8KtEIuHNwWL9uI31GEZbWdoYw4NDPL9hgIf9mm1xSZNIokSG0u4aqHTAzI5/dh
T3BC2BLWHT/9RwytPfAlkQ+hgE9G3FOi9pdWQS1F1cDAKyrnNQq4PY4h2qp2ZddD
Mz9weHEv2Hb32naccnBv
=svIk
-----END PGP SIGNATURE-----

--zI7p2u8k6uHMUvOB--

--===============0816447088440877530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0816447088440877530==--
