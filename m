From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 073/102] ASoC: wm8988: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:04:37 +0900
Message-ID: <20140223030437.GN25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-46-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5104622574453522171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 247062650AF
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:04:47 +0100 (CET)
In-Reply-To: <1392723517-12772-46-git-send-email-tiwai@suse.de>
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


--===============5104622574453522171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxwCHDD50Sxg6bJc"
Content-Disposition: inline


--wxwCHDD50Sxg6bJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:29PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--wxwCHDD50Sxg6bJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWVCAAoJELSic+t+oim9RNsP/2E6i+7Ml6lKl6UK/a5IOOL5
lStklfKZ3rPds0TQgTm44pbRMB3I00WCixB2s/9R6NVQrjDDxV1RjzPmNJjeHv5R
+xqBhoHghp1nqGHy7uI6hPUdGEasJzCiQgh1oRPBA8vsr29q+eJU6ZSsPsy3IMrB
yO10cVcXPCEdL931xcZ17uPqY8K0ihUrvcFyZU5rmYvEww2xKZWuR9ZOWvsYQEyd
PDCvInUlZB63gzcUNbNPqK49giqFatedGwxpZiXWI5UkrYL3PVXh86ykNOdXnXTg
ARMNF5+klr1JDo6D9A5/YS9JTS12gOOUqXHysbp4hvjFqBk2SLmii5R7+Tg5OyAj
ZwCbhNggvYhYgVC6TsNlCEzKxZsAGLgw4fOSYjxKiiMAEScPLb16DeF/ZbPMDawF
emYV2kz29KC7OKOjUkLhkzc8Vb8TrP+NyUu3XGq83Ql9lvOYGj0uInhb+X3cPoLq
Y0WNcZrvgB3i6fXqIiZ7r7OM0ktIupp7mYh6clQnS73thuhmCT5G7Em7poyr+khB
0O9lhNuH92YUIJM+KCHYGxTfRRBDPnShKZOsGyc8sM5hfVYjAYOdPoaUqRdpJdpV
9onSStaSGKzuxb9SRA1RiOKwYErtBKMhu/QyOuPBhdJ6OZpkvtEE2uTHR2IJ2SvM
33f/xhC0t5uZs5yyid1y
=VK8/
-----END PGP SIGNATURE-----

--wxwCHDD50Sxg6bJc--

--===============5104622574453522171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5104622574453522171==--
