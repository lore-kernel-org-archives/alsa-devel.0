From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Use .dai_fmt for setting
	Haswell BE format.
Date: Fri, 7 Mar 2014 10:51:38 +0800
Message-ID: <20140307025138.GX13126@sirena.org.uk>
References: <1394117766-7242-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1394117766-7242-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5103400098814856673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5EA226594A
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 03:51:40 +0100 (CET)
In-Reply-To: <1394117766-7242-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5103400098814856673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XPX6T3UXHpsvYx46"
Content-Disposition: inline


--XPX6T3UXHpsvYx46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2014 at 02:56:05PM +0000, Liam Girdwood wrote:
> Update the Haswell driver to use .dai_fmt in DAI link to set the
> format.

Applied, thanks.

--XPX6T3UXHpsvYx46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGTQ2AAoJELSic+t+oim9y1AP/RN8irG/sSeAo3FE2u/hU/PW
NUnXNzjMxRsTA4qUz1Ff1t/5/KJwX+NV7Ty+lJnEIdHaMxnW7Wp4ju4ek4TLIhEZ
XAkUWsL1D8o34UMybrxyN07ORl/1FqhIcdP0Q/2PxaCniY287EaMqVpzeVeAgwS8
QXRNhh8+/tsH8QNNoH/dF7hpAbdMCmQ5tWCxTf69rtDcwmZh+ubtaOJWdrwyl+qP
9VehWamgWEGwD6nhOX2n+i5Pdw0xl07ivQaI3p5yZt9lOWISq5wu3DRE2D0mxrVZ
BWvFoBqjQeeG2sZGg5CNoG7bbcF6UPeYR/D4jfjZCpCBNyefIHMwW7Sb12rMU73W
tB2ToBi3+jcrbhT+e5egkpWb9GtXxgJjxBmp5rigeANPQztRCt7Yaj5MOR4KHbh2
kgEwz3ArI+4MwmO6jJ0y5DX6cAHXkcO8pNrAiXqRpeBEC/9l2hn/hd7QtOQqzkZ3
eTSKA9BZpi+SCM6wyzKbeNJbgtFJd8cdY5bwRYoAilCUct/h4ZLEFq/IdhPUa5sW
0Luiq3l9Lpg0xmog/sBYNIV5gI56X1tUIoHxerNnlTXn/GbV4lAku+j+c9ctcmr4
ZwhQAAPnRrdoEeGRu/gJUS6pNPVYXdvHQ5efhJLqXFL0JZybQ7qt8+qKX10SRPcC
szk31ioER8vnLmbW2/EV
=zPpR
-----END PGP SIGNATURE-----

--XPX6T3UXHpsvYx46--

--===============5103400098814856673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5103400098814856673==--
