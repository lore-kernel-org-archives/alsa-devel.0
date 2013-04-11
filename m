From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] mfd: wm5102: Map in additional FLL
	control registers
Date: Thu, 11 Apr 2013 18:22:11 +0100
Message-ID: <20130411172211.GT9243@opensource.wolfsonmicro.com>
References: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1362551296-14920-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130408162223.GC24058@zurbaran>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0921800242016604487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1ED5266195
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 19:22:12 +0200 (CEST)
In-Reply-To: <20130408162223.GC24058@zurbaran>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0921800242016604487==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CVqly4l7FfnzS7sR"
Content-Disposition: inline


--CVqly4l7FfnzS7sR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2013 at 06:22:23PM +0200, Samuel Ortiz wrote:
> Hi Mark,
>=20
> On Wed, Mar 06, 2013 at 02:28:14PM +0800, Mark Brown wrote:
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  drivers/mfd/wm5102-tables.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)

> Did you merge this patchset through the ASoC tree ?

Yes, let me know if that's a problem and I can back stuff out but it
seemed sensible.

--CVqly4l7FfnzS7sR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZvE9AAoJELSic+t+oim9VsoP/1bYLEGFoaICCRzCbdB7zFU4
vvY/w+c3b7LsHBDwM18tgeM1AUt8j9BFwuD3Op6g9ryMVC/LigI6XnqRuiiZd3Yy
dktVikAp6BZ2q9F1+JsAHeNpmttiWd67GfWM74UV/3XD9bzyNldEssuOCdWx67nR
mmaznT2i9Kg239gn9btYzXEA4igqZstJhQoEhBMjZ57hzN2FHgfWxBj7AZe9DAvE
lz47nBtaXrd9tgdni5EQwuhW6yrGw4RGjKL0LwyHegIlTqKeUKxGebYBV6vT/bsn
WOEKtqyBb9Yoy0D/B8fr9rCMf8XQtFr9O3J7J2xHElDfqG/OcLHWK18rdR0peMFB
a0UPGKM+0JvlfrC6A/YyoFpRchAfXH/NGmLAp3pmQl46ltFYr5g6MBM3u4rjENF4
O/LK2lKAZaFTrHIf7sgp8Opv35OvgoS63sJsWuimFKqs37kmZ0XYy+/xo9XWFVfa
+xzVyNhOQPea0PD29w/4UFWYry7Odw5ezrMV4pU1elWo9KTYbNrbkGxqxXabK7Fo
Jf0/r1xONxHcennIi1saZuM+VTMqkQl+tWFJQmekJXC51MPEMDVjPYE+v9FPrpga
OjO27FdAsMssZ0x1v9p/xttIxusw1N8kbdhPbaSMsThdypStiQDnzBzJMs3SxuHZ
aICOCeDT4I+fLmiKo+T6
=QV7n
-----END PGP SIGNATURE-----

--CVqly4l7FfnzS7sR--

--===============0921800242016604487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0921800242016604487==--
