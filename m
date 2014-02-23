From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 042/102] ASoC: stac9766: Use
 SOC_ENUM_{SINGLE|DOUBLE}_DECL()
Date: Sun, 23 Feb 2014 11:27:40 +0900
Message-ID: <20140223022739.GH25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-15-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6107913120489569956=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC545264F0A
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:19 +0100 (CET)
In-Reply-To: <1392723517-12772-15-git-send-email-tiwai@suse.de>
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


--===============6107913120489569956==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W8NyRpvKkamwD9y8"
Content-Disposition: inline


--W8NyRpvKkamwD9y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:58PM +0100, Takashi Iwai wrote:
> Just replace with the helper macros.  No functional change at all.

Applied, thanks.

--W8NyRpvKkamwD9y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVyYAAoJELSic+t+oim9t7kP/34vBQxwJtfJmImwRCOXtG1+
DRsjX24mYD9fP/aXN6Fp6ZMaC4ORyV3z6qbysimqt/Eh77Trj8WQAoVjUIs3kdGd
PQkEP5bLBOWI7+k8BvVS90prQprUbyB+9BoPWv4SbzoNUz17jvsg7ZVbiPd0jkT4
2LcHVv6uSe7/fqwAwcZs/7G9QqaxnIeacAvNSAi+Ib8E/vgWBMkkT6D1HjKbMDcB
k40rU2TisYM7U0AsVTcRjdKS6E0R4cPdLCK1SEH45c2EUYNGbtyNjkWj1XRraOZc
5YzgoYsemFKueasU9ORfjUjp65H8nAwv1pfrr1/u7t2nt2dFdgCQn2Y/EtS+jQDK
uMEtdqurWcrCja6gDdKMXe7JPjC95K8sU3Mf1TIXKrg5sjuuavUphqbCS79qUFZt
V4PC/90RCUMmUV76sXhPkKsjDH7Xw/gqhn8KH3MkRswNM/79x6DwWiDWkPyW5dcd
gaek0uhDHxMie8kbfmefB9nD0/4YiDO7UpJiAmJOugxtWjVmDmAHJldSKuYdNsUf
or695YdzEZfrmu2J5oE6aYy529QGhp0FKep7wn2D60qXDH+l4mXzP3SaNX3Iwfi3
jPOxnCM8dPeuYBJk1Li3O5hBkCabc1ZiO2NgP8DkF2HieUN4x/0FmYYyI7hcVeYr
0tlP/mwvFQ5QU4D79KXB
=+I9I
-----END PGP SIGNATURE-----

--W8NyRpvKkamwD9y8--

--===============6107913120489569956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6107913120489569956==--
