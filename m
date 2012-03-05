From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Mon, 5 Mar 2012 14:20:10 +0000
Message-ID: <20120305142009.GO3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0506220228815491718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67BF8104294
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:20:11 +0100 (CET)
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============0506220228815491718==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6iXXu7NwgEt9u5a7"
Content-Disposition: inline


--6iXXu7NwgEt9u5a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 10:30:48PM +0800, Shawn Guo wrote:
> Changes since v1:
>  * Address comments from Mark, Timur, and Sascha (Thanks for review).
>  * Drop patches that have been applied by Mark.

I see you've ignored my comments about reordering the patches so they
can be applied more easily :(

--6iXXu7NwgEt9u5a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVMsyAAoJEBus8iNuMP3df1MQAJtkQwkgRqpsqu5m9UR4qfi2
VfiTvAKG8fhAOXVrRgJYG87ztDq5F8ezc3O52oqdAovkv/iAo+27PpepGK1773Nj
xi5WcxHgpGi7dPzbdoCZsGQ0RD4bEP0NmeVoaisNGmB0q9aGbgWFk7OZUKSD1bMA
q68iW8Wty9MytWrxHGEA+QPRZR0jv/Dz3EaqhJhjH4+nf3hjAU5ApbM9eYi3Q4F6
31sX1ubIRAth8Xy7og/iY3izxW9rzXoWIfhyPs3RRe607YGsObOVlQsHpkiWDrQE
mF57TE2LWUH0V6XaHCoE05JD4zvdwmzqb5wvCX+eduV4bdWdKkIGdG3mhsLWbLqU
+4YYqM9jHkhiG8p35ewSX+FXUPpPmdv3JYhUzYQeGoVdCyY+qDEvXt6+284ESQEW
d7msh8DI378SXxPzkUknU0Dic2api02A/I37AZcut+BVPYbkFP6PJeat7HXvyGkl
Qj1l0O8wIHwXTi8rF5d4e/XKOHiVrQsaSWMDVOHRf+sv82Wy5avwqOVbOe+esJe+
iac7OlaryGuGdgv5LHoZpLpZ6XrHT6swtxdxt3+ILFIAPIH8FG4brQ3qj4J4MghI
/1y1oCFa3A640D9qusKxktyHojTqyhKkkQU77YnMCXKDoskhF7KeJrsUXOBX+k+P
52HGnIvqvTYVKuOyXfJu
=0ata
-----END PGP SIGNATURE-----

--6iXXu7NwgEt9u5a7--

--===============0506220228815491718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0506220228815491718==--
