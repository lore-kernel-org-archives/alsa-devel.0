From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Use
	devm_snd_soc_register_component()
Date: Fri, 10 Apr 2015 11:05:44 +0100
Message-ID: <20150410100544.GG6023@sirena.org.uk>
References: <1428602201-17923-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5553113232101946972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C1632605F9
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 12:05:53 +0200 (CEST)
In-Reply-To: <1428602201-17923-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============5553113232101946972==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y2rxu8draGKDk5bN"
Content-Disposition: inline


--Y2rxu8draGKDk5bN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 02:56:41PM -0300, Fabio Estevam wrote:
> Using devm_snd_soc_register_component() can make the code shorter and
> cleaner.

Applied, thanks.

--Y2rxu8draGKDk5bN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ6B4AAoJECTWi3JdVIfQrN0H/iYeaiDsy8kZHu7NMFljNAzF
6krFkiCh6gg3x2eCp8pPPj++WGhfTKi4bB26AZApD/yqA243/82VnVD8UlkutX/2
Um93PKsNeFjKr9zTG6mdbzqJMfzJQDlllHRvDjrSdwaVQzpPfjARw2WOu8B0LdMf
HXeTJVBz54DVSfFmeg8egMxYsnHLG5Xg36uC/13Hb94BfQhzA8wC1Te4wE7GNUeA
DAwZHg52f0UpWcbZhIEvyNbL98qTgxhMnUrmxVmS+idcvH871xXyznHhKXoSP7di
FmEC9AFvSBAvstVFW6Q7kM1p62VP6fCBI9N2lKfv/0RbgfB0g26ESzqn4EsPL+w=
=OjTc
-----END PGP SIGNATURE-----

--Y2rxu8draGKDk5bN--

--===============5553113232101946972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5553113232101946972==--
