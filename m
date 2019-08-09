From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ALSA: hda: bus cleanup
Date: Fri, 9 Aug 2019 12:38:09 +0100
Message-ID: <20190809113809.GA3963@sirena.co.uk>
References: <20190808095715.29713-1-tiwai@suse.de>
 <ae7d32fe-a279-8309-2370-1832edcce413@linux.intel.com>
 <s5hr25vhg22.wl-tiwai@suse.de> <20190808190343.GK3795@sirena.co.uk>
 <s5hftmbie9i.wl-tiwai@suse.de> <20190808213311.GN3795@sirena.co.uk>
 <20190808222201.GQ3795@sirena.co.uk> <s5ha7cij2xd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5133428738027475751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16AC2F8036B
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 13:38:17 +0200 (CEST)
In-Reply-To: <s5ha7cij2xd.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5133428738027475751==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 07:58:06AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Had to rebuild this since git has a bug with recording merge conflicts,
> > just pushing out a new version now - c2f16a94a80497e4b28c27f9ca2cd6cd60706fb6.

> Thanks, it looks good to me.

> And Stephen resolved the conflicts in today's linux-next, too, so
> let's compare later.

My tree didn't get updated in -next because there's some configurations
that don't build.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NWyAACgkQJNaLcl1U
h9B//Qf/Us96n2eBGQIi/DGDGnlSethohcl9KG1hdZrIG7bRn8CRinBpmvOfZ56B
t3IECdQkDOLAeesi1dIAtTGpIr7hHQ3l8TrVm4x/yRhEdNU2bJ6RwhpK/nECzwp+
bUoC8yCcVl5LBiuQh0KY0F5hgSSvCtrq4uSpq1bcmo3X2prPoikm71LAjEz4Dqq8
sF/XGRf8MqVDq9aLMYenGNljuMXuWNS4UnOh0VzQjuwsFuQoZQ8fNCCr1c0dWxT2
uzRBTkxUlYIviAZ3BcqXjWykdFxOAgMx+Vjw+uKmCFdUh8i/08jCVaK0J1pL9tju
K4hlvjcW2oXlziAADVrdFUAPlLAH6g==
=TQ0y
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--===============5133428738027475751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5133428738027475751==--
