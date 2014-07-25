From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic31xx: Add dependency
 for I2C and select REGMAP_I2C in Kconfig
Date: Fri, 25 Jul 2014 17:39:42 +0100
Message-ID: <20140725163942.GS17528@sirena.org.uk>
References: <1406290068-11117-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8165607152110387720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1474926172C
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 18:39:51 +0200 (CEST)
In-Reply-To: <1406290068-11117-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8165607152110387720==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BhxIwg67zh/LWMpM"
Content-Disposition: inline


--BhxIwg67zh/LWMpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 25, 2014 at 03:07:47PM +0300, Peter Ujfalusi wrote:
> The codec can be configured via I2C and using regmap_i2c.

Applied both, thanks.

--BhxIwg67zh/LWMpM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0ohLAAoJELSic+t+oim99vQP/jUHSXL8jbv61hIsaM0fCfx4
SUpWrXCM8Pbl6kOf7D/fKExrVSCjVwiSr8f5QMwwGY2JAXiS0PLSEkqnlTgtmWyI
05T5bjILW96z+7zykssXCeHSx0G61qrXYCAV99YHXhUkK5KnjZ3kzz2p/65b7/GE
uI334JNuNuaMrn2QW3SGAesQu65SYdP7ViOXqtQ7iYEeDErlWPKmlka/VLUtjvnA
UX3R/Gu+8MoUFGHCTm3L/wKvp8ylrflP/IB+CCdwfapvypZczN47ifXS3vYLF94Q
XqCSznk5exhlt2QNKJGwHFCfYAcaNOkYPzEH2qJBqziNoVucITHkvFvW/Q245tJa
DcdgRjGVycSQjcVqekR7L/oU37xR+N9kRoQWQuN0v7owQdIEJORCfRdbnifno6JW
UtmEXFt2wsudOnckADhll0O/AWv9c3vIaHuB9m6NDy6ZQgQU53J2qudph00oG1xG
v6+706FnmYmhcWPSrH8hg4Ly1lzBskTi6TynEfaTPHdbXMYz2aVU6XtgLLbLK904
3OSZ91qRQvv3v74w2b/Y500+V+2E6PHypbPBuKnS+HnS7ic0ZnRdRDQE6SXyYeQf
5Brbz9W1mzEANP7KGhN04gl5bU13ZnkJKZl6RTJBVGuW4oMhqEvTNsuSpOaaXJoQ
vaRK4E+D+AOBkBpA9TLJ
=juPA
-----END PGP SIGNATURE-----

--BhxIwg67zh/LWMpM--

--===============8165607152110387720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8165607152110387720==--
