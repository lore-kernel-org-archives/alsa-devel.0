From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: rsnd: tidyup RSND_DVC_VOLUME_NUM
 to RSND_DVC_CHANNELS
Date: Wed, 22 Oct 2014 23:46:55 +0100
Message-ID: <20141022224655.GG2344@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <8738ag7vou.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3882754271252686323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5904E26530F
 for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2014 00:47:05 +0200 (CEST)
In-Reply-To: <8738ag7vou.wl%kuninori.morimoto.gx@gmail.com>
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


--===============3882754271252686323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Edk6HoYKP7RsK9ib"
Content-Disposition: inline


--Edk6HoYKP7RsK9ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2014 at 06:13:56PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> RSND_DVC_VOLUME_NUM means DVC channel number.
> This patch tidyups this un-understandable naming

Applied, thanks.

--Edk6HoYKP7RsK9ib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUSDPeAAoJECTWi3JdVIfQowkH/ROyJnrTmVGbJSZ0+sGsQdVc
00kGlp8acOSYOCBuNYCYhJfZiIXGRsF2tpnMAX3SXCB37J99VLaxngl0UB6mcugK
N/oPKeSQJcwNnapkceaFEz1aZ49tvoucpuROvNNhHyVVoed+YT+8yyde6QE1sL7A
vcJt6iAsC1Wo0Ibay2IW4UvmaBStbeVoOcUly/cPEt1Zsh/tWuwbEqSa5CLp8Ha6
SkFhwhDZuHkOKYit5F+CZqcawvmi34bIa1e2PzyXPEkbuSyfVkp0dgt4/t8fYPnf
UBt01Wu/VlZYLK76hlVrm0jv55INEpX8ThqvL52zwtqGYMvEQWDBfraE7XsG7dI=
=ZqSR
-----END PGP SIGNATURE-----

--Edk6HoYKP7RsK9ib--

--===============3882754271252686323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3882754271252686323==--
