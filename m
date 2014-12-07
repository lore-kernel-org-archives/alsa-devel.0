From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/20] ASoC: rsnd: rename SSI function name
	of PIO
Date: Sun, 7 Dec 2014 13:46:45 +0000
Message-ID: <20141207134645.GR11764@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87egsp83re.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0170896394324156697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 722692606A7
 for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2014 14:46:50 +0100 (CET)
In-Reply-To: <87egsp83re.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0170896394324156697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPxI8paQBs33t8dK"
Content-Disposition: inline


--PPxI8paQBs33t8dK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 08:08:10AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current R-Car sound SSI PIO/DMA mode are using interrupt.
> it is no longer "xxx_pio_xxx", rename it.

Applied, thanks.

--PPxI8paQBs33t8dK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhFpFAAoJECTWi3JdVIfQx64H/i7RPTyP76tEU6E+jvp+s0SO
LHMyh2YEkeQ6Bya3Rs6/SlXrhf4HOYBdjEwQQ+cV/Ms421zMzyzJ7eu76wjYm7g4
qn/zms99OaH+faEGo/UadrhH6aejHeud0M/Sr3wTH/pJ6nES6oZuu9CfLI4UFFIv
3Y9ej/Sp+nfplLdTJCEhJx8Q2sCIz4PGNLm39HWFA9pIqEjWswzssLXfx21lRP9+
JyCz17RS4jyYVjejJ4/mwNXv8HPjMGFX0vo5imoN5SqJO/4TmChzJqTGtFJSlzm3
2R1CfzzaIAucSf9KVmIg55BhbaH+xC9LW/TP52PyFIUWLBlO3G9URzHwwOwjT/k=
=0Y9K
-----END PGP SIGNATURE-----

--PPxI8paQBs33t8dK--

--===============0170896394324156697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0170896394324156697==--
