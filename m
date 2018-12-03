From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: common: add ACPI matching
	tables for ICL
Date: Mon, 3 Dec 2018 12:01:27 +0000
Message-ID: <20181203120127.GO2089@sirena.org.uk>
References: <20181201005437.5198-1-pierre-louis.bossart@linux.intel.com>
 <20181201005437.5198-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0717462901865490066=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 92A492678E4
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 13:01:30 +0100 (CET)
In-Reply-To: <20181201005437.5198-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0717462901865490066==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zl7RHiM2mcjcj0Yf"
Content-Disposition: inline


--Zl7RHiM2mcjcj0Yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 30, 2018 at 06:54:37PM -0600, Pierre-Louis Bossart wrote:

> +++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * soc-apci-intel-icl-match.c - tables and support for ICL ACPI enumeration.

Please make the entire block a C++ comment so it looks more intentional.

--Zl7RHiM2mcjcj0Yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwFGxYACgkQJNaLcl1U
h9APCAf+N2xuiDC5tw0IflcpwapjRY84mck8WhMpUFKEQ9sgz3/m/Yx7+MH8NMrp
lNhjcMiSJCcywmBIbHel1nxlPdRB2oqHmaF9R2+ta6I5tDn6sLuDTCwC4r/8aj1E
L0pnSFJJTA624fsi4tlg74JjncsVjLHfSPXG4u36yfE/CPfwn9RbTUcem9FfBwLf
FZnKZ4vFb++HCfRERi4zBZxM1RxAXagf17dK+Sav4lRf1GbYVh7W/iLt6Sk1ykbt
/59cxeM1EdS3P91tFPogSnaRWlwUPTUPfdAIOgr1BJArG23k+X74JJOq7LGk/JdY
/Xbc9qI3kSvLuCgcNHL3G01RjylA+Q==
=p6yV
-----END PGP SIGNATURE-----

--Zl7RHiM2mcjcj0Yf--

--===============0717462901865490066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0717462901865490066==--
