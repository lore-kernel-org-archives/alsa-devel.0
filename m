From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: Support TI Isabelle Audio
	driver
Date: Fri, 1 Jun 2012 14:55:11 +0100
Message-ID: <20120601135510.GP24139@opensource.wolfsonmicro.com>
References: <1338289786-2751-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120530164008.GO9947@opensource.wolfsonmicro.com>
	<4FC8B476.4030305@ti.com>
	<20120601124624.GM24139@opensource.wolfsonmicro.com>
	<4FC8C92B.6000200@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2095991140069102086=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F59C10400C
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 15:55:12 +0200 (CEST)
In-Reply-To: <4FC8C92B.6000200@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Deshpande A,
	Vishwas" <Vishwas.A.Deshpande@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2095991140069102086==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GYaKytDE8aa4+VVK"
Content-Disposition: inline


--GYaKytDE8aa4+VVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2012 at 07:22:43PM +0530, MR Swami Reddy wrote:

> Is it OK, if Ithe 'dev_get_regmap()' api will be included in the patch,
> after its merged into 'for-next' branch?

If you send it now then by the time it appears in for-next the
dependency will be there, for test you can always grab the commit from
Linus' tree.

--GYaKytDE8aa4+VVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyMhhAAoJEBus8iNuMP3dgGoP/i1gk5WqaI++BHwKhZv2QQ6W
i8Ovv4sYHP8LTb3Vvvs7eA9V/T7yXs10UoBT0tC2UIUMKST3vPMSPtUNqcez4px9
qpiplhyiMK2GvUoQcjKl3nvzkQG0R31IEARj56PpzdyR3Lp9GPjf7QpWverweM8E
J4Sz5Bib55ZR4+mJUu1//bG12vajJM/ZYrYJuySJgZpuL5jeJJR597Drar2N2pE4
gB0/hqzWpHEBzNaZO0K97bwzcXJrpLRxoQT6QZsw9Txs3X2MCOIVcNQ/QRuphCsj
WiF4CbQ86VOai5KZTJmV6KG8LVoGbVv8xbTUn2YSrC+YW2wAkBqcaALwGbBxgogo
6jzF62pQNbHKC3Ta9/U1yaxcCg9AffxrSccZ4UovR9B3qrC/vzXytLK+bybhiDW0
rCxc2zPl6zDrf3n5LYJGDaAi1x91IP5KXSjMT0k9agfPpxejVwqwot7N4xiBxo0m
NOnlVYJz3p6vWq+k5MQ03ZPHA/gA0IywORqc3lmzWx6OHsB0H+cL70M94wDnJUOF
2Dt2kSBi0/jMvcG6FJD3Gqk8BhTYQHxIEfIFmbANUk+6KT0LHretseVCqW53TW6m
I4KhgwT28AgWHm0py6gGaTrrsLmVAQ4oKbVT5zF3CZQ5ezLkX8tJC+bQadtmRXN4
fpgbKF+vvlf5WXagQhnG
=tzgu
-----END PGP SIGNATURE-----

--GYaKytDE8aa4+VVK--

--===============2095991140069102086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2095991140069102086==--
