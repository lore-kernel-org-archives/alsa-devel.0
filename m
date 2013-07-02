From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mop500: add .owner to struct snd_soc_card
Date: Tue, 2 Jul 2013 19:15:44 +0100
Message-ID: <20130702181544.GY27646@sirena.org.uk>
References: <CAPgLHd8i0kcs5RE2UUPmFS5ueMgRAzofeaAUnGz4WuYFBANeBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3709516239067490942=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAPgLHd8i0kcs5RE2UUPmFS5ueMgRAzofeaAUnGz4WuYFBANeBw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ola.o.lilja-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============3709516239067490942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbuFj1t1LJkAAh+4"
Content-Disposition: inline


--IbuFj1t1LJkAAh+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:25:37PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Add missing .owner of struct snd_soc_card. This prevents the
> module from being removed from underneath its users.

Applied, thanks.

--IbuFj1t1LJkAAh+4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0xjNAAoJELSic+t+oim9WVUP/25evwO0QIx9g7+xCIMtyTrb
dmNWDo+hbZlzIJyi9mqV7Pj5LEfnxtHhxv6fxUVoli7rs0tmyYcBd/MMOr4IFrD5
Ri+73worFrx8Oyps3KsC6j6Pfx+MKnjC8Btvc+wSLFvMYe5Q/w/BlQT6VQ9ng6wB
hZXdJgkcsRCsmkUlqOx73CI9zyXHBGYMJZxU3SGbZALdg4ITPCFqxQufywfckS8N
H5ybFtFM1b+3bLbZwaX0O16JjPJqAU7DH6BIiXhubooPtzSFK+ei12hBwWC72PZZ
Q4TsRGkdiLpbHZUq4Z3xbG3VABsa6VbkJcZZVQtsF78uCp0/YPZCOkrxWvWLQTUc
goRBENFY7zm6Hjt9qTT85ijH63XHs2rK2xKRElsCwJM99GMKtO5vPP1Z/AhBMVUi
1mq2zA6bLTVWZT0GeKKffhDE5OzuEMzHAFQIyWwsdWBxSwGwk5wgMmmGi9bBLebN
ZhB2LZNjJ7IBksPm/Bj1fpDR+a7XuZ8lEb3IznUXDbBXImCBpkKb9ZY7eStUC2FN
vDAZ2sbNxYtE0yiFx7WiC97vcZ6Kk1L0Gpfzmq0jmS3PkwiFAWbfABVwYMHUPw1L
ph2kGSNywx8a6JvECFFVogL+DYqaSRKzUWauc3vf+BFhnhUX7qvbx8PYL/iF0/gs
im0LXaCo0KwvbqUdJRlc
=4hk4
-----END PGP SIGNATURE-----

--IbuFj1t1LJkAAh+4--

--===============3709516239067490942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3709516239067490942==--
