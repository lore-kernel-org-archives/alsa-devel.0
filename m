From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 3/7] ASoC: imx-audmux: Read default configuration
 from devicetree
Date: Tue, 6 Aug 2013 17:57:46 +0100
Message-ID: <20130806165746.GH6427@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5763189466981972423=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374924716-23475-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5763189466981972423==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 27, 2013 at 01:31:52PM +0200, Markus Pargmann wrote:
> Adds a function to parse a default port configuration from devicetree.

Applied, thanks - this is a really nice improvement.

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSASsHAAoJELSic+t+oim9Ck4P/AvD7X1AptXwioR39Fjh492u
lbBntoHJ215qfWXO3XkO6Wji/QYyczdr7WBqo684mFzhV92VPeX3dPnJXO1r2Re8
mMFFcOZvPdKLgklm3hjxxsJbpLM0mLLJaDNaQCizJ5J8gSYIiGaSyyQTPwhrpZGz
FdU4egVFRkBlHVGMKMzbC1pvetX5xDXyrNuhLh1LwCgWsSkYOwVcY577xxqCuiLa
fgnjkLq/qBam5ZRHi9uH0xRt6lBiWZ+5jaCmSamvXR0Wrr1eUsKmKOrI2Hem5oiw
LG14FV9+4xmmwXzN8t2jmdT3of5lG6yzOvNzX1+Tr49lwkNTKd7qVqth+c5aSpwP
a7rg33uJvLw+JFvJX+TPQOEOcUzlfH+GM82XAjXl+NVdKB8fKBDDTrwgYKJjeuvA
FFxrSIfO7VNjZjznyQ+aYH5/IEDqLlgn46/HC7/UK9k3nhmDWwDZ+jJ2pEbiOhGc
Yt9/39a7nS4uXQbDVijdBSZe8wVY7YTcRz/yY955iF0Wc+t6qKr3551OT7tNm/d/
OV6ceSQCjdoxSrZLij0iNctXV/A0kw1Ycqs35UbcJsdelBNTL56g8t8H2CnUJkvc
2GcgkP/Sis+3WCd9iT7Ugx8rukXZVywvruNmwKiH98hQjwawVzu7KVOWYT88u/7I
E4Ft21Co7RUKlS14WMHs
=2sQ8
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--


--===============5763189466981972423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5763189466981972423==--
