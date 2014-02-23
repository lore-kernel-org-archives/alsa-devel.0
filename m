From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 064/102] ASoC: ak4641: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:48:31 +0900
Message-ID: <20140223024831.GE25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-37-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2307597902110544097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F14B2261A61
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:48:40 +0100 (CET)
In-Reply-To: <1392723517-12772-37-git-send-email-tiwai@suse.de>
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


--===============2307597902110544097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q42DwHUcI5a+9iZz"
Content-Disposition: inline


--q42DwHUcI5a+9iZz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:20PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--q42DwHUcI5a+9iZz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWF8AAoJELSic+t+oim9dogP/16I3BjKgpUXiU3UBT8Ng09c
PbIMkDAnWmCQsq3KH2Nc811EoL5dMV0UyLfFyOmPHK+X4u9P/4WkqYpOJyEl+LLm
N42sTyTJna/AoEEgaAcM8oe6zkVI4XxGlKDhWwZjTwR2oS6H+Ne8ulOQEenqTTP+
pPgRem9Gd6aZ6OX7EWwhe7yIf9/p+0LNAebFF4bRIXJbB9hFjg/rVBNPtZF7kyzE
xon56ceMCIdykVTUI1KL31Oa3Sj6/KwMeDH8e7H/02Tn7sHtcYrayMIq85wh7uAZ
/9sdk0qkGhjcdvs89nkgOY3soUtbavzdtdC6u4E5dyyTN2Vg0h3Ps8ISzBrBz0CI
vk/Wm4UXoYJoBR5mGGy7DPJhDio+XBPIUQj7XUvSYdspngokWUj9vGzLmaofyBG5
Fn+IR+n9Wa3xFSQpqwj2pT4XnYq6ymLu5DVbC6/zaz6DGIPeWR7PvJJno7hwhXt5
7D8HNU4PhOCfHZSxvM8XmMpTe14/G11cpv/rTpZRBWwSQX3Ce8jHT8C95KKiv1wx
XmNMY/QFrC7o1WbQP1WemmmK1cZpiX/k0qD9srvoqusKXcmVJ6gakJY5xkOo8Ftj
l5Wuuv41f1XwqO9sdpSL1Gs0VHyH3RUnD3mcWLn1o9c0t4c5+slQ9Q1b1T1le7Tu
XxM6Z9MEwrk5OGSVqF32
=vA/J
-----END PGP SIGNATURE-----

--q42DwHUcI5a+9iZz--

--===============2307597902110544097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2307597902110544097==--
