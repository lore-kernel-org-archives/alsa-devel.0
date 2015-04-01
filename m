From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: add Synchronous SRC mode
Date: Wed, 1 Apr 2015 21:23:51 +0100
Message-ID: <20150401202351.GA6023@sirena.org.uk>
References: <87twx032on.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2558581008320923864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DDEB26512B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 22:23:58 +0200 (CEST)
In-Reply-To: <87twx032on.wl%kuninori.morimoto.gx@renesas.com>
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


--===============2558581008320923864==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2015 at 04:15:16AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Renesas R-Car sound SRC (=3D Sampling Rate Converter) has
> Asynchronous/Synchronous SRC mode. Asynchronous mode is already
> supported via DPCM. This patch adds Synchronous mode on it.

Applied, thanks.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFPWAAoJECTWi3JdVIfQ6C4H/0zj9YzCOC7DMsCpThLQh9mu
DxfY8jQa0ELI0MO4wCom6jOkdYNFQl8BOIIEU036coNOneERGIwlWmP8Rlg1Z6/v
hIqC0mGhqkQrcv3i/i7rJLJ/KvB3iTsokZumUXjYi2t6ClkD3ojAjLJispdzi5Lu
lQdMy9G2dhX9cBUR35jVv4KhZEhzFIGqra5SOFp7m0GFsOAWlTwbdSnp8rfnXyqD
2lrmiaB+wsilcZ1Js5SSV2Csa7w6uGdqSUCCb+mKMh4irgfsxtz909fs4KuGyde8
MkI8AWKWqH51Tak9YbkUOx34lEmB8wzSOZ8IEGxGKYI9cAyguMyEcrnOl65eUxM=
=k5My
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============2558581008320923864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2558581008320923864==--
