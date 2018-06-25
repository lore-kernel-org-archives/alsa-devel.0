From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Mon, 25 Jun 2018 12:24:40 +0100
Message-ID: <20180625112440.GE9413@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
 <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
 <20180530091011.GA6920@sirena.org.uk>
 <ace99dbd-3480-9ac3-e5b8-4ddae73bba10@zonque.org>
 <b006a926-09ff-59e0-2b88-6f15e3e714e9@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7427591268174346333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7764626777E
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:24:42 +0200 (CEST)
In-Reply-To: <b006a926-09ff-59e0-2b88-6f15e3e714e9@zonque.org>
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


--===============7427591268174346333==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 23, 2018 at 08:41:27PM +0200, Daniel Mack wrote:

> I'd like to get some of this done for 4.19, but for that, I'd need Robert's
> patch that addresses DMA compat issues in your tree.

> Not sure if you've followed the thread titled '[PATCH v3 09/14] ASoC: pxa:
> remove the dmaengine compat need' - could you chime in there?

No, I reviewed my patch in there.  What's going on?

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw0PcACgkQJNaLcl1U
h9AdSQf/RiYmfpfH/iezMbGpr2xTXZvVZ4WgXWTNsubCl6tuQLZAv+5eMQ7k68nF
22jVkgOH7OQCwOXwZoupg/Ze1/KyyR4GBPiYac1XIOh1iOkWfV2jKuKXI5BGQCER
zWW459vgSjy4uQUy5MNTBIMxBEyW6Hce7/nTinIwdzMbahkflA7dSivwpcbj2pZT
3kvn9Gyrr8Inrngp/EFe+azrMi/e45/fTFNMTuz4RyCb57HjzKMuK43PAoUBNh/r
Whc2rmTaUPGUGrbI55LQWEaXkj+eJodgjDiwR7onIgirX1BTDFrBV/Rzzo+L5tg5
o3teFkzK8loPqm2tr0a1uS543W0VJA==
=1Qsj
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

--===============7427591268174346333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7427591268174346333==--
