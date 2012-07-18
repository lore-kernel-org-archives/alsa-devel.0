From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC imx-audmux: add
	MX31_AUDMUX_PORT7_SSI_PINS_7 define
Date: Wed, 18 Jul 2012 22:10:04 +0100
Message-ID: <20120718211003.GG4495@opensource.wolfsonmicro.com>
References: <1342616477-24778-1-git-send-email-torbenh@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6740624258758638963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC00E264ED5
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 23:10:04 +0200 (CEST)
In-Reply-To: <1342616477-24778-1-git-send-email-torbenh@linutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torben Hohn <torbenh@linutronix.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Richard Zhao <richard.zhao@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============6740624258758638963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2012 at 03:01:17PM +0200, Torben Hohn wrote:
> The MX31 Audmux also has 7 Ports.
> This patch adds the missing define, and makes the debugfs code iterate
> over that port too.

Applied, thanks.

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQByYiAAoJEBus8iNuMP3dcy8P/2Pju3wq+ZioLOWbu9HvJyEp
djXKcU7lAoOsqeJn7r9ZpVFHqIA6HLaP7dlYc3Ozk55kHyd0D/WTDwaZCE0yu8KA
pHPtwYK5aJjM7EYF8fNGks0QWPCCROtyeJaHvwknrfQ/RbM70DM7WEsQPCcP3lfO
GAwPMz71tVccnnlecmWpzCf0gO+krUCSI8tTWXAKsNsnaiA1KfLdBxFFr9lyecYM
raXXUZ1RriBJV5U5jyZadbHf1yMGfmLgcj7NFaj/LZbCvs3dB2DXoezUwNwgMlZL
L6d/A17OlVwsHyAyB/zAEQUAdgzRgntuPxtwkm+pvFaHV7J69ULJ9YAQCDRDU7pM
ucB/ZReB+WQcWMP+Xf0yU0LoJPEbjqp7AmAHo2/wiRzJ87WKeV1RXLJgmz6tYxXf
irHIqU5xbhMnjzPwotFHv5iFOsjOrzvxanfmDXhM61hOprtnN6v2JTQmovaL8Uwm
o3dfZau114kIvZKnv/hpRSbYF1QgEu3NQX4q0Cs3wnHE6QRE8Jay3owZfXERlvKH
nxXN7SfWx+E43jefoKbzEZA7GcvcNzIEXUsbqzzebxx5l7afFBNTlKehDTOecIZK
gHMwWnQZrgyWnJ30MQJec42kY/LFPQkW0MIvKjS/IWRYtofedm5GhqExX3eHeaQr
8jg3HH/VymZS1kn+POYD
=orbZ
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--

--===============6740624258758638963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6740624258758638963==--
