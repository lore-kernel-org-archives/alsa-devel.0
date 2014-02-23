From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 055/102] ASoC: wm8961: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:38:40 +0900
Message-ID: <20140223023840.GU25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-28-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3898062585228548610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94FDB264F1D
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:39:42 +0100 (CET)
In-Reply-To: <1392723517-12772-28-git-send-email-tiwai@suse.de>
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


--===============3898062585228548610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6eMXvFBn1dR7Tww"
Content-Disposition: inline


--i6eMXvFBn1dR7Tww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:11PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--i6eMXvFBn1dR7Tww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV8tAAoJELSic+t+oim99VkP/iDmBT9dPA8i4NcGhQV1tAA4
+11euWuE183JcJBHmNhqhQvI2KbIK6j0xA6Kk7tGfsLIw4lKfwpLV7/Wfpb98byT
EBJY5XZfJvPSQK4/DD9dZRhQgGe+rjaCblQ5M1lrWd/va1jRh6VbHNLWQZAizSKL
KUbl+7U++37mR4L5pnfNGbZrsyu7o/5Gwc+BG/ZbdSpokSgHjBAPt5eiW2ROOvNx
DpnlirkXsg9Z7SeMTNJJhuPWZV7m85O4dUpruGpbh1mm5/s1/yp8pUWGCi5PzF1T
AFmxLAy70jC/TiproBFmRvHamYb4KHbKlFRdy0O5OGnfMjmgSXQ53fWzeY6F9q0E
M3vQcbwKp1X2BN5sXvrFB/yTE1cMewtgTxHAHedTiFICcN6+gi142tg0BKGPpe6N
tpjng1oiIxuU2SPOawUnQt6YSBZascDN1HDGR+C98RuT2dXiZ0VjI4T9vE5sCgeM
sc4ds7ZO965Fx2QHYn1d6udDwbOQKLAW4ED/e3KoHEhYSsLyVPxdyLRRZOVIy+DA
e5bkb//g8Qt9UeR1RxxbN+kJOCLJi9Gbr8YjipaPMqLmFBY4d0UC4y9GAFigXQTw
1p3mP0P1JE7WkBVffG3gIcl2zd2K/AuJwR5jVHGyH5p3LWNG6J0FWN9JK/FAbVC4
o1Xj844AxdgcmjOVytPL
=OxlS
-----END PGP SIGNATURE-----

--i6eMXvFBn1dR7Tww--

--===============3898062585228548610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3898062585228548610==--
