From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/3] Fix breakages due to recent updates
Date: Sat, 26 Mar 2011 18:40:40 +0100
Message-ID: <20110326174040.GA20964@pengutronix.de>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
	<20110326173546.GA17962@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8686443569383885485=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0AB07103894
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 18:40:41 +0100 (CET)
In-Reply-To: <20110326173546.GA17962@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============8686443569383885485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 26, 2011 at 05:35:46PM +0000, Mark Brown wrote:
> On Fri, Mar 25, 2011 at 04:51:43PM +0100, Wolfram Sang wrote:
> > I wanted to get sound out of my mx27-based PCM038 and it failed. I foun=
d two
> > flaws which were introduced by recent update-works. While being here, I=
 found
> > some redundant code.
>=20
> If your cover letter is worth writing it's probably worth CCing to the
> people you're sending the patch series to :)

Yes. Do you (or someone) happen to have a script ready which sends the
cover-letter to the same people which get later added to the patches with
--cc-cmd=3D'script/maintainers.pl'?

Thanks for applying,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2OJRgACgkQD27XaX1/VRsj+ACeKRAvMsl5M7vM4Xf7sTCNXogn
i5cAoJlIeXFT04a0lq6ROLSKkQxzw9vG
=VAuY
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============8686443569383885485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8686443569383885485==--
