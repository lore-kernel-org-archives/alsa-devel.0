From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 048/102] ASoC: wm2200: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:33:29 +0900
Message-ID: <20140223023329.GN25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-21-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7261540166084598740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD34B264EFF
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:33:48 +0100 (CET)
In-Reply-To: <1392723517-12772-21-git-send-email-tiwai@suse.de>
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


--===============7261540166084598740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zpx5Rz5PkYgiNBE6"
Content-Disposition: inline


--Zpx5Rz5PkYgiNBE6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:04PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--Zpx5Rz5PkYgiNBE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV32AAoJELSic+t+oim9uHQP/0R1ez1p4PpARYiGmjy/gCvN
+ROgt3vCxaocGaSLtGJZ2OwQeeqGVIp3Ssr0oGY/lF0EGf9pMEOXCPavrZjy16Hl
LvjrxEgdOH54L0PlUx73fjJFuZroHOkaNR8nPLONJiBkJHyWodbqtwsTPi+s5I+F
CC3TWhkDCuXAK7VGn+vF2KzR2Gwa5n0NUHXQ4Mmas+cG5pWRbmzPArKi618dOEvY
cvhmYMo9GM5u87mXFMsY+f0gdFAdz0ydj04M+mhDCSnl86f60Iq4jYnJqGIs/hjs
/CvJ6UO0WJqocMrBRXFyV92YuVS8DtJbyB9TP91W3mHMXAcgMhFClTkw0HMKjX5G
Clj0QeCgxytgjaPHC8XSmWB+QRjN3R2I1Pb4PotRTlyR74lpaW/UVsq2yEZEddGW
70iSseqgAwJRTCUPCUtdhlROJt70xBUyXZrCdU/8k25aoYzoDK+7gODayqfsK1WT
HVZJVzMGrA8XbQfQO8R4UNEV59jwgff9XimZpg121Fv9a2Bfmbl2cNmxdvQ31Phy
GOHM0CGcpbvjzC3HypQ2da1fOWxo/tbWWY4bUVARaENAOWYMgyFbDdEku0kdRb4M
EZKIT96c+z7nn3F5hQS8tc6YWc3iazzgXTlH2R8dpFgAPX/dRCxQd3A9/dwny1Nb
Bmwe9i+n4MXaWV3vx7ny
=p6gn
-----END PGP SIGNATURE-----

--Zpx5Rz5PkYgiNBE6--

--===============7261540166084598740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7261540166084598740==--
