From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Mon, 20 Aug 2012 14:18:46 +0100
Message-ID: <20120820131845.GD26991@opensource.wolfsonmicro.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
 <CAOMZO5BgeW_z-zf3Auw6RCJg1o5L=DqWdVeF+0Xb_W=6hZJMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1841620346324708380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27E4D265E13
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 15:18:46 +0200 (CEST)
In-Reply-To: <CAOMZO5BgeW_z-zf3Auw6RCJg1o5L=DqWdVeF+0Xb_W=6hZJMnQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1841620346324708380==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 17, 2012 at 08:35:49PM -0300, Fabio Estevam wrote:

> Are you running a dt or non-dt kernel? In case of a dt kernel, can you
> share the dts file?

Non-DT.

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMjkuAAoJEFJkBDiqVpZ4WhgP/A9m3yPdPCzJLmauHuFL+ito
2QHTWMri8xn+9kc88WM+LkW8PX67mdRvmIy/Sc6zDMzGE/x7kfauSen5WEgWTRLx
LH9d0PeonChQNdu1JrbxU7A0s6hFQboAmyWWXBdbtSYNAl7uw6uhE3fyadsfftfz
0sENHW6h22WnUD/JkKNd9ObDek4ovKHFZ/IO3ArLDs7bPxWhSi4IW0qSnSUatOub
xebTYkJqC5FXKkzikmWrTlU6Gak7Gx7Fa/FO0fe9wmEpZ/1SvWRWhPVXEWn2OoaD
AGIfR9EBMxXOYJkXxmQV9FfTOHZ8LRFj9JvaLR9RPjYh0L1z5UYmfhRtwyHCmK5F
GCjUq5tXfhgP86YoWBVEZAx9o6eQA+tn/vMqS4eW6MCoh09h4OBXdHajqmv1m7xa
94GAbnxCVnQ+KwBVBLxZ8AHrQ02A3H+wIeajt6mn7fXlPlb8BO2pdpS7Bb8WPmoT
1Q8wHmx5YenkCs70+b36+E9qMQLq1RUGPr+qyoiovCFG1XLb6HF7kQdEW2ZPB3D7
4r8OFmZF1Le5mRNk8AhdbrwqwaIpQdTg0XNNzGEd1CU1r/KHevjY4jeFcKTADGw2
/QBf6GNjTEg7KuY7LGXf+WZZM4olPc8f0PmmbPCzeWRrOWA47sG31UfrUPFC/PTT
OySYKqJRA+3B2ECyTWam
=Jsqk
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

--===============1841620346324708380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1841620346324708380==--
