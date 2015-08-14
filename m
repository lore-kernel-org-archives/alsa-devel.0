From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] ASoC: Intel: Skylake: Add pipe and
	modules handlers
Date: Fri, 14 Aug 2015 22:30:31 +0100
Message-ID: <20150814213031.GT10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2238076026144373604=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60260266596
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:12:43 +0200 (CEST)
In-Reply-To: <1438976184-6160-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2238076026144373604==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRAzd1zqvkbVQS90"
Content-Disposition: inline


--TRAzd1zqvkbVQS90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 08, 2015 at 01:06:16AM +0530, Subhransu S. Prusty wrote:

> start adding building block for handling these. We add resource checks
> (memory/mcps) for pipelines, find the modules in a pipeline, init modules

What are "mcps"?

--TRAzd1zqvkbVQS90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzl32AAoJECTWi3JdVIfQTG4H/34vA8dHC/IZUROWqGHrxsFd
ZXmFgPwdaTU01ujYWArlswZL8rLwpalFmEBJzZQnPIu8zeG5NPJdNHnKeQGeHbpv
i0XBAlWs/Z70I8KxIQUza+o2BbGkFRKJw9svapBgfPBLpDuVxN4Y9buPLEVWFMfG
SNSiKD4b56cm+9iT33BE9n+M/RfpUoEZikV89gIc22yMs/P04ERK7nTtcm4G8g7+
fAS2BRMKL96wY0u9pJ9NEb+8fdy/vrmKX4FDFzAFe32K0ehA1Oz7RvBDtWGA14WT
u8MDLDuQgzwu1K17yALr7Ei4vfF7UsME6qaGNFKdJRUo+65Z5OO5c9T0DkM82fE=
=thoA
-----END PGP SIGNATURE-----

--TRAzd1zqvkbVQS90--

--===============2238076026144373604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2238076026144373604==--
