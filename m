From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fix for v4.14
Date: Wed, 15 Nov 2017 16:09:53 +0000
Message-ID: <20171115160953.rcep7zd5c2pu2f25@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8726957027243917611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF03266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 17:09:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8726957027243917611==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osacawsakyica5w5"
Content-Disposition: inline


--osacawsakyica5w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit df6a3e245541ac61cc99f2887437e0a43dd08f2e:

  Merge remote-tracking branches 'asoc/topic/tfa9879', 'asoc/topic/ts3a277e', 'asoc/topic/wm8741', 'asoc/topic/wm97xx' and 'asoc/topic/zte' into asoc-next (2017-11-10 21:31:33 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.14-intel-kconfig

for you to fetch changes up to 20a52c059be2eb470db75076d55e1d932173fcc3:

  ASoC: Intel: Add help text for SND_SOC_INTEL_SST_TOPLEVEL (2017-11-15 11:43:41 +0000)

----------------------------------------------------------------
ASoC: Fix for Intel Kconfig

Fix the Intel Kconfig issue reported by Linus.

----------------------------------------------------------------
Vinod Koul (1):
      ASoC: Intel: Add help text for SND_SOC_INTEL_SST_TOPLEVEL

 sound/soc/intel/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

--osacawsakyica5w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMZtAACgkQJNaLcl1U
h9BvSwf/Y2HrdNWNhRZx4WwamhdZWff1JgbkASrqt67sa+YLhkur+x7Shtzu3JsG
1ZSlGg4wgB7ITFdvPyN6G6RxZIQABjlncCW0/LDJObCUgs+wgODRQ7RjCpWIb65U
BQQ7KTz26HcaVZbg9ADpMVbGfVjZuYzA96skMbGIKq0Np+M3tk921oW5eFqcjK5W
1PuV09TvKDK1uNrCF1782gSbgoY3/9BLMrRBxL1PPL28NQ5pdxAaiQthudGWllHd
BXodZt4i7/KjP/w7Rc94EzRuDjxMiV8x0o3UFq39axRTL/dCTZXKX73hflIcx7xe
v43nAgOyAYVj52rD4PjQnoHwVV02Ng==
=5f84
-----END PGP SIGNATURE-----

--osacawsakyica5w5--

--===============8726957027243917611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8726957027243917611==--
