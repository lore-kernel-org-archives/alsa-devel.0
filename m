From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5][RFC] ASoC: remove Codec/Platform code
Date: Mon, 16 Apr 2018 17:34:45 +0100
Message-ID: <20180416163445.GD20726@sirena.org.uk>
References: <87muydf7t2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0342210905794190637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 580BE2673D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 18:34:47 +0200 (CEST)
In-Reply-To: <87muydf7t2.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0342210905794190637==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 02:14:01AM +0000, Kuninori Morimoto wrote:

> I'm posting replace patch for 2) to Media / ASoC ML,
> but not yet accepted.
> (= I think it needs Mark's Acked-by ? I don't know)

No idea, if they applied the driver in the first place they didn't wait
for my review then!

> I think this Codec/Platform remove patch should based on it,
> otherwise, compile error happen.
> I'm happy to re-post this remove patch if Media side replace was accepted.

Please, this looks good.

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrU0KQACgkQJNaLcl1U
h9DyfQf3QKj2g3xjuOGlSMi5yEDtvx633EGr1TdjW1Nh98JLBoNg8CzTALH9KZmz
Um9Dyfc2JcsI+eG6aX30kS7Sv48StnAqsx1VC1N5olYIRd+nTUyjTzPgTpo3BaaR
uny5Az7DoCnmQc8Wjsi+FzpHZPCxQ67XQmt1Dh+tAteafjJwZ1ZQCQqTc1Finnnd
DdRf5vjJGICIitGTPXDVL8MFVpRU5RlXJmDiyGUyDCePBQ67qEMbfEdOMgaMIeGK
eQUj7yH7CDX/Ycp0YqLY2mHzP+drxGNABWLaEK2Hub5tVLtX0+cMbIB6xQBZWKzM
YDdpI3jRQN3kGK8P/YKtq+YtVcRm
=2lg2
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--

--===============0342210905794190637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0342210905794190637==--
