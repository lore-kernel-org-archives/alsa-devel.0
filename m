From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix sst firmware path
Date: Thu, 5 Feb 2015 14:37:43 +0000
Message-ID: <20150205143743.GW21293@sirena.org.uk>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
 <20150205115606.7ad3336f@lxorguk.ukuu.org.uk>
 <s5h386kr0az.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IYp4hyeyZ0O2hggr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h386kr0az.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Kevin Strasser <kevin.strasser@linux.intel.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org


--IYp4hyeyZ0O2hggr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 01:48:52PM +0100, Takashi Iwai wrote:
> At Thu, 5 Feb 2015 11:56:06 +0000,

> > You just broken existing systems. I agree entirely with your change - but
> > you need to search both paths for now and maybe in a few years time remove
> > the old path.

> IMO, it's fine in this case, as this stuff is new, merged first in
> 3.19.

Yup, so long as we get this into v3.19.

--IYp4hyeyZ0O2hggr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU04A2AAoJECTWi3JdVIfQ0E4H/AjMEyIdRSMzi76O0Ze6umPa
hTeP9VJvnrw26RI6BnZhCIBN7JJfekrJqoC6ZlI2Dt1g3lQY2TR7DMng4y+nP/Y4
zcQWSey9y5umqgV/P+iwpU0ZdDruY6Ri4W1UKNTN4fwW8BFGsuBZ1wg2CpSInd75
RHe2tulS4yrJIZEKZSEy9N8xZdnjg21vehH0QCkxBvId4uIphaqMKc/TtAZJ2AWi
b4XQgVHpIJ7Waa/frIgY++ddEvozYNQqHM0yk/fzNZQl37Hqv27KPlvCiCHcLEjk
Z1LuZZ9BgWAPqO2XSSjsujoD8aAogq8YgFOfHuvbL/YQzJytj0h+1iUvvdyWR5U=
=4R9W
-----END PGP SIGNATURE-----

--IYp4hyeyZ0O2hggr--
