From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Remove suspend/resume
 soc driver operations
Date: Sun, 13 Jan 2013 21:35:20 +0900
Message-ID: <20130113123519.GB5041@opensource.wolfsonmicro.com>
References: <1357920110-15213-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2595618064884647634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 254A62615C3
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 13:35:25 +0100 (CET)
In-Reply-To: <1357920110-15213-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2595618064884647634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 05:01:50PM +0100, Peter Ujfalusi wrote:
> With idle_bias_off these are no longer needed.

Applied, thanks.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8qn9AAoJELSic+t+oim95HoP/0aZPXuS2WRly4VnaKhdvLJa
dl3ZI+A/t/9YVw73rhqN6OJE/BlrUeX3sfXcp0bBqUvNTpv1faWKvtgJJ4qFocsY
V+tqBMAsbK+dJwsqGfZ/aoesC9tCo7J4421n2pv4Tj21X25+lEzHi4HpVjArtMKY
t1dZdtrVzV/pYQrs6TqDSihTjSp/9D+ZBjLscxZNP8RrDlXHx3V4OHL3Z+ZB3xE0
hRJWWq4FdvkfIPCmif+U9SD9k+p0WRbS/jmTytznWM4fxBtq1FRdqlUE9Zh6YSc0
fWw1Yss27lQ2qapAKjiXtznxB3HXg/wxMSe/9qQFT2NMB4nU1AD+lNKhrDTJcS8B
Oki7JTxwj3XOb18+HxfacVYK+0HC0cE+TXkyIPNLHFw8el62jJeAlq+OYU1a23Qu
ZGcssakarKEpunoS5n6QC1khgvLj4f2zmjUfW80wFgYrZp0EXmpfXS931m9Hmxn9
b/j7wU6UXJ4jJCf+OZ2GxuxYFsy6nKNWCFUpMlkQkDt7eJZItVWF5UDs95CePCU8
FpDmP/eqaMjpe/i+HZdQ29WhOEfFTkTHTrMyakgwG1bOTw7gM3yFmx1ZhAC0Qtun
4xu72DiXcEOsyRIJFOVnhLPnzbIGJv3e+/eyDYFDFoT8AoERbcRXYnXLTHcON4/6
OY6guSmFoeGnnG9di7E6
=KJYK
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

--===============2595618064884647634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2595618064884647634==--
