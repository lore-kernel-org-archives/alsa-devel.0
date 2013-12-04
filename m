From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: use devm_clk_get() instead of
	clk_get()
Date: Wed, 4 Dec 2013 11:50:20 +0000
Message-ID: <20131204115020.GA9403@sirena.org.uk>
References: <87siu9kuzq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2310016359526730437=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 48952265366
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 12:50:24 +0100 (CET)
In-Reply-To: <87siu9kuzq.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2310016359526730437==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 10:09:33PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnxb5AAoJELSic+t+oim94SoP/A4pvWaDxepHUDhKL33SCSn3
AHo4IYoT3p1XJ1VuwIuPIz10OU0L1WqZ1EnBkoy9rmQbjQNkWUSMpqBnqOqvS4nl
jUKPaVluMqdYR9vLKqwZToklcY67sAMWEFrBeTqRUJull96CLstGAaCV6pCYjH7/
vBXicdFJ63qixcSOhUSnNeYVP5HneZS8SQjFyj2OTr5sT0skF+RRap0o1VtzAJFa
MDpS38tozx3CEz9PsvVuAMmF+UHMUT4LQ0cKtvRmOwY8PADNazjGKD1oWSg6dc+N
xGBN2ki95OKlnWaymFuPQtFu3tHOjeFPWVMBJORFIyosGza8DF+ZWYA7wbMoanf0
yUStRfQgvvtV3Sxd6+06G/aztKGSaq5aGOvjU2Y+PWOaCChgW8hcn3ciwKt0nhLI
ufvkJeDV3H6RS3LOog2xLZt7yMWvxcYqGuE/wsD9p8tfaTT0OFb60hM1O9sJZGbP
VIdrkayyyE1quRz7IZ2B79HeAlj0ygVUKvjXymVRsGZDkJrI+6czCQauMrkyURq4
17vE7LKJ0RFe4cG9BSY5106/C9Tr/h8+Y+q+CR6p3Gl03HM0RaL2kyCHXMoSjw2D
5tAXD0BolwK9FePXlj7berz4knH82ruyy8Tw1WZA0FpiY4QYy7En5ocGoomoScFS
dsY7fpJWr7JVXhoyliSd
=VgN+
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============2310016359526730437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2310016359526730437==--
