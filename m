From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 043/102] ASoC: tlv320aic26: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:28:33 +0900
Message-ID: <20140223022833.GI25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-16-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0032226941543141486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1372264F02
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:13 +0100 (CET)
In-Reply-To: <1392723517-12772-16-git-send-email-tiwai@suse.de>
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


--===============0032226941543141486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDuE8pp2+RlIQOrG"
Content-Disposition: inline


--vDuE8pp2+RlIQOrG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:59PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--vDuE8pp2+RlIQOrG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVzOAAoJELSic+t+oim9QnQP/iyBkjgInl+J5D14Ww3KYdpY
6IEmLulK6A/UgiIAqiKws6StY9xpLePmScuQZk7W7dLGo0eD3PDBQh+5V0icxKpG
a9XJfgSdbjAHUZ/TCfzJGkUblV8LnjGVZim9LS88/K5uUg2vGWNnt21puUA6V8Yf
PEFceL6OoY+oUwB8mpWkclVc4TjiEM1FKN09rSNO+0no64uvyPqAI/kLNU1wUSiv
s8g52gVIVw2bx/8zTWcjJ4KnbnVyXbJlNKYyJnbSLjsa905EtdgxZNUkAPqu/xr2
s+wPipdrcTkOZSw2szCnEMCHfHLgfBN+SadfN4Xo1RsiAm76EhhAQZtw5Rtpsf6e
v+4TtBlfiRe0UmwjharT1yeQ24611/tVR6PDAZwDHXQmhCl92+dtUrwcGs8rvBlQ
kO2nopQFUbfp6Zd0wxeq1wnKfbsy8v3dWxx+zPoUnnXTSJ3VA3a9t5LU37MTo2T9
wbZrIUmeozkeEXfi0F3etrnjFgrss1dzSXbnNg0dHkpXQpmjJp/O+4wfLD+QuHy1
hyLB2I3l2YhwZ4KFLgvazfpUgrgiNCrrI/9os8JvnLbYseWTTMCWVolIs7nsKa7J
bphnAbW6LdpbRgDIKNP8Tunl8dPzv+9msSai6WmM9xW3wPJgGnwby4lCWTSSyp5Q
m6ibpuK+7Blta6wgQF4v
=H9XA
-----END PGP SIGNATURE-----

--vDuE8pp2+RlIQOrG--

--===============0032226941543141486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0032226941543141486==--
