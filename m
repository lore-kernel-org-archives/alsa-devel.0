From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Mon, 25 Jun 2018 13:57:11 +0100
Message-ID: <20180625125711.GO9413@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
 <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
 <20180530091011.GA6920@sirena.org.uk>
 <ace99dbd-3480-9ac3-e5b8-4ddae73bba10@zonque.org>
 <b006a926-09ff-59e0-2b88-6f15e3e714e9@zonque.org>
 <20180625112440.GE9413@sirena.org.uk>
 <f7e05fe9-c177-9a78-e09d-0f74c2427b63@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7262351106040628704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7695326720C
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:57:14 +0200 (CEST)
In-Reply-To: <f7e05fe9-c177-9a78-e09d-0f74c2427b63@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============7262351106040628704==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8WA4ILJSyYAmUzbY"
Content-Disposition: inline


--8WA4ILJSyYAmUzbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 25, 2018 at 02:55:12PM +0200, Daniel Mack wrote:
> On Monday, June 25, 2018 01:24 PM, Mark Brown wrote:

> > No, I reviewed my patch in there.  What's going on?

> I'd like this patch to go through your tree, if that's okay. Then I can post
> some more patches on top without causing a conflict in the merge window.

> Robert is fine with that.

That's fine by me.  Is the latest version v3?

--8WA4ILJSyYAmUzbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw5qcACgkQJNaLcl1U
h9Bh7wf/ffhFO/2j6+D9VTbeZy/A4cswClpMgX3omc8d0DFgZ1UTloQaXkdYqkck
of9ka7FmomARHBtd17IPsq0yhMra9FLpgCXdJm2P0E+kqU9ex3KyRUSuMfKlCtn7
Oq7e3OZrNLeh2iWuFJih4Sd9U3CJyFYzyABJvPL3VRqaZ+vdl7EO8iI36zX8oeAK
/60qgXIRdwgsOrq8TqTtl9+m7Z81nEgB24XViphQZpUqlrFtQxpyxIGxqg+QVXQ6
0bcO9m/FueueHThxqgUieqUC4CNchBdbAOV4AaXAe+bsKA1ZcFg9olGN0qtJYGCb
ieEGKRfK3lq9x6wcMbwBMLoa0i6LPg==
=Bosl
-----END PGP SIGNATURE-----

--8WA4ILJSyYAmUzbY--

--===============7262351106040628704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7262351106040628704==--
