From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10 v2] ASoC: rsnd: DMA cleanup for
 flexible SSI/SRC selection
Date: Wed, 2 Jul 2014 12:25:54 +0100
Message-ID: <20140702112554.GE410@sirena.org.uk>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
 <8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
 <87tx7csaq0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5168479106590696914=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E20265142
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 13:26:04 +0200 (CEST)
In-Reply-To: <87tx7csaq0.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-sh@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5168479106590696914==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2014 at 05:58:26PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current R-Car sound SSI/SRC/DVC selection has feature limit.
> (It is assuming that SSI/SRC are using same index number)

Applied, thanks.

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTs+w+AAoJELSic+t+oim9+LwP/2bfLU6kbUnpUaTrvra2sYt9
AABmQkd0cK8WEDWdEp3wHqIBSwMg9z8LOXDfvhBMI/x3v73zTQRqMhCg+KRTQ8ns
pdAqvSAP4Lt7x/zTvjDzBhVuSxKuVScNgcky9YqOVpyDj3Fo1qyH7MCe2mlSJk6D
2S7WfxCeLGV2YvgMPp7hrdBRrkskaHEC0V61oTNfS74nhg1PHmzRVm5nwXRN5XF9
OZcNOIMdeYv8AYJNaXz5GbC9OvzNjkvnMxe1LlU5k0l8+KCbRmhxEfzrpSN7PXQ7
Ca4j6yWT1tdOh7bdEb4J5L2SSp7MaJsfWtZu2J5hFwhNp31lZlygn2K8E9HPcgS+
W6dICcheZBKdzRY8XRzZk+wwwOT1uK54lZh/xKk//iP07kj/Wlrd+6mqHqUB436l
WPMBE5742k0SdtOvWjqvp0usIL6ITBvb9Ad1BM7HjSzEoR0fKm/afZ/n2yGmmfHQ
Uuqv7z5zILQNrORtu8AORndIJizj1vERl5YDtgMCCk3I6bZXvFgzWQOBLY0YHZAL
Xy8EIvAdF20lTnqeZkih90rjyZoSMQY2a2HDOC0j6KOp+XSlN6LTHHSTgxq1jEeE
lNX9qQaGpSeUcsvM6XpFJvNke4S44aJZHhn8ZbCouaSHWgp9hRsS49wHbNXEq3lw
qa+f2utJc4vC2AFw+0AC
=KI0K
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--

--===============5168479106590696914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5168479106590696914==--
