From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt5677: Add the MICBIAS VDD
 setting in the platform data
Date: Thu, 8 Jan 2015 18:36:10 +0000
Message-ID: <20150108183610.GZ2634@sirena.org.uk>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
 <1420684267-19211-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5899718648700135223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98E8B260498
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:36:14 +0100 (CET)
In-Reply-To: <1420684267-19211-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5899718648700135223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VvBvkXET3ybLhzUi"
Content-Disposition: inline


--VvBvkXET3ybLhzUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 10:31:06AM +0800, Oder Chiou wrote:
> The patch adds the MICBIAS VDD setting in the platform data. It can be set to
> 1V8 or 3V3 in the MICBIAS VDD.

Applied, thanks.

--VvBvkXET3ybLhzUi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrs4ZAAoJECTWi3JdVIfQ9Q8H/0OuUepltypdcacPZ1r1B9py
vcFcEl8PuPQhDVveRmpkS3rR0dgpW7JAu7TUtbI0fw9TgwmC4nMvIgox3/YhzQBf
UmgWe8RNHcXyzF1qJbjsrmu3JXnDm73OAb0y4zPY3hJ7Q0+GVBonJIZj7v6yRMc+
VkT3LhdWExknAvckregdIL9yPZMqtNzul9UJ6g74W2QGoZ/r3Er0XQvzhjcPc9Jj
+pDvAlWPX19ALJbBtK5Kfoe9OBBkG6Mnttkl9NgOS5HlpVERFxbNNHlfzBz5C56/
7oyUtYsd65lfZBUwQ8ivo59cBofRWTsQnrxgG4b37jK7uRT1sqkyEMukRkhn8l0=
=F27C
-----END PGP SIGNATURE-----

--VvBvkXET3ybLhzUi--

--===============5899718648700135223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5899718648700135223==--
