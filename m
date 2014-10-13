From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Add option to configure gpio
 as floating/pullup/pulldown
Date: Mon, 13 Oct 2014 14:47:42 +0200
Message-ID: <20141013124742.GW27755@sirena.org.uk>
References: <1412999196-14395-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3615000019030166125=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC7B260455
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 14:48:05 +0200 (CEST)
In-Reply-To: <1412999196-14395-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============3615000019030166125==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4uMdeSyPFwfKNOAv"
Content-Disposition: inline


--4uMdeSyPFwfKNOAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 10, 2014 at 08:46:36PM -0700, Anatol Pomozov wrote:
> gpio_config is array of 6 elements that allows to set GPIO as
> floating, pullup, pulldown.

Applied, thanks.

--4uMdeSyPFwfKNOAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO8noAAoJECTWi3JdVIfQMqAH+gOC5wYuUfU59OR/hw8hRXWn
ny7vTgt50ZGNyMby5yJ8bWQEPPhkfa2qjkD63ADU6MDNfNpIfRfGxRKEFVNjq9Ji
R1u71NAt1z3x0CF8o6j8TGyP+bgw+aRfQ7bgysF7PtCy42Hn13c7rXLYEwHJerE6
VXiPWI2vrnX0pQ+sKupg2+CuKs7xkMPbghbYJ6d+mPIXTgz6M75miwWlVeKSK/yC
ilBwMONpIIkuD16GO/7tQPri5roWuk+tg3IV+Y1ZdkG20tHKZMhLJCIwpVkwdyYn
Fbtj9Cu8jjolIyXU6xB/hX/eL17yeM5fub85z9Ih39FS5MOY2VOexeQKBAHEPeM=
=avle
-----END PGP SIGNATURE-----

--4uMdeSyPFwfKNOAv--

--===============3615000019030166125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3615000019030166125==--
