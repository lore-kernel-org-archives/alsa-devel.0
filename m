From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/19] ASoC: Intel: mfld-pcm: modularize
 stream allocation code
Date: Sun, 22 Jun 2014 12:02:12 +0100
Message-ID: <20140622110212.GR24291@sirena.org.uk>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8975194542316030760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A04FC265311
 for <alsa-devel@alsa-project.org>; Sun, 22 Jun 2014 13:02:26 +0200 (CEST)
In-Reply-To: <1402662848-24534-7-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8975194542316030760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9lPOKfY2vCV97ybw"
Content-Disposition: inline


--9lPOKfY2vCV97ybw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 06:03:55PM +0530, Vinod Koul wrote:
> Tis will be used to add table based support for pcm front ends in subsequent
> patches

Applied, thanks.

--9lPOKfY2vCV97ybw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTprexAAoJELSic+t+oim99+YP/2ES7GidxX5s+8QsN9LFh2RC
kEx87pROXUz2jrcK+O/hWVTPwZK4oXpEWxMgDT6I27s9NrdpCQC3M+GsQntjMt64
9ZZwwVYW9j1jJcG7rTM6oCOC1ueDlXB5gZ/a/nBl/JlQaN/jWgH4TrketXKmkWa5
mpmPXupyRjVDwqRfrL3anU/nxqPqa6EKs4/sU0Qu06gW3Hi/fJ6g3ZzsPvxkp8XX
6jIMyLTxXr5KRRDzWt/SH5bCY7p1ELDQQdbI77joOKjcqdeLt5Ley2Dtu1qJr1ne
1hAJwOooPKISnr2CCevaTdp93v7f7xvjODVOnmVuStltpBUMPfSC48Ci4gwN/8Si
fb/kkwCfl9I1vCoKvN60HRC6TiDRr8nttNnQ3Gv6+4HnesxzlGOpsTjD6mqcftab
USIwwkRhWagDmDeUctjW//VnEADKSvLrTeT1mxthphoGkpryaGVlwbzsf2tGgo8J
M3sX7f5G+lfZ6vZGX2UBFHZsb+yNwBH4i4Huh+t4QwL61Mul2SbuvWATPEU4v1Zq
0mX87YWvAYe3OQ+iMD6aINoR+hEAtLhxSBHTNxqiAAi++IARZUxiHhseHKii9pUR
oXWFyrLcksvoGQku0K19s/G/JuEB9ApjhEhR9ToQZFmDz8o96Ajn4EZNZAvQnVrG
cTLUBSlD0IUp7rboDHGZ
=4oCV
-----END PGP SIGNATURE-----

--9lPOKfY2vCV97ybw--

--===============8975194542316030760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8975194542316030760==--
