From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix compilation error
Date: Fri, 6 Mar 2015 10:30:29 +0000
Message-ID: <20150306103029.GE21293@sirena.org.uk>
References: <1425625652-31217-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6462096611955743616=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F9426057F
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 11:30:35 +0100 (CET)
In-Reply-To: <1425625652-31217-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6462096611955743616==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rWVjl9dAO3rg2Fo7"
Content-Disposition: inline


--rWVjl9dAO3rg2Fo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 09:07:32AM +0200, Peter Ujfalusi wrote:
> Introduced by commit:
> 6afda7f50754 ASoC: davinci-mcasp: Allow complete shutdown of McASP when not in use

Applied, thanks.

--rWVjl9dAO3rg2Fo7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJU+YHEAAoJECTWi3JdVIfQ8jkH9R+S7oC8lr0WGVI6BcZYP6bt
JssrImqjFu8Ul11WoIegTEdqlAXynAZVn7iVYUIJAKAR9ivZGdgzyg/R20swgYBF
b1fFjVA5d1pdm6kkEmvE8K0oAXqhqxHQiiFc8ikC5ynM3x7dYnFns5SvSXhP/7iq
MXBc9hYbSMwy8nJy1CZMZIfnf/G4iLNWHZvi+TcdsigjiRugaU7qvhXK328RQmVD
+PVz9qBzUNkpUb4I4cXD2sTbjhbXKIcdVEsxUXeMBBWoSBG4DkY/sjvk0+0AmTh0
7XAvOuE4EQyH/49RFj82++tmXVNxTnq5Uc7JFLG5mJGroErwOs4rN5W71s9Zug==
=8MWM
-----END PGP SIGNATURE-----

--rWVjl9dAO3rg2Fo7--

--===============6462096611955743616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6462096611955743616==--
