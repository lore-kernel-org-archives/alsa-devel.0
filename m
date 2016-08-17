From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: Intel: Skylake: Add token
 support for topology data
Date: Wed, 17 Aug 2016 11:01:54 +0100
Message-ID: <20160817100154.GH9347@sirena.org.uk>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
 <20160812104107.GB9347@sirena.org.uk>
 <20160812105531.GL9681@localhost>
 <57B40B50.8000105@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1946276405001295666=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3957266BAD
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 12:02:14 +0200 (CEST)
In-Reply-To: <57B40B50.8000105@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com, Mengdong <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1946276405001295666==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7/IUJOcl5c0tDlVH"
Content-Disposition: inline


--7/IUJOcl5c0tDlVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2016 at 02:59:28PM +0800, Mengdong Lin wrote:

> There will be 2 more series to bring some topology ABI update. The code is
> ready and verified. And we will not modify ABI to break backward
> compatibility after this.

It's been over a year since this code was submitted as an ABI.  What are
these additional changes?  From where I'm sitting it is really difficult
to see that there's an end in sight here and we've had systems out that
need this for quite some time now.

--7/IUJOcl5c0tDlVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtDYRAAoJECTWi3JdVIfQQOgH/1L2F0NAyy2zhfrTVHaSkwm4
DDCozhMpsdRnYlsMMFa01w8hDx+gyyqQ9uWBD43uPQXQ1rCEd6NReSFRkASfui6p
fT4XMVWYO761dP9pzB3wnwcBICWfQohkD9kIUnUESax5zZ+7UiF0zt47cE9U+WDf
z7MqnLxiArT3jnmjUufdn6Jw/rrbM8+l00G/6c5K/26aGvqmoUbsGl924WQ8EmI8
qKkeQl29zUxNXdGDrfGNTXyfW1mTnbXRbpvlUwM+YQMgrXGbC253djFHF7WQs+05
Jb7bpiA+9czn6qzyxRbfdyq90oxoxn7W5Dj5N+g6yjYD4sOL871LS6QV/yx6unU=
=3PyM
-----END PGP SIGNATURE-----

--7/IUJOcl5c0tDlVH--

--===============1946276405001295666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1946276405001295666==--
