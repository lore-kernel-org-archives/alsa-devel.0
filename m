From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix a buffer overflow issue
Date: Wed, 8 Apr 2015 11:17:59 +0100
Message-ID: <20150408101759.GT6023@sirena.org.uk>
References: <1428408899-28677-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3600553373103972248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C51F5265211
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 12:18:06 +0200 (CEST)
In-Reply-To: <1428408899-28677-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3600553373103972248==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kyiIRZ01VUpA+bwC"
Content-Disposition: inline


--kyiIRZ01VUpA+bwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 08:14:59PM +0800, Jie Yang wrote:
> 0day robot reported a buffer overflow issue:

Applied, thanks.

--kyiIRZ01VUpA+bwC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJQBWAAoJECTWi3JdVIfQx6MH/3QZM8mI3c7GLocA0zJmsdAu
h0qIzaUNmVLhgPYKZm9V9iMTcDUsf7Fs/35XjarJmN0npYpTGtYBuNOSPUZ9YTcj
enXW3xzDrQjTz5HjQN9Y2My7c8f0L2LD1Re2MVXkOmgD9WP8/RJfL898yKjl3z+t
PanIMc1dYh6s3TzT+LxrUeMFt2P02ivdnAe+iBNCMUvzGuHoFI3HVDqsfGiSy0te
sj6NewnkF8BlmzQBYghCtILDBH6+tiV0AeaN79/f81mMD2svrG7fxFIhXk3VkpTV
RxLtN/Jalc37LFh0sH/iJgYcEFg91kh1JyhFIj2G+7UaV5hGUprkaiufgzzoz6o=
=YfM1
-----END PGP SIGNATURE-----

--kyiIRZ01VUpA+bwC--

--===============3600553373103972248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3600553373103972248==--
