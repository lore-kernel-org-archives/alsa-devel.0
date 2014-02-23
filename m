From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 057/102] ASoC: wm8974: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:42:33 +0900
Message-ID: <20140223024233.GX25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-30-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3225446965081252610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CA08261A72
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:42:44 +0100 (CET)
In-Reply-To: <1392723517-12772-30-git-send-email-tiwai@suse.de>
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


--===============3225446965081252610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+2xxXFcoH1/fp7Az"
Content-Disposition: inline


--+2xxXFcoH1/fp7Az
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:13PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--+2xxXFcoH1/fp7Az
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWAWAAoJELSic+t+oim9+44P/RejblX6DNLX/PWkXF7a2xo0
nu7Ij5aIjRnUG+X9Fy3/JiMFA1cIFpo+/uYtkCZ21Fc2Xt++u3nPNqlrAeoZxHiz
JXgi68sKTaIDuaprfIMSNA9+niLu7fHNgWMHYZrUOExuR/pS1I/AmOYZ1F8spAEm
vqsXA2Z4q2iuicBNuttUDsZIy3wTSLTuQXh1MLkvQJxs61AF5IVP+CRI2argcXsB
whvBIwABOU26Ga5bhd6tpB+4eaqeWICYdLYJC/ifXRhdBjJdjw3uFESwJ1drlwhL
T+vL9N/bpKN2s+DMeevJ0KRczyynKOYI5Im5GHa6botIQzznlwfisu13njLXzYFc
9t04I4s09dXzbthS5e7E25nvncX+vnm6luQjpASWyT8fGXbO0/8HegK/p3JN2bd4
vU4UPoiKX6mauRJMu8WmctZG1zMSc5ceioA9euuE9hW5nPuSVxlmg+Hx42P7/71X
xnzBSBOK0cfua5N3eNxb1CRJEhgndAoH7u5r/07n7MAb9kpbwcXq+d9A6hD3a7CN
tYz5kFzd+ro0Wg618+/Wi+vlLfb+aOXsN1t+nOHorW1eZCoR2/Xn19BS9sntc0tC
UhlOEUhWEbyY6lw1ZJcN8Z3XId7bBeE3dOU8VaZnrkILgnCQbD4V2TxZvnoUQMBD
rZTW3KqpYZsUIBgp/VLa
=t+aw
-----END PGP SIGNATURE-----

--+2xxXFcoH1/fp7Az--

--===============3225446965081252610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3225446965081252610==--
