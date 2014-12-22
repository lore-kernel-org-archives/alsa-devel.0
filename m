From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Fix BYTCR firmware name
Date: Mon, 22 Dec 2014 15:08:09 +0000
Message-ID: <20141222150809.GX17800@sirena.org.uk>
References: <1419259760-19066-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5167451109731303213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D15A12605F3
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 16:08:30 +0100 (CET)
In-Reply-To: <1419259760-19066-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5167451109731303213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aSOv3uy5xJSQbCk1"
Content-Disposition: inline


--aSOv3uy5xJSQbCk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 22, 2014 at 04:49:19PM +0200, Jarkko Nikula wrote:
> BYTCR DSP firmware is in intel/ subdirectory. See linux-firmware.git
> commit d562a3b63632 ("linux-firmware: add sst audio firmware for baytrail
> platforms").

Applied both, thanks.

--aSOv3uy5xJSQbCk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmDPZAAoJECTWi3JdVIfQdKAIAIC2PaepTHfva6AtTQnxpwwQ
7Zi97pEUp1oLTSvxdzV9/RYoTktDbmg94uAXKoHtxXmN45O84sGsHAcplK+LZ3Ut
rn1wZnI0aFi2vnhTBBbgtqYSglA0ahe4jBUCFNGWez4q/0zRv+C7mSxL8sqeZ3WS
sE9Akn73MGIbzTNBoGBPNr1oFA2HvMKaEQYxpk3R7+SSZxwKwdJGqVVfVm8uKc0R
jDPVZ4T3UdrT13AUoM8ypN+1a5712TpQ6t2e3K9vw119k5EYMNbe5/X3EVRr9egt
6M8HF/5xq7jjnSeoKgyIQXK80S2x8mZI2DqhPo48B168hFCEQSJLeHBPSbGYicA=
=TPTy
-----END PGP SIGNATURE-----

--aSOv3uy5xJSQbCk1--

--===============5167451109731303213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5167451109731303213==--
