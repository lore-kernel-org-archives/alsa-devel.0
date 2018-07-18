From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for
 the "Connect Tablet 9" tablet
Date: Wed, 18 Jul 2018 15:49:00 +0100
Message-ID: <20180718144900.GN5700@sirena.org.uk>
References: <20180701093023.6872-1-hdegoede@redhat.com>
 <20180718112545.GH5700@sirena.org.uk>
 <98cf80d0-108a-2340-da5a-70ee3b29ce1a@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1433776028796004561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 79BA926739D
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 16:49:05 +0200 (CEST)
In-Reply-To: <98cf80d0-108a-2340-da5a-70ee3b29ce1a@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1433776028796004561==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 02:54:32PM +0200, Hans de Goede wrote:
> On 18-07-18 13:25, Mark Brown wrote:
> > On Sun, Jul 01, 2018 at 11:30:23AM +0200, Hans de Goede wrote:
> > > Add a quirk for the "Connect Tablet 9" tablet, this tablet has a
> > > mono-speaker. Otherwise it works fine with the defaults.

> > Did this get rolled up into some other series?

> No this patch is still pending / waiting for you to merge it.

I'm still waiting for Pierre to review it so...

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPU1sACgkQJNaLcl1U
h9BiYggAgVbElMVkz/I0xmJ2+MYndf0NJi7DyxAGGDTUMWjQOSQyPNb5BmODmNOT
H7zyv8vgbXPFPR60lkHWvMDEvRdPeBwe0G6MnmkVh+JVRjEYBRWtFIoIJbrR1WAv
UoHsP5UeztGtaBIs6qspIz1TJ0OiiSWAJgPRiEq7jPwpaYrXMmZVQy4zznKqq4uC
UvE0JTY2eeN/+KghHGgv8eyRhQVnWhx1aarEPuTbHVIBosyhiaPvY4QVDKZm3t8T
OPVVsNaN6jeOIn0KEx/yYIglT5gacBWwU+ymy3MwiNlKjMzFrfspVNISld0xmrcQ
O2nlOYT6CPie+2AN4OZ1cB6r/cqzvg==
=aqKy
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--

--===============1433776028796004561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1433776028796004561==--
