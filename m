From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: soc-core: use
 snd_soc_dai_link_component for cpu
Date: Thu, 17 Jan 2019 12:48:06 +0000
Message-ID: <20190117124806.GA7003@sirena.org.uk>
References: <87bm4hm30t.wl-kuninori.morimoto.gx@renesas.com>
 <3b1f5c02-65e1-b43e-3556-129d48c2375d@linux.intel.com>
 <87ef9c6qob.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2746562385414340311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 253F9266BD4
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 13:48:07 +0100 (CET)
In-Reply-To: <87ef9c6qob.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2746562385414340311==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 17, 2019 at 10:14:39AM +0900, Kuninori Morimoto wrote:

> 	Subject: [alsa-devel] [PATCH v6 0/3] ASoC: Add Multi CPU DAI support
> 	Date: Wed, 20 Jun 2018 16:24:14 +0530

> If so, actually I'm very waiting this patch series.
> But, it seems nothing happen on ALSA ML after that.
> So, I thought it was rejected or something happen.

It's definitely not rejected, it's just huge and goes right across the
core so it's extremely difficult to do a review of.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxAeYUACgkQJNaLcl1U
h9CS3Af/a+crgOu46sTzRVV+RCXDTh6T1hjEQfemKMVpAVopuclB1pmQL1SYxOc5
mILoipiVs2Tg3+3Jnu0N5GtHt0KeRc5goNSjIwqtHcUsdIINlXjqhiet3X16sbJ2
mVDyzpMr35ui2Bp7b19lurO3/aBhfe/1Iv1bnlb8SEKO73Sdgot+cs9Ipv5gNd/x
UxI3brYqxVh0fZ5LVr072DkyxEni5aA0ZvTOVDJnA7XYfMqm03MuAuHba+vg6JyQ
QsQGmb7XluVixgCjZ8IS7IA49hQDDptw9u50tNm2uhAwQ167tov4ONeuyCqkE/Xv
3VGLCVtlUkTRKMqozmNrYFSAcmkBXA==
=x26W
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--===============2746562385414340311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2746562385414340311==--
