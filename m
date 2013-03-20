From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: max98090: Remove executable bit
Date: Wed, 20 Mar 2013 10:57:58 +0100
Message-ID: <20130320095758.GD28775@opensource.wolfsonmicro.com>
References: <1363730323.16270.11.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4584906078989465272=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDA0B2616E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 10:58:00 +0100 (CET)
In-Reply-To: <1363730323.16270.11.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4584906078989465272==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2013 at 02:58:43PM -0700, Joe Perches wrote:
> Source files shouldn't have the executable bit set.

I've applied this but I'm fed up to the back teeth of having to hand
edit trivial patches from you because you ignore the subject line styles
of subsystems and make up your own.

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSYgPAAoJELSic+t+oim9r5wQAIX2HXBqOQ6Cc+1F9vkpL5qN
zuN9eL5jvQpTPDBKU1oWvNvMsPQD4zSUv+FdBHpmKGBHcYE/+mf7MhUN0U2F/6PY
S1cXVQQG+5GC9ER4OxmF+FAgdx7OV7XOa+R7QTFIgn29ioc8YGpBgqfMVtkOMVUM
h4pVW9UWTe5/vWXwni2sF0rS7+N/n2HU80+xvNY8rJ4QsVvmOM4GG3DOEboD4EWd
1yBPGCsi2RGRQtc/Rta8a1E8cT53MsXKTzdhRtAlsMJ9neN3/zRtQiSnSq3e9DJE
TiDN98zoo3GTFdowkLAO/uWb2ml/QO9PpEx6xuSx+vpYxIL3NkYGdvG45gihz3t0
3TQqNL4ZLyTxB74diC2ms0y/MW7AWKxX+VdWRpqBEYdlcN8+RShbsp6Kpe1b9BLR
Yegt/+pPuRn0aacbTHHirvtWit6nrjLoKSquQNyzc+LbdSm/82E40QN0byNgAQi0
ayLWonnXoRVhaZnMvVZjsMF7VMX44Mbpyzj3Ilvo1P/8e9MJFsZ0f7UFlhPWBbAn
iZHLvcOxN0BjqLpAC8SK54ccAAPFfmBeenA/uEXypWbp4uaAs1XnKdkPwDvS2DU1
sKDjhX56OMRyJUxAE6IoSHVVV+K/Ew42Wrqg2Shc5LtbS6nYND/vOxAtEY/1xbHk
M329uthhlbGi9AxF/zdb
=7Suy
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

--===============4584906078989465272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4584906078989465272==--
