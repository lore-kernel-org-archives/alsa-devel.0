From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
Date: Tue, 7 Jun 2016 15:54:34 +0100
Message-ID: <20160607145434.GZ7510@sirena.org.uk>
References: <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
 <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk>
 <5756B22F.9000105@rock-chips.com>
 <20160607120647.GV7510@sirena.org.uk>
 <5756C245.7010001@rock-chips.com>
 <20160607133247.GY7510@sirena.org.uk>
 <5756D0BA.7060702@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6900097850499551267=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <5756D0BA.7060702-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============6900097850499551267==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L4xCDQ7GT+ph8Lmk"
Content-Disposition: inline


--L4xCDQ7GT+ph8Lmk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 09:48:42PM +0800, Xing Zheng wrote:
> On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 21:32, Mark Brown wrote:

> > I imagine they're all variants on a single reference design though?  The
> > name is unweildy.

> Yes, they are based on a single reference design which is called gru, so
> could I use the name "rk3399-gru-sound"?

That looks reasonable.

--L4xCDQ7GT+ph8Lmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVuAoAAoJECTWi3JdVIfQ8bEH/0tmGtTbzgqeQvFb/Z7Xiao7
AiHMBnyZxalYpEr02f2IVbNYHM+mTOs8KlZQ7Ku2uex3KuJtVI22teFK8yVuq5Qz
y2wM8kmFifk/zJM75vptkn/3yg1iLaonPfdKMvoC8Xfb3Wv3R3Co3X6pgNdQqOX7
1ZxWOulVZA57WvWe1B6Otxkz0023nfYKt+yLnxv/F7Vq7Ubq82piL9B4YCcEdus7
lBnsRP/K2B89DAnLhY5mQkvGbXrdPLfL9LkYbgA2b57LZJ868DnoAKZjseRdHWai
BQAyjkQUHR4YQ0NyLTb2AD2l9UxAwOG1Qx7c9UI0LhkUZ4BBHknxACK5HXGpBZ0=
=tr2b
-----END PGP SIGNATURE-----

--L4xCDQ7GT+ph8Lmk--


--===============6900097850499551267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============6900097850499551267==--
