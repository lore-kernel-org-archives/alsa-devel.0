From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 023/102] ASoC: wm8770: Fix wrong number of
	enum items
Date: Thu, 20 Feb 2014 10:24:06 +0900
Message-ID: <20140220012406.GI2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1398178146292302013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6B7265375
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:24:12 +0100 (CET)
In-Reply-To: <1392723422-12689-8-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1398178146292302013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VqdL2uy31pZHHqse"
Content-Disposition: inline


--VqdL2uy31pZHHqse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:58PM +0100, Takashi Iwai wrote:
> wm8770 codec driver defines ain_enum with a wrong number of items.

Applied, thanks.

--VqdL2uy31pZHHqse
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVkzAAoJELSic+t+oim9rWgP/07wRenLlHzkPiwyS2E27Upr
7yvMrz5+XIdjio2icTtlCxccpgNDcTMBpnNkWo9KDcWL0Jy4TFy81nEQXh/HsTzX
2a6c2Bx+Cq3c1BgjTXMhX5z44zeOvFGdjhQcI2JTcKwkGUE1AD1zP/l2OqzWcVso
p5BkVWHRURvqZskvXSw2DjGxz9+mjjnmGdgtRWSzGHBwkhocKbeoyJJHh9NgypAt
L5Rjfvy3DsZI3EIDoYYbRU94Q4PRgKWPspVC0hCcQ71C9t8H3uF1J1cgBBiEQ4qG
2j2Sh1BnmevE2vlrwM7qVvdhl81+64Rd6fSD35M7k2gIgRVcFBGJ4lfiMQv4PoEL
upgkc0ZLY6xbkX3M2atYHIYtu8SQmlRdJ5/Dx7ll9ij+s38vWohJVX4qVuqOcWa5
Eujx7v9+calbTzg5ApKxIGakdUHkl6bmw7MASGbcs8uT3R2faQk5PCgmj2r5y5Q+
dDvcOzNammC/etvyQN5ooB79YKiK71U5mBUwaRdve2ewAwdTMf6WXOKluTKlQ2Gp
gG5BrnuKtB9E+3DZqPvP34adt6zcdHGZdclkXe05xovmWZV5SKpbb+UFDskdIpKw
7uEw4Af7efTvQ5dKhW7k0/dvzLnhmaTObYkwnXI/36PnyVTFasLGOJx1z4p7M2eT
04LZOdeTwM1FqsYpYcUZ
=6ZsL
-----END PGP SIGNATURE-----

--VqdL2uy31pZHHqse--

--===============1398178146292302013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1398178146292302013==--
