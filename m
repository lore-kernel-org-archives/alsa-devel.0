From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7][REBASE] ASoC: simple-card: add parse_clk / parse_dai
Date: Mon, 8 Aug 2016 11:32:34 +0100
Message-ID: <20160808103234.GD10383@sirena.org.uk>
References: <878tw7ajwu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jSXJDi5r/aeatSyx"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878tw7ajwu.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jSXJDi5r/aeatSyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2016 at 05:58:34AM +0000, Kuninori Morimoto wrote:

> These are rebase version patches for parse_clk / parse_dai on simple utiles.
> I think today's topic/simple is missing [1/7] patch, but have [2/7] [3/7].
> Because of this, it has bulid error, and you can't apply [4/7].

Please don't resend already applied patches.

> These patches add new functions on utils.c, and I noticed that
> it will have conflict with fix/simple branch.
> Because of these reasons, I think you want to redo topic/simple branch (?).
> These patches are based on fix/simple branch.

No, I'm not rebasing.  I can merge the fix branch into the main branch.

--jSXJDi5r/aeatSyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqFksAAoJECTWi3JdVIfQAn4H/3/fc6Hg9cejdjyVz1g6S+/s
iLHG9zD4wLnCHFeFfJlrhKKzPNbJBxlbFzNhpE9V0URK9zOu4GkPyIOZSyNAs/U6
nQGAN7TYvfZtcIgXczKekMjKVnCRpm6fz9MD7/jeWfQa32TwqZXk2gNHkPNipnlp
A5oSphH8/muUP4+8XjGDkOW5Eda5tUw3zOjPnkPnRlplF6iE7z+QW0H7vcfmdNdf
K9vh7g/VD0wOhom0Xu9EarUNbQgKU1Wfxepk3exM96wK172BQyz3kek/n/JL2A+q
kdYL2CKdJ8e8MIHFtFpgRdefyii++4/kuxLbRfSJV7enGPI9vziu/LHHZJr1Alg=
=XUML
-----END PGP SIGNATURE-----

--jSXJDi5r/aeatSyx--
