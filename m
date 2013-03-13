From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ASoC: fsi: use
 snd_soc_register_component() instead of snd_soc_register_dais()
Date: Wed, 13 Mar 2013 10:14:11 +0000
Message-ID: <20130313101411.GB25610@opensource.wolfsonmicro.com>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87hakhtnjl.wl%kuninori.morimoto.gx@renesas.com>
 <20130312200253.GI19942@opensource.wolfsonmicro.com>
 <87zjy8f82b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7807013322742338026=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EE43264F0A
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:14:13 +0100 (CET)
In-Reply-To: <87zjy8f82b.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7807013322742338026==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 05:38:08PM -0700, Kuninori Morimoto wrote:

> It will have double name...
> Is it OK ?=20

Yes, it should be fine.

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFFlAAoJELSic+t+oim9LDIP+wVjUugbhylKnhmTZVvKIds+
J6WrWhNl1BEZGebwFaAn64XEfX2qYFOHfppfDPQYr4niWnwINR6nIv+xfhu4KJFi
PJPf1SAVnvUVBSDZxv9ivD2xDZWeG9KsKArA3m2bYfwe5tNg+/Roaa/e0i3vYO56
RAHuhztowNKZc9wXoE8y4o0wXmPXSNpAfQRyCbsFzFhUreKEZlbQ191LMCY8sXYi
NF4eSDtKEOBLqbBunv+fB4h2IDcT7/XWSxTOKGpTKRfkM/vaESuMv/j1A2VbbaCJ
Fkk8A54adNIOVp0lQmY/F+FBVpXvD7HQ8a/wOziVLeZkuVCsDtozMVIwxR4HyA62
91jSWOMhm9UJNUVQ9/CnebPorkuqCywefJMBbZ4Sm/6nZzMkOsGe6Vhw8MRBwkiT
Cdf3fuoA64opGJj3l4f9/LZjYngErUNcad8yzPkHb3nS+Z/LfasjIYy9O+ViQioH
LhpnMfQWB98qN70Yg+U2uNcMtYQ3UTVMhUvOMOUix7VdeCOBZMseUdhPjJYyEJYZ
jqDtv8gz0KImBa2pBE/9m3y9v8+IWh9sk5XvBDjgZq6ttvYDfy5xJeb26gO6EiuC
GfpxJeNqOsoBHvK0pc/oxtMeIhc47d35FKtTvIJ2U2/ashHeNJBuBd5Oq5WFcoam
kKtGkMT9OznF52lNBYo4
=Umff
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

--===============7807013322742338026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7807013322742338026==--
