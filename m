From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-i2s: incorrect regmap for A83t
Date: Thu, 22 Aug 2019 08:17:17 +0200
Message-ID: <20190822061717.yjvnnr326psa4r4c@flea>
References: <20190821162320.28653-1-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2141387446122628068=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190821162320.28653-1-codekipper@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: codekipper@gmail.com
Cc: alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, be17068@iperbole.bo.it, wens@csie.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2141387446122628068==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ufzyzs2ggwjbupx"
Content-Disposition: inline


--5ufzyzs2ggwjbupx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Markus,

On Wed, Aug 21, 2019 at 06:23:20PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

The patch is ok, but you should have a commit log here.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5ufzyzs2ggwjbupx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV4zbQAKCRDj7w1vZxhR
xfPfAP4zvSBPA7HpdlMc4iMU5KhOSpimaoOr1DymhZ0Xnazn6AD/aHTHKG9yy3Ej
6/fLGUWkpxamiWdf2Mz7J6d0XQjJuww=
=CDu6
-----END PGP SIGNATURE-----

--5ufzyzs2ggwjbupx--


--===============2141387446122628068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2141387446122628068==--
