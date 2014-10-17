From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add jack detection for
	Broadwell
Date: Fri, 17 Oct 2014 16:07:42 +0200
Message-ID: <20141017140742.GT1820@sirena.org.uk>
References: <1413536270-16285-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2389472401269219406=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F282F26063B
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 16:07:55 +0200 (CEST)
In-Reply-To: <1413536270-16285-1-git-send-email-yang.jie@intel.com>
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


--===============2389472401269219406==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tbn31orTZdSAVHoc"
Content-Disposition: inline


--tbn31orTZdSAVHoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 04:57:50PM +0800, Jie Yang wrote:
> Add jack dectection and event reporting for Broadwell. It use combo
> jack on BDW platform, which including Mic Jack pin and Headphone
> jack pin.

Applied, thanks.

--tbn31orTZdSAVHoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQSKtAAoJECTWi3JdVIfQp6UH/A6Q/wMpr78fplz7suALz60G
DLN1+tDkwXLSyNAsFgWJxmrO4/ucna1CinH3VR/r+0hOHdqHT7YJROzwp4wjMFlb
vbQfP1fhWG3ZbbN2ckDfhlkGLUwxIZM+TBU7/xdwtT903ntWgiOn9uBqOONok5uf
RZresxldJA4nVZ/R28h3HiHJtgjxAs+lCh2E1EpYmo9qv2nGY9IDiSmR0yQiNZ2p
Vy6+cRE5YxPE9wtehpRPogB/pTPbX1uHxbM4b5qJPEcumkfnTUNcISn07T/GCc2C
6mLFER5yaxjkgz28W202yi4pljgClUb/kCNIvBZRDnKV+I5VdiDiE10ARrPZwF0=
=CrWL
-----END PGP SIGNATURE-----

--tbn31orTZdSAVHoc--

--===============2389472401269219406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2389472401269219406==--
