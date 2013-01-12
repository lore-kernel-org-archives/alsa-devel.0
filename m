From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: pcm: delete some dead code
Date: Sat, 12 Jan 2013 00:06:27 +0000
Message-ID: <20130112000627.GF7873@opensource.wolfsonmicro.com>
References: <20130110085957.GC23063@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4163802962875998667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB99F265062
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2013 01:06:32 +0100 (CET)
In-Reply-To: <20130110085957.GC23063@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4163802962875998667==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 11:59:57AM +0300, Dan Carpenter wrote:
> I've removed several unreachable returns.

Applied, thanks.

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8KjyAAoJELSic+t+oim9rqcP/3Iso7sBRHKSE1HdpRKyHnqP
ZpTdrvujFyKF99S4hWXaHip1xHpCLzEqfc3kOdG5tmngdQoBddoRasdiDBbZpgf4
fatUhYo7ZNsNCjImtaYpw1uoA1JgnUnYB8oOtZoy7bSHKHPHvigx+qyUd2iLMFnt
H2ZhFXjLJySxLDHPVmvlcfIWJxuI5c0G/2AMXfzqhVFOLPken3PwR9IMMIIF4Ohi
o88gTx57VZtWzSIL5y0ipY/FoqxvJpv2xoyDeWxsH3CI1kieQ2ER4HL50mCNxuo+
2PpvKoAVnwLVUM8MXUPw5Z/vUcrSI32r+UUFuKcgPw/z1Fw9QfXjgE+NVSW+PkGp
OiyRpcaiQBNvNLAvqI6px4idx6tr6B3uX6QDIeJoN6gaCNvJB8PYEzCK4mqjiXNQ
qcFu0WcG3fiyulKsSYqgze7WcEWUkzBQ5f4hE4nypAOP3ZbfLzuWo5oX1nOQPotJ
JE8VbF15vdw5jtUHcCcZq93Oufi8v6pehYzXKmmRUB0dmmvyaE9aV4/6U8C2lfzt
f1WKee+8vrQzj8KS5UvTO8YOs8a2DaxnALnX+almOiuPoyMtDkjOVkeSzDkyMwBj
01yqpMs9kA18zUKg0le5NJM3QBc85k4xYq02nkKDnx9A+KLjF8PFNYmaJc7jSU9n
FWSSj2G6pu997y81V8iv
=k7a/
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--

--===============4163802962875998667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4163802962875998667==--
