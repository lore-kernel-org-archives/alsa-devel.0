From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SOUND: au1x: Fix build
Date: Wed, 31 Jul 2013 10:06:55 +0100
Message-ID: <20130731090655.GE9858@sirena.org.uk>
References: <20130731081519.GA18756@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8007982340921874340=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D6BB2610AF
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 11:06:58 +0200 (CEST)
In-Reply-To: <20130731081519.GA18756@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org


--===============8007982340921874340==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FIYk/R+LCB1TX+kR"
Content-Disposition: inline


--FIYk/R+LCB1TX+kR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 10:15:19AM +0200, Ralf Baechle wrote:
> d8b51c11ff5a70244753ba60abfd47088cf4dcd4 [ASoC: ac97c: Use
> module_platform_driver()] broke the build:

Applied.  Please do try to use subject lines appropriate for the
subsystem.

--FIYk/R+LCB1TX+kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+NOsAAoJELSic+t+oim92FsP/0DWKlYmPmIs+JEDPqSkX4Mm
WUk1oPAiIpWjeOH/hIt22UWFmGWTTDojuLCrigpvfcchLiLet1GchnmylYWQg59Z
FVgLY/nO7VivXbiPfzoORgxC92fFHnlOn9yYjUtLwTO2ZhjhHDOC5UXQGHmb55lp
jOrtFFjq46pWIpyDGIX3fH6Of1H7lNOvUT/CHkXA5oX39oJkGM8JpNQz/H+JH+qc
4m6UTiEfk3s9D5Pp2VjpHV3YVTNLjMIxYrNy9jTUSPeyweQj97CFZdI6F+sd/ZGz
R4nV1vUMDf1bb4o7KPSYg/F3fcAo/2Jk+FYa+tiCI9T0KB0PVb/M4S+ADZWB78hE
Ap0SvKnEoolERoj2sZSvTROeEl2eRli8FJ4j9cqiCKx5RSpix4rziuuiL0OWl/Aj
dZQFYZXwho0zWl1ADJovfsgEappfANGEzLkTZXNbO30NkojnpC6v8/5wq58yqjQx
dfE1B7lB/dLW7M37qPhJKHg5NlbHhxJesvHq1iVViMUsw2d1CVs3TEQnlME/VdRf
2RMz3zc2CGYzpQ4sSImQ0W5n9gVv/BAlbaVUf8cIyru+RNYcno6+jrdWyPx39Z+I
2Il83YrtfaBHhODrfbbjKYTfLSFMhfdrBMt6DnbNGoCcEQsd5xcK52Zu12Lv6XGk
FWxgqUBmpkj9mFSuMMEr
=w5Dy
-----END PGP SIGNATURE-----

--FIYk/R+LCB1TX+kR--

--===============8007982340921874340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8007982340921874340==--
