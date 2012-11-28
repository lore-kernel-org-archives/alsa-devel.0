From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC: dapm: Fix potential NULL pointer
	dereference
Date: Wed, 28 Nov 2012 17:28:38 +0000
Message-ID: <20121128172837.GS32691@opensource.wolfsonmicro.com>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
 <1353488819-13902-6-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHyPsVkd1NuYJyDs30eH5SivOsdJoK8=QfqsTx9k2xWMzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2246736469026991122=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 394D7261725
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:28:39 +0100 (CET)
In-Reply-To: <CAK9yfHyPsVkd1NuYJyDs30eH5SivOsdJoK8=QfqsTx9k2xWMzw@mail.gmail.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2246736469026991122==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Content-Disposition: inline


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2012 at 10:13:58AM +0530, Sachin Kamat wrote:
> Not sure if this patch got lost.
> Just a gentle reminder.

Don't send contentless pings or top post.  If the patch has been lost
it's not helpful to have a copy covered in quotation marks.

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtkm+AAoJELSic+t+oim9U7AP/Rka0HxtpN7OU8JdbqNmqRuY
/Fchh8K6mESoc5pSDalalqrmwrdGuthsQ2sTBENN/xX6+3B06iO1PGGYhqJjtdY/
SvL3WrZ70bSkMXs9rwBdR6l1Y/tJ23NcEEfX/RZ4X20Lm8dkhSOIkHXOCr4zPpoG
LGVHw8zQKglLvOZFHZkMxIY9Xu4tIICk/Te8LO9F6xNLQqtcQtD9dDWBF/cOSSDE
P6VOwjp3ft4WI7cR6fimyTZ/KNlzFsDB1k56Wr93A1Th7HkVePZ6ITyqK8lUSdH1
q68HNnu0n11nf4ayiF+0gaBykKbm0lfgEQ2pvtN1nZJEX1STPXrAPpAwyI4Wr4iY
Ol/mmlnF/QsRMumUD4VPb6IuchkKZq6trhRighaMH7icW9YKw25W3uhgl7bKYiDY
7P9ueddCcjyQdxGZUj+K5qN1XXyvPppiBeWMmxUnq+GsZKOJdWgwJ7bi8+4UqF6r
BWV0NOK9/y6ABN1EBjDdXxWKvv4tcNW1jxe+MWNoi2JvkMiAeRL8cKQ8+ckgv5rB
1njG5FSu9qjR4DJOxfThU7bLgXNTU9BJfCTduGDlUTstIbYrJhcPLyG4sO1+guWv
hAl9+OkJbjFgojVgpHDd+HGZ2wshjIUSOcE+DZaZhrhr+vcvsnUkscX/htYthkHH
s299c1UOOjpCHKb8LOR0
=xumg
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--

--===============2246736469026991122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2246736469026991122==--
