From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: simple card: Add mclk-fs
	property in dai-link
Date: Fri, 12 Jun 2015 12:36:04 +0100
Message-ID: <20150612113604.GM1921@sirena.org.uk>
References: <1433492346-29506-1-git-send-email-arnaud.pouliquen@st.com>
 <1433492346-29506-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5671346981290134808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05DB726680E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 13:36:31 +0200 (CEST)
In-Reply-To: <1433492346-29506-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5671346981290134808==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Content-Disposition: inline


--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 10:19:05AM +0200, Arnaud Pouliquen wrote:
> Add mclk-fs ratio property per dai-link sub node. This will
> allow to manage several codecs with different ratio.

Applied, thanks.

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVesQjAAoJECTWi3JdVIfQhEUH+wTNOLJsCCITQpgXO8pL4zid
nv9nO8bxLWo3FGd6cRAxnG/jY99sDcncmRpwkHff8fFQV8pFCERnD1KA6lzh4dzD
/QnUMC0S5/4GkxI4nCU9iZttVYH9VHAqDzaapUHHYlIBUTGWp5zpHJY8uGNtBiXa
X6O7mMkJQBSbHnr5DEVsk3bO3QA22stwQd9ol1+QYtjBviKh6Ep8XbjRHoUaD36d
oCqNTTlxmhQ70CjmFg2NmF5yIAFEyhGambU1+zs4TOrun6gClfpOF27ItVeyPZUM
ub6oNTQa/rNI8FVRe0z4nxjyGswQVssNhnbfG+7e2hdpHp7rxg67aFZKHFck/0w=
=hDwp
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--

--===============5671346981290134808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5671346981290134808==--
