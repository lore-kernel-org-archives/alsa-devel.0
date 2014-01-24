From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: Samsung: Remove dma.h inclusion
Date: Fri, 24 Jan 2014 13:18:32 +0000
Message-ID: <20140124131832.GB11727@sirena.org.uk>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
 <1390560804-31135-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3480701342139309551=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E612265467
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 14:18:37 +0100 (CET)
In-Reply-To: <1390560804-31135-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3480701342139309551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LMmSgwdUwKH/sMG1"
Content-Disposition: inline


--LMmSgwdUwKH/sMG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 04:23:23PM +0530, Sachin Kamat wrote:
> mach/dma.h is not referenced by this file. Remove it.

Applied, thanks.

--LMmSgwdUwKH/sMG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4mglAAoJELSic+t+oim9wn4QAJDSyYZ6cKCG4px9K5QEMYir
ttPvO6O2PUU7X8EW6zuz8j5oyGtySGNXdSNDESbePWw1Vovu5O3PuepnxkamyNyG
rLmCB+I1cwCfu7joqPTa3XWh/eKrEQRKQi0AnY3kRxJsETOpqLAbFKYVHpYvTGgu
Rd/E8QglJhSgabVuIJgS7cVSj2iLQnj6DXpXQxNkN8VW5lgMZBaXXuFloljpDR0e
ElFnXxy7gEZCaiWLXGqhuF5AQvQbNGj49jHr468R0voBOENB3u6/sEo17kyfrjKf
7O4ihmviv06KeKSOqH8FksJ8VHYLXtZgIycms82Si6Z33RP4EWQpyvH4R+XT2FQa
WsKYZzmLE0aadWq0nBBSLTgsX/QSymKTD0i8WoZDpixylYMy5kGXZMRcpYryoigg
p8w2dEVRbO+4RUVplnM9AJ8HHkX8+uPJPxHT2QCHRaxk2J6SwGu1YDMJE5OV89oQ
6LzYqAe1iR8aKU9gopo16RkTMhyxH9Jr1HBE0rye51gkaAJKXavdK5wNNae1I2CA
wKz/dWz90D9zjjxm5Rm2Oq/YgtiDgAg4plustUE9A7ORIzwsNksB/p7GjkmRtkR3
vX5F3R/+KiQvCBbU9aVXPhvrh23t68Z/sqLzDQX+SfOm6eSWMbgiRm7mfyMlylb8
IgVDB0CLXD9T28XYiK0L
=J/dJ
-----END PGP SIGNATURE-----

--LMmSgwdUwKH/sMG1--

--===============3480701342139309551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3480701342139309551==--
