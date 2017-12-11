From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rsnd: ssi: fix race condition in
 rsnd_ssi_pointer_update" to the asoc tree
Date: Mon, 11 Dec 2017 11:38:09 +0000
Message-ID: <20171211113809.GA9854@sirena.org.uk>
References: <E1eNNl3-0003pn-VV@debutante>
 <661598a7-b62c-074a-a12e-12ed87f4700e@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5412450784885805281=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CCE1266AE4
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 12:38:16 +0100 (CET)
In-Reply-To: <661598a7-b62c-074a-a12e-12ed87f4700e@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, Jiada Wang <jiada_wang@mentor.com>, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5412450784885805281==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2017 at 02:22:50PM +0900, Takashi Sakamoto wrote:
> On Dec 9 2017 03:52, Mark Brown wrote:

> The applied patches are in v1 patchset, but we have v2 patchset already:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-December/128970.html

> Would you please replace the applied patches with the renewed ones? There're
> slight differences between them.

As far as I can tell what's applied is v2?

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloubiAACgkQJNaLcl1U
h9CUxgf+KYebaf/i0rw9O7xnXU54w5OiCyW4ns1cQHc16jwk5zkCkSkW55uepKdp
bjHmMsshHF+Rd/6MVxikBzMXCAz7cw98F6xqG7WqjOFiVt+3a6jB+532DXp3GxJt
ZnFBO+llldgIFJBDx1M/YKn+Xj3dxQljjYNZEPgAeD5Ib1KSmYsS6Z6nnQYssChL
DYJPHTp8TSpJIZln1XI7iUGo/EzsFTqZrAZceX24RpkPsk+uWJAhVPhFwNpYkZLz
pTMc6qlwxylmGDl9jzTif1rm8YVDwTtzlCAJ6qnin7p4S0Ngm8Emm7GmdWMvQqge
TUy+pCs1AmLwmT7DHVTetBl5mw5/PA==
=2tIx
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============5412450784885805281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5412450784885805281==--
