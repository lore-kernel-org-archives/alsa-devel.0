From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3] ASoC: rt5640: change widget sequence
 for depop
Date: Fri, 23 Aug 2013 17:45:27 +0100
Message-ID: <20130823164527.GB30359@sirena.org.uk>
References: <1377224966-27426-1-git-send-email-bardliao@realtek.com>
 <52178970.2080406@wwwdotorg.org> <52178D4B.1040101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6198081979635698327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 074CF2655ED
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 18:46:06 +0200 (CEST)
In-Reply-To: <52178D4B.1040101@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6198081979635698327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2013 at 10:26:51AM -0600, Stephen Warren wrote:

> Oh, but remember that this patch depends on the following from
> Lars-Peter that hasn't yet been posted, so this patch shouldn't be
> applied until that one is, or it'll break things horribly:

Ah, OK - dropped again.

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSF5GkAAoJELSic+t+oim9OHwP/1HFNlm+JY6eI/ZwvGXlRCBl
bZqHyXI+57gR3a6rAfOVbYDOI1dhdnQjzFV5G36yUXsse2J2Q5CIYeiZm4/pRXrl
nDYz1x0+jPSCEzKktNymGRW7ymkh/8Tg1OhwDXrsGUv8++6s+wiPO33p/IoOsDg7
D4XoOsbsFYu8l50tq1Vs+2OJFCVUIQZ/ZI5+Op0cTQl3DQ+aXB+Yi6UvEWBCBkoW
rL3ANsM8zE7yxWLOosuGy7meAGA/GQWksUlD94M0jH6Pu4CNpxb/5X48839cq0jU
wKQCSLvaYSnQVYQT0jao/mZRJ/tkjo/gch6/7Vm3XG/2uoE/e38sy00BMn9WDkHT
ET76M899mmYsbTQkX9T6srKEc4DXf443nIiM5DlaXQ99M4WLDTbnER6+5K00/G2N
HTDfBnd30Jnqkd3DzyTCxklKv88gJZZrDMiiIjyGMfmicTlGQsqQkgA8UaOaob+S
f2QZ7toCwO+EqfvyQzdshI77i6dmCo22q4QidX9+JuX6r0j9p9xAUcgcgHTp1aIH
CURhLZ3InyDPiXM4AQTJsSqHKgtljsrvSznFzHPMJTqUz1wyAyB8FNSYH3/1ob77
65BL7/2U9MFhCvGQ8FBFWZm8+NFpqRFisUCUimDz5BTT/db74Mo58sK0TvGe0P/T
okNf/o8kvLpEFBqIEUTZ
=hx83
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

--===============6198081979635698327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6198081979635698327==--
