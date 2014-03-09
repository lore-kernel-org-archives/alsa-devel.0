From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic23: add missing
	EXPORT_SYMBOLs
Date: Sun, 9 Mar 2014 08:05:16 +0000
Message-ID: <20140309080516.GK28112@sirena.org.uk>
References: <1394271066-25380-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8179412844282941918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9B5C265546
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 09:05:25 +0100 (CET)
In-Reply-To: <1394271066-25380-1-git-send-email-jcmvbkbc@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8179412844282941918==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OqZxW6Yu4sgZZmrd"
Content-Disposition: inline


--OqZxW6Yu4sgZZmrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 08, 2014 at 01:31:06PM +0400, Max Filippov wrote:
> This fixes the following build errors when aic23 is configured as
> module:

Applied, thanks.

--OqZxW6Yu4sgZZmrd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCC4AAoJELSic+t+oim957EP+wUUt4sTwT9kmgYPfQS14qqm
bDA0B5+zTrdho10szfSVAiF6uStLsxSyhsxqm5YZq7sZfcxcL8Oy2pG2Fh+25ZPR
BXLkz2bQXx+WYjhp/HLS2omfICDiN+jVIIg4BKE5atXHuGc9hDDGXCm9URhhSPmE
2qX3ObMxegLp4ZkLNt73TzOr8T1L6DBds4+/GjNJfBk6rRF74al87OPq7iyQFdoN
BDsPb2XlTbhH5mCujzJ3IWFHszlPZZU04h6MhKWH/3m74bYe1gyrBOr6F57G4/9H
+eiGzoA4YnGTiwIgvbr3DeGZhoDL4k4tOC3A95QKE7qrg2aYH/SAKHoMJKOtAAf+
iQ4O4tHLnfdha6jlOr3QLAQfYZZKmjJH/6VfZegCQu3SC0Hb4Pyyh8STFjD93Phe
2ou7OB5McX6iuGC2u1lH9I5rtWe0wJC9BZdjBlqu0t0xUEzqikiPLBvblDNLIvMe
l9vfuAQe1xkM9RmBB1QX23uz/jG3XpFUTGbKBQzY4m7dEjwganoJnao7DpHYT/IZ
CcW2FQ71wTg67UGsAkkR7Bje5SKkKoXj02UKG8k6KIp2TkFA6oLJaYphlyJ8OJRF
O2z504Si7un812mDrQS3w875X4TloHUbNmRO7N2QnkCUSnetJtfbF7WiU8Q7UONZ
ZRfVGGmNfaGJfS9gfKJp
=dgMD
-----END PGP SIGNATURE-----

--OqZxW6Yu4sgZZmrd--

--===============8179412844282941918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8179412844282941918==--
