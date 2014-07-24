From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/13] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Thu, 24 Jul 2014 12:50:40 +0100
Message-ID: <20140724115040.GI17528@sirena.org.uk>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
 <1404967497-22537-12-git-send-email-subhransu.s.prusty@intel.com>
 <20140718121920.GO17528@sirena.org.uk>
 <20140718142623.GH1985@intel.com> <20140724061803.GD8181@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2344282692348114094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2052265521
 for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2014 13:50:49 +0200 (CEST)
In-Reply-To: <20140724061803.GD8181@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2344282692348114094==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W1bsJunjDgiRrlq1"
Content-Disposition: inline


--W1bsJunjDgiRrlq1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2014 at 11:48:03AM +0530, Vinod Koul wrote:
> On Fri, Jul 18, 2014 at 07:56:23PM +0530, Vinod Koul wrote:

> Wanted to check if there is anything else required to be done for thsi
> series, if not can you pls merge the ones before this in series, if okay.

It's been less than a week...  I've not really looked at anything else
beyond the export (which I'm still not convinced about).  Patch 2 was
very surprising, it looked like it ought to have some dependency on the
rest of the series.

--W1bsJunjDgiRrlq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0PMNAAoJELSic+t+oim974QP/irM/WQBYON74aE3bP8Lzzbn
IrNVkisdNfboCT2sIY+TEk0V80UdjXVhwVnFKpXhH+X4pRLslsH0+QvLjlsL8NKt
yYasJ2JnpHXfGQZv7fAynirN6YQpTnDeZGxsFgZ9iEOmj8PjSQSY44jTY/X+7IIf
IOOh/dzHXZ0Uq9fOKgqUowDrwKthDbIPQg2tY5cxfxwcfF3KOgovgNO+JRR+rtus
KIICQzzk3TbtrleZP1c1SYFUxVQunnz+OO8a3649P+8wd0wy9X92bOCJVQn+Td4L
ka/NrXSsVsSvW1XmiOmW4nxElUpsjwKICk5gyjSwyjbSlgaTHJvsJa5aXGZsGfh9
o999DygfyBXN2SWAIySM6tbWIjLjaTQ4QCK0IZb46kq3umz72OA6AqOCQyom3P8+
3LZWqSv3oIPcKGc8dOQFnunI2Sh6+m0UGi071ro6bU2ptE0Bydz47HOhCA32ms1f
QXiV5fzBpkxj5aA14gDQ9LzFB4a8U5e344Ha2Hqa84Nx4SL8wmsckM9iLqOSz6LK
iXZWVt4Ma5ku0d1T69nsXn1pCN7ue7rJEHh5SHLqhDoYJxp42hire694eB+NGL1H
sfJ5wjmGM9hnyLLfIG8V3sbucleQq3K3ZIe+XhoOELFz7TGZu3b80RGnGhDA43QH
3IblP9QsHUheYpgTmfhy
=T1kw
-----END PGP SIGNATURE-----

--W1bsJunjDgiRrlq1--

--===============2344282692348114094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2344282692348114094==--
