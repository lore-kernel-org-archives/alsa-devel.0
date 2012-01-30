From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.3
Date: Mon, 30 Jan 2012 14:51:58 +0000
Message-ID: <20120130145158.GI4882@opensource.wolfsonmicro.com>
References: <20120130133405.GF4882@opensource.wolfsonmicro.com>
	<s5h62ftqn8j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7945716140434409809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 703C8103960
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 15:52:02 +0100 (CET)
In-Reply-To: <s5h62ftqn8j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7945716140434409809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2012 at 03:27:40PM +0100, Takashi Iwai wrote:

> But this brings merge conflicts in codecs/wm5100.c.
> If you already resolved in 3.4 branch, please give it, too.

It's resolved in my for-next branch but not in my 3.4 branch, I'd been
going to merge up an -rc when one appeared with the relevant commits.
If you want to pull my for-next into your for-next that'd solve the
issue for your -next tree which is the issue I guess?

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJq6HAAoJEBus8iNuMP3dIBEQAI8E6ncU28VJ6dgFr7YaXBkt
nmLIXryXw3RgZSJDwMCeXgaqp5eluM/IVgGKkauCWqVL2QDUeZliE8KU8Gp2zPRm
nO3pMww48mWxzQ/CG4YOblBn8mJWVPzUSR8/RFsBWbNOLcxrd+EkMuS/ys2sLPbl
h3ybRdXLlyZFwPdfKMXLOSknEGyZ0XfTA4RGGCPD01pDVamBADQ4aY4CUS34Y2mn
D4/ZUC32NkqnmbBCq4Q7SSFlV7uXJ+jy3jLElRAUb+v3XzZPsgJAp8yVHtb7WzzX
coC2GSVoWuVUURpXnvySJzYLMmkcPiuqDooFcOad+BEtyQM1RpmVt48NvTo9CBIk
DgBdKybeVVLgD0P0R7x1Rf5eo0kVOQlHefFQ2LL2xVEr+9aT0JTgDUq5MS6XAJ0B
iHGu9uDQpytg+wRdPinTc+EoLhe1Ai+za4RzSUfQRht7AAdjf2BGO2KFcssF09PH
85B5FPHIbaZGgoI5o/KMUVf+0/xrsSUAMTIrZgVaC5JnP9BnRtolPgIJGtHf9jYB
0qOmlCBtTQQne2z4nmuckIAooOwaJFJzV5XvoFtOnM6cmtm51aIfeoux8NHeKmiO
JUrMmKn4oNqJo3oW1W1jI11fL4ajo1GNw5ry5Zc1leyumTPrWc1E4NC1afkKN1vE
+TeAm49byvnFQWXdzfVl
=xlpX
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--

--===============7945716140434409809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7945716140434409809==--
