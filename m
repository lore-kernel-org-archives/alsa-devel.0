From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix kerneldoc errors
Date: Mon, 10 Nov 2014 17:55:08 +0000
Message-ID: <20141110175508.GD3815@sirena.org.uk>
References: <1415637045-20868-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3428746842668512077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 304322658CA
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 18:56:25 +0100 (CET)
In-Reply-To: <1415637045-20868-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3428746842668512077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bf5VSTVrbhuikO7n"
Content-Disposition: inline


--bf5VSTVrbhuikO7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 05:30:45PM +0100, Takashi Iwai wrote:

> + * @list:   linked list of assigned pins to the same jack

I thought there was a way to mark implementation details that the user
isn't supposed to look at as such in kerneldoc?

--bf5VSTVrbhuikO7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYPv7AAoJECTWi3JdVIfQqFYH/iZmHBHyNjx0xtnJxmGqb8ct
d6hxNAVvrsnZclyJf/TOgOuzCg2PlFFuspHl+JMZxYp2XFeHOv71SqzaLKNavdZ3
jLrdFCsFPbcAAtW+zXeD1B3V8hxPKAVv1UT7HcZ9npXD/bcfHwJKf3qtqCYxWc8c
HBUQADaQs4RfJasFHugHeB2ou70VOLlFaBEs5gB44Vvr5AnADMcVFS1N1jKSWivg
Z9oti3pOxvzaoqDfKdnE8r3vvNX8KR1aR/oHzA/4Jvfzmfnts7n3/2xpLCxGezXG
x8Tyl5AQSdVii3y321hrVHIvT2MkN7nLiiuL4HbYk4NhtqT/7k138mzk7rXfYIs=
=g4FJ
-----END PGP SIGNATURE-----

--bf5VSTVrbhuikO7n--

--===============3428746842668512077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3428746842668512077==--
