From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: tidyup get
 dai_link/dai_props from priv
Date: Fri, 12 Sep 2014 15:01:06 +0100
Message-ID: <20140912140106.GZ7960@sirena.org.uk>
References: <871trkytuv.wl%kuninori.morimoto.gx@gmail.com>
 <87y4tsxf7m.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3471154095530710115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F9ED261A64
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 17:39:13 +0200 (CEST)
In-Reply-To: <87y4tsxf7m.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3471154095530710115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w5er4h4/Yf2qR8D9"
Content-Disposition: inline


--w5er4h4/Yf2qR8D9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 09:38:24PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> It can get dai_link/dai_props pointer from priv + index

Applied, thanks.

--w5er4h4/Yf2qR8D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEvyhAAoJECTWi3JdVIfQGawH/2OiI1Yi4EI70QGZI/x2rl4V
IfB81X4VmbUFtMg9zixp+VaTUaMVSilJZbMltBh0K/asIZq51YaTMuUahsGk4llw
loFrqZTGbjCHwkN10DLHZIcbHj9BBTnhfHLdVQPSSqQLRJ4stdxtYbCQsfSEcpSa
91Vy5TvCFIGEgP2kCbwInZkO9te5VumuFvaGki63jfABSWCkveYvE/5MFf7jijra
uzpZNXNKcZdMH59Gw+gdruJk8zxAheTutU/Y2P9LWHPrWrafR3NhTovuSO26cdcF
hV3W38PkMvq5LklAw/qHWFt0Mi4iyD8s81AnjPtlGCWb+HO0WskJeWloENj+l80=
=xlx7
-----END PGP SIGNATURE-----

--w5er4h4/Yf2qR8D9--

--===============3471154095530710115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3471154095530710115==--
