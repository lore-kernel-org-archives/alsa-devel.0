From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Reenable use from userspace
Date: Tue, 27 Oct 2015 09:22:21 +0900
Message-ID: <20151027002221.GK28319@sirena.org.uk>
References: <1445830900-1752-1-git-send-email-broonie@kernel.org>
 <s5hziz684sw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4100346636301595417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04897265051
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:22:39 +0100 (CET)
In-Reply-To: <s5hziz684sw.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mendong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4100346636301595417==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2015 at 08:30:55AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Are we OK with this?  Looking for some acks and reviews...

> Don't forget to add this entry to include/uapi/sound/Makefile.
> Otherwise it's useless...

Ugh, well it's always been useless then :(

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJWLsO8AAoJECTWi3JdVIfQhTUH91+3KSL6id+COg34rBI8ctaq
95VVTqSY6sDJsB5nBmGtFbIeutSzB30y0sXmXzn2kVT7PXg+BfHLAcAj85y5qt4f
IZGqJNmbjlA/n4/UDrSOFGsGICkqh2OA2BXKCL/Ga+RIzA+vd6SiLfvCAYbs8K9u
iWAW+rb6dpKOkWQ9J/K8vhbypa7aKPgY1q2gOAjycX6Ya2dAqbCB9EDH+1LYRct7
cMIeupBjVksGa9mQogJ9DGVdCBADYa1KyM9pqBT0IEus47W3kHnFLu6vVkLj8Z3X
XsFN/pnYhZfIgl3OMGPIxrY4QznxEnImNjHrgdpEdVp13srOyr62cvt6lJQKpg==
=RM99
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--

--===============4100346636301595417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4100346636301595417==--
