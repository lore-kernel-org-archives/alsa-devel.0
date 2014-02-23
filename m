From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 074/102] ASoC: wm9081: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:04:51 +0900
Message-ID: <20140223030451.GO25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-47-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5857011118864642172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA839264F28
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:05:03 +0100 (CET)
In-Reply-To: <1392723517-12772-47-git-send-email-tiwai@suse.de>
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


--===============5857011118864642172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qi0WovVLX58BkhBU"
Content-Disposition: inline


--qi0WovVLX58BkhBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:30PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--qi0WovVLX58BkhBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWVQAAoJELSic+t+oim9OB0P/jccEIDPgwMePyM0uFYxFbH4
GH4FaCEntu+eQgb8QkazvZ6LetiDSPsSMZPSKLbLCujIy7zHnt5VqEp/t4Iu+AIA
oZ2ZuNQ8zXSfgPWb7d+bG8vE/XfOlPOjuCiqySsObA5SXazoTRYWGpLJA2csdZxe
2HGXnQDd+E/w3WQbXSQXiRVqSlplkVx9D/w97tImkBiI8kbXgYS0QOH7qvzs49Xx
nvsjwgEHydcoRh73KZz557eFE8uhDJ3+gEu5SnnWSTiS+nAWyzDTgYZj5sm842n0
eFtGn/9e1kKXjm9+si4e1kdLncFOnGB3Wryqpc4milGrkKP4Y+lzEVQ1t+zEQNUJ
m9NDAms9b5T/rtuQFiCmaYwHc43nPb4Vz8yooLk41SZd85j32jmH8UdyPjOZSPRL
AGc7mHW5tX6QYPMZFmz+wXmegNfmRMOPtYwxnHzLS4zIWpXTKpvJYN9NC4+vEhs7
Ts1KlqatwGmXNV0TfOzVOneInKNaNdVK2vSyZroWQEa00y17TG9rLJKicV14gtJZ
kyh+wAged2YgCL9LL6YLIdsfSN/RQolNOqdKsUS7bh96keF1OD0CUtvXjQ4Afs44
lOo+Wbc0A+77RQ7seyjm2hMOXdd0U6fr/qFPWhs/6vjA+uq/RV2mRpdi4mk6Aymc
x+zmInLPmOROCkB+QiEM
=CE4R
-----END PGP SIGNATURE-----

--qi0WovVLX58BkhBU--

--===============5857011118864642172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5857011118864642172==--
