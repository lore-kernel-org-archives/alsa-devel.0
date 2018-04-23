From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: msm8916-wcd: use threaded
	IRQ handlers
Date: Mon, 23 Apr 2018 16:25:59 +0100
Message-ID: <20180423152559.GF19834@sirena.org.uk>
References: <20180420120750.356-1-daniel@zonque.org>
 <20180423144901.GE19834@sirena.org.uk>
 <4ec0b0ff-f5f3-298d-8aa6-d4c16aee68e6@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8459576968299176865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BCEE266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 17:26:00 +0200 (CEST)
In-Reply-To: <4ec0b0ff-f5f3-298d-8aa6-d4c16aee68e6@zonque.org>
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
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8459576968299176865==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 23, 2018 at 04:54:22PM +0200, Daniel Mack wrote:
> On Monday, April 23, 2018 04:49 PM, Mark Brown wrote:

> > Someone already submitted a fix for this which is in -next already?

> Ah, missed that. Nice, it's the exact same fix :)

Great minds and all that!

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd+wYACgkQJNaLcl1U
h9CZ8gf/QAaOLYwApVqU218ZpSbWez7X4JKDldBdG01j0ZkqUXeID+esybpJ6Zjg
D6sGMSeVI1XpHXKD1zzI0AgJoIwpxxcED5rVaJoXT7fe0+zBLSjq3iooEDiCoLIn
fGP2vrsPR6MrZv6ogKrmku3z0o95mdKHWp0nnsMnuI2VZgoWSohCbHVs5STcWK1r
BCTxzZNBAjJ5ot3/R9m+NxSWGDPWDKfl7xGO+dza986H/lffM1SYlwwxrutCetmg
pHFSoa9TPCzek16QiIaM5iShlMTZWD86M2szY/CQEWnp4RPO/psTLCUANkzQ+qCC
TCR6u4+m/eo6wNUPIjfUu51qpEmKAg==
=V62s
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

--===============8459576968299176865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8459576968299176865==--
