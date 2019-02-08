From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v5.1
Date: Fri, 8 Feb 2019 13:18:28 +0000
Message-ID: <20190208131828.GF6695@sirena.org.uk>
References: <20190208125344.GA26529@sirena.org.uk>
 <s5hd0o24dz8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2797556663566106524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5EB267492
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 14:18:30 +0100 (CET)
In-Reply-To: <s5hd0o24dz8.wl-tiwai@suse.de>
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


--===============2797556663566106524==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 08, 2019 at 02:16:43PM +0100, Takashi Iwai wrote:

> This doesn't seem containing xilinx snd_pcm_lib_preallocate*() fix.
> Shall I apply manually onto mine?

Your second mail seemed to suggest that you wanted to do that, yeah.  I
can apply it if you like?

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdgaQACgkQJNaLcl1U
h9AUBgf/Y1M2O5TUaULULW1PW7bZaGuoz4bJEJlOPQMz2Jxis1NEpu3bplWE590X
y2hbkc+t6a/RVKOu67vmxSsbvZzUhy31cMrF7BnCE4kHWGa8lRHZQPReENjBok7k
/h5hNuXH5CflaKmH0a3wXPKRweEjJdPjC5ltYtE2+OlLbZVKf3zzyYY4Kxgn1W1N
1IyBWZvkp3CPXWD3+wkyi0sPcYamj8PBIvNTzVzsN1tzFuse9vTb9rghCJ/AiCG9
T6650G7aUwsPh9qkzCwnGa8RXsjl50N79AkfsZlt2chdaq8kT9ZbtnAcmZnoxtQP
VriPKW8he6yTeART47Z+HfCHvnYACg==
=5FkK
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--

--===============2797556663566106524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2797556663566106524==--
