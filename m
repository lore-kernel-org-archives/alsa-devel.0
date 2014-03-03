From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/19] ASoC: rsnd: new module path method
	and DT support
Date: Mon, 3 Mar 2014 10:29:17 +0900
Message-ID: <20140303012917.GI2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2846292018925005648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E28265526
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:58:59 +0100 (CET)
In-Reply-To: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
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


--===============2846292018925005648==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Content-Disposition: inline


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:13:57PM -0800, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> These are Renesas R-Car sound driver patches.
> #1 - #7 are clean up patches.
> #8 - #18 adds new module path method
> #19 adds DT support

The ones I didn't comment on look broadly OK but there's dependencies on
earlier patches.

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9rqAAoJELSic+t+oim9d04QAJ0JpFEKbwYLhPaHpdITyNFo
IyBxFiIGNQp5MI1AxwkgWXm+YqiscipiZDUgZfUiiszoHj6Wg4F1WssmHXRLCfvu
wY90d4OHvqaQUdn4Thgg1h+ZabSsno11SUMt+WBNAVglmMy2VYHrAuUZQmBOpK8d
Kj2QuX2+yox1TYi9Da0mi0uC6KWxfQMV5FL0R/41kYUHN8LIokKF4xzHtWI+F+/4
jBqiQEn0mkpAqojVfPzIs+rA71D6+1m/IreRk2DwCmL5M+JX3WX/ymeu+qT5DDSh
PsLRYsGmH2dd+xlDm5ILeKvxsD0/3m4KfcTVEI6oDeuUK2MkycGbBh7VYE7pZ+i8
+taTQoGz3a+grs+Fi2gaoOLuxvk99ixfAmMzecLSAJQ79MXa6qQ/31YaQvNNkuHP
t9L8PXYa6GvWoIcbwUmKfvj/f878KuTKjbUBQfU8kUvVyxK1mV1B7cHAEFrv1cMP
0YglfQviv5iqRWZpVJf79+RB3ujktoRznq1jHowOFGO8neRxnh368uuHiEP2Sw3A
FDD3xHqHg5OBfShXSju3Qg0XGsOO+pw8y8ScuaYJ5bRulJaZAC+qq1eksaetksx4
YjuuBGwgb2Dx2u0jrka0TnplPVCFceOcwnTdGr2uzECO3Caw88HFwBgNPXhBB+g5
hVUCB5DGBcW2ZUHZ3cN3
=jQNM
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--

--===============2846292018925005648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2846292018925005648==--
