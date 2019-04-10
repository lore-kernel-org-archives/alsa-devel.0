From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/1] ASoC: Mediatek: MT8183: add I2S2 control path
 from UL2 and UL3
Date: Wed, 10 Apr 2019 10:35:30 +0100
Message-ID: <20190410093530.GB6106@sirena.org.uk>
References: <20190409091337.43934-1-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6534884139436181741=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190409091337.43934-1-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============6534884139436181741==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 05:13:36PM +0800, Shunli Wang wrote:
> ASoC: Mediatek: MT8183: add I2S2 control path from UL2 and UL3
>=20
> Shunli Wang (1):
>   ASoC: Mediatek: MT8183: add I2S2 control path from UL2 and UL3
>=20
>  sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytuOEACgkQJNaLcl1U
h9DHNAf/dlx4IJydb6KythBwiVaJvkDCgOxwxC+hF44H73d0W9VHNL4viNE+jbaN
6rzj46try2XnWwcQzG4qNUtVtMNInZPiaC0hGLjXVgK80dBtptlzE3Pc6258JsRr
cO7L/b7+mA1KKq4pcGL73KhD6/kQ3KvjJIBU7dTaosPx/pHU4VaZ2BosW3DTewXB
aaPdUy98PUKSUG4rZsC7qeadMBrYbUtEB5/uyY5PQMYRABuKZF2wMdjeUmdAw00n
Nq6HW81mpQPUun5OV6ijc6Rf/QIN5SedR3velXhvmXaFQI60Zzqgo1K8XLeLMN8J
PrJwhAk/s39pbvQLBL65a4TVGw4zYQ==
=5E9n
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--


--===============6534884139436181741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============6534884139436181741==--
