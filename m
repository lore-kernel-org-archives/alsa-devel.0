From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Change Class-D
 amplifier gain control name
Date: Wed, 30 May 2012 18:03:24 +0100
Message-ID: <20120530170323.GQ9947@opensource.wolfsonmicro.com>
References: <1338232142-2615-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7943578231684932494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94F9310438D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 19:03:25 +0200 (CEST)
In-Reply-To: <1338232142-2615-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Randolph Chung <rchung42@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7943578231684932494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GIP5y49pbaVPin6k"
Content-Disposition: inline


--GIP5y49pbaVPin6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2012 at 10:09:02PM +0300, Jarkko Nikula wrote:
> ALSA mixers cannot classify this "Class-D Amplifier Gain" speaker output
> gain control as a playback control. Fix this by changing the name as
> "Class-D Playback Volume".

Applied, thanks.

--GIP5y49pbaVPin6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxlArAAoJEBus8iNuMP3dtyMQAJcimkTwM4ljPQtmqapbexvW
S8bHtaOU86onDT2uzdwvVE/js4LamK7hbAzFzHNxK1eJFcCizEq4p2OXA4Jls763
Ym+XvnzE4d7Lwjn+gDWEMa4jgLCLFYXw4uWBbA6gtZdunuEc0oqyWPj8HtyRAAkd
WiVyGiqYJXh6m/TC/2j77X3I9/4WdWO1mqvQ6SUQycmR3x+qP6jtVLhMcMna49km
0De4w2S+DnN4yJ8hsFLEgdYJq85QkIzm4y0P+jeRi26CGxJHrslg/KtIiS5vHWS6
h5+sybUT26oPXxWDNdD8PUndPqlrUN67WEpqR2ecRORAXxXpIWS9dvuhBLLK+Ula
5YiOj5WqLhi0xbnyOFHJZ1PrB//LQRl69V/M4fpzORiUTHsMyIZPNKRt6BphiXlj
SuLvnWDcclyQhInXYGmPf2G0MuiZByUdUmzVbNAtplMB8kaosLBLqRTS8xea+Bzy
viPXokVC+IvzXzzsJm/BipWktNwd+qAueK6/080XDP1AQNu1cBkP1nsVbmaHf8wc
8QiQjr5c2aPxMEvjDJ5timhQorZOpTrmcjpOCZ0LEXUFPDQnafVz1xwImG4K/fH7
b16Cvl6ED43GjyPEtDRxM00CAmmXT/Vvq655YGPBZ7Hpp4ZbyH9XV6R+rKVk5SrE
w5rXycabBeYe2LvLxOLl
=P18U
-----END PGP SIGNATURE-----

--GIP5y49pbaVPin6k--

--===============7943578231684932494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7943578231684932494==--
