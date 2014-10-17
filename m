From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: Intel: mrfld - add the dsp
	sst driver
Date: Fri, 17 Oct 2014 11:11:06 +0200
Message-ID: <20141017091106.GE3771@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9056903270247617589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 199EF2619EA
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 11:11:22 +0200 (CEST)
In-Reply-To: <1413469819-18775-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9056903270247617589==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 08:00:13PM +0530, Vinod Koul wrote:
> The SST driver is the missing piece in our driver stack not upstreamed,
> so push it now :) This driver currently supports PCI device on Merrifield.
> Future updates will bring support for ACPI device as well as future update
> to PCI devices as well

Applied, thanks.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQN0pAAoJECTWi3JdVIfQs/8H/0JH1+SluMDiZpL3S2zjlvCI
3ufzFqTL6LOXBgcmaB/Bs2cI9hBdNNLGFRbpWj4oTxXeKW73DTnXTWP7i1SX+Bjg
vpxfuSLUQ+WxD8Rk4vJlx01QKZ4J/BDn1LaBnLsLkkvhRNcdLkppNvIA3A5tQGBf
rVtRQzaUkJtR0V5eb0jDbXQxWTWL8tYFIkzf6bCYxfPktOkTbNx2TT/LqSQ9Z6w/
BBoebsvT/WIJMir84nR5LfIWXRS4xOwSXFWUHq9t1NTP2ilzzDOnyZ7z90rUQwBD
/F+PiazvRjUQQRBFHdPZijpDbtzlnwH7FWFiZbkkjWQOQbh8d9rRmOUirxcPcv0=
=e7WN
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

--===============9056903270247617589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9056903270247617589==--
