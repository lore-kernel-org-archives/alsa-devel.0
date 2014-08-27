From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: correct mismatch widget
	name
Date: Wed, 27 Aug 2014 16:54:51 +0100
Message-ID: <20140827155451.GH17528@sirena.org.uk>
References: <1409140234-10199-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6179698003702490045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 123F826571E
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 17:55:04 +0200 (CEST)
In-Reply-To: <1409140234-10199-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6179698003702490045==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ssMPzaah74jXs2d4"
Content-Disposition: inline


--ssMPzaah74jXs2d4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 07:50:33PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> We name MICBIAS1 in dapm widget, but micbias1 in route table.

Applied, thanks.

--ssMPzaah74jXs2d4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/f9IAAoJELSic+t+oim9Y54P/An+qFdBUZdIYo+JUjhEoJM+
svZr1liAxRsUtvbzwkZDW3aW14qpZjWMsY5l05JsJ4PRqV40/dOObuqtlVE/9d6U
pbcvNtNpJ2KM5Is8Etm0kkyBVCbFVm98SzYQtzyUU5mZE7Q8gSXh3hNUS4Sq3HY3
rPygEGKkDf9mYysqu0Fn3sGOxrUnfioRtD1cW+z79W6OprvqCBvsfSiON2IIlgSj
GjgiNUbFZ6SRXAVClGOsotBxYX5iSZ6DeDH+ZBjjcVhvhaLuB5SHt9IMG6CGQKUr
XU2fagMl24HPKFgI4oBGrtUlhtYnV2ybwiwYPv0Ayc5DRCgItwyIg5rzzIYwlFmk
6aeqiIakLH/+x0A21YG1zs4/WuQvKjBQ7aEGoKantvwyt1RtQ0MDjjsbVTPmYA8X
8sDW7JikobPbGP+QlZGV1j2445mWFxYzzRI/RYW60Ik/E6N5Y6FbFT4FDg5b6Gpo
/ekHlacm+AdIaGSn36UY9BkN7dIY7yg2GDzdsd1CPpyMGKWZ7nC44zo4EBsdiaP3
k7XoV9Mld9pYigDsb+jG46wi5ijzK1gpyMkUjSwKzJZoy5Z6A03cSBe0u0bUwyh5
W4k30J2bRchWGMV5RjXwjn72HtSCVYXuq4r1xQM+77zgSR6KII9xpdVvUsroxbxG
jfxmB11ZUlV9AZ7DOjM2
=xflz
-----END PGP SIGNATURE-----

--ssMPzaah74jXs2d4--

--===============6179698003702490045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179698003702490045==--
