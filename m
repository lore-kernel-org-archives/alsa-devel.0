From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 1/2] ASoC: add snd_soc_of_parse_daifmt() for
 DeviceTree
Date: Sun, 27 Jan 2013 11:42:33 +0800
Message-ID: <20130127034230.GI4650@opensource.wolfsonmicro.com>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87wqvfyxym.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9110054318874197801=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87wqvfyxym.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============9110054318874197801==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Content-Disposition: inline


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2013 at 06:36:04PM -0800, Kuninori Morimoto wrote:
> This patch adds snd_soc_of_parse_daifmt() and supports below style on DT.

Applied, thanks.

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBKH+AAoJELSic+t+oim9elsQAISUMIHPg7LgpBU/zvVbmIgf
eq7s8ebTBY1J2cc62Kfel15pSnJFjKyaW9YoF+8sO7Sb9gskkiPc9GQnVzRa0U11
bC4FBdY5RzJJoZZJSWR9Gtjo1FrGxumwRWp+zdwwgMVrjXp25Bbv4ywKg7ES6Q1Z
ku/PQf7DQ+nQidVmgWnJXZm6cONpyMtm71mmFNXYq8xDgKpJ93b1rXa33MBexhI6
3PgPr0fxvq+XUBz6NbjbklGb/o2bOP/+RFyf5VeZoZAAbSXCClpKqqO5gqBrG519
tbr62KRIb9AkQhfJdiRDZJYOxemLq6OBW1w4/Jahyndj9ayHueYrJ/0gIFiENPnz
Xh3XA+58Br9Weo+7kPA/j1UBTWulPQwtbOyspBPTxwUYpuQEIl1xe1P7b9zeaa7l
Aa0XHuuRVoCLDlsu50Ogol11sVpr2hhJMKuznjRCliHEyjxdxPr41FEXiClzLxQT
d81udi7OQPhB779A8iK6qb/95YcNv1PTaEZy1z3ItXXoxA+fZhdQuuq4eCdEa0up
qIJ5LZ5Ymeydufgk00b0S13IXNaSKR/YVvRzG0edqpolm8dFlTG3At8IuYlCY4eM
LzJCB9z2TWjnSLR2r4o+iKgNKT33pEIDLHcPlqpfkNhua64VswubGfkJoh+61XOO
pJGHMQYWT48QgplVUN5+
=EZk1
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--

--===============9110054318874197801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============9110054318874197801==--
