From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add support for 768kHz DMIC
	operation
Date: Wed, 12 Nov 2014 15:24:44 +0000
Message-ID: <20141112152444.GM3815@sirena.org.uk>
References: <1415804126-19168-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5621444614184591489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 782742656EE
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 16:26:15 +0100 (CET)
In-Reply-To: <1415804126-19168-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5621444614184591489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ce1l0HA6wm8WicvA"
Content-Disposition: inline


--ce1l0HA6wm8WicvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 02:55:26PM +0000, Charles Keepax wrote:
> The new IPs supports a new lower frequency 768kHz DMIC operation
> add support for this into the OSR control.

Applied, thanks.

--ce1l0HA6wm8WicvA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY3u7AAoJECTWi3JdVIfQ6HUH/Axy898Wya/cEP0mF91GmJBQ
CbOc2YqFu/inNLIuD0+ZUOuA8jVhjqyziMyPktLfBy7sN6nGijW5UZTFmspsYgWw
esRtrXKkBcYdf9ZwlomGlpC2af11wiEotIcMZQJqHwNqY5j6P3qFTr32J2f5a7Cr
rckOvQR9+oIzkf+MmkbI0Tgc4YrcGDLcExJJpAKomfDQ7octGZbZqYuVR3yez2nW
s8ZYW68Q6K83z76QOHHE4lpFmZSVDxtTta2jbZ25PM3a6KnEDcoaWQidLKSJXg5W
FfhwvfWBZr0rlJSoJCxtPgkqKIUvd03Ej2MPfPg9n3qJSMvm9gHM9T56C+Wlero=
=oTL7
-----END PGP SIGNATURE-----

--ce1l0HA6wm8WicvA--

--===============5621444614184591489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5621444614184591489==--
