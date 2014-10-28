From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: cs42l51: make driver
	user-selectable
Date: Tue, 28 Oct 2014 22:34:37 +0000
Message-ID: <20141028223437.GK18557@sirena.org.uk>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1035117107108043438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A50D260443
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 23:35:17 +0100 (CET)
In-Reply-To: <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1035117107108043438==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EM2WAHSp0JAC5kZ2"
Content-Disposition: inline


--EM2WAHSp0JAC5kZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 05:08:40PM +0100, Thomas Petazzoni wrote:
> Since we are removing the Armada 370 DB audio machine driver to use
> the 'simple-card' Device Tree binding, we can no longer select the

Applied, thanks.

--EM2WAHSp0JAC5kZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUBn8AAoJECTWi3JdVIfQK48H/23GrSYAsD8f4ukiUAFMNiXf
haKuj7IVwnI/18mZVaG+AP89wBWSlpgEFnxwT6h+D//9RUJkRn54AvVu0E3OeYNU
0ZpbeC5mMS/mSQBFT2CSWy3EqpdnL1x506nWFDrEXx2pCYlq1RyrxBO74M4IOimb
GXFRBfNUR+vMoFWnqXLnzOj5zfXen8IOXvptYvXR9pNMY2t9WOTKMJOPCWfY+sHS
uGoQtKBopx83TTFUNUbzk6HJZvwhMt6+l4yjotuNkPVR2Qf7p5NiDE7UduynyBI3
cDpQMC+ZQSNOZkKkDvbuogYurKD69dyGLtoTaGO9KF+Wo+aO5gs3T+fOoV9Wk7U=
=+ApD
-----END PGP SIGNATURE-----

--EM2WAHSp0JAC5kZ2--

--===============1035117107108043438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1035117107108043438==--
