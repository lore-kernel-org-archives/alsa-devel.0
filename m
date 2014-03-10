From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: card name can be option
Date: Mon, 10 Mar 2014 07:53:59 +0000
Message-ID: <20140310075359.GC28112@sirena.org.uk>
References: <87vbvmrd6m.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2792532317997488396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E114265644
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 08:54:06 +0100 (CET)
In-Reply-To: <87vbvmrd6m.wl%kuninori.morimoto.gx@gmail.com>
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


--===============2792532317997488396==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UM/nhyzmHiej+zYf"
Content-Disposition: inline


--UM/nhyzmHiej+zYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2014 at 07:37:56PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> snd_card.name is now option on DT case.
> non-DT case can follow same style,
> and it is understandable from platform point of view.

Applied, thanks.

--UM/nhyzmHiej+zYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHW+TAAoJELSic+t+oim9OYEP/A0b92NnamXes5kLZeb9+AXu
pJTVkG/QEcUUI3k5PdprnsYDrunpXXF7ORxNCz+oPQ/LFzvuI93qxASDrEdKzIVC
fkJqo4knVoIIHNo74cdKDkTI/dhwnbWcBXAO5S5zvvSiRjwMY5R2QfXsHo2Lk9ch
bNVdE0vSJ9/ugYHM4WLSU06dORWx9+AlaegfPfofCeAMjr2BbkIq9UWNM9lax/09
KX7FSGgNIftZh0cMEc0ZKBWzYRkMcMlF0WGYlEXdl00Bcbd/VU9Bpa1dUn7pAAKs
wg0/460pf8hwIRw+IHGPHosLTyX353b7iPmglal0kQLgUnLge2tZU4iy+tuZ86B8
GDjrWYOlmQ2TfMe9alywszPV4U+8ZkKto1fdcRyFJVthbHoj/djApYdrQLZsc9BQ
Ni9AoahxDeiLq27YO1MsfTcx2dC2dyR5GRog32nzP8L6Q0xoHKrIr8fmSCBxKoMS
u9a5zksMGydN8y/Xh8xSMopZHeum6NA74245IDCZcsDr8GAnlE5mNNEwql9g+SdT
fly7CEwb34fJPGPOXdfKDzcbG53DupSjx9vblBxRS2Tyx3pDIccIYxBbSnwfAcB5
UoH+NmeiYQcMuIi292JRXdE6uxIku9Iluabn3BsGtwpV39McGOmeGa+BPqMPP3Ic
vHM2hrA21Xtnw2279EMN
=F3yU
-----END PGP SIGNATURE-----

--UM/nhyzmHiej+zYf--

--===============2792532317997488396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2792532317997488396==--
