From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs: Remove
	SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Tue, 7 Jan 2014 11:41:53 +0000
Message-ID: <20140107114153.GC31886@sirena.org.uk>
References: <1389025162-5601-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2836588757394518307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A452A2616CB
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 12:42:02 +0100 (CET)
In-Reply-To: <1389025162-5601-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2836588757394518307==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RDlw+i4ZlNgx9Lt4"
Content-Disposition: inline


--RDlw+i4ZlNgx9Lt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 05:19:22PM +0100, Lars-Peter Clausen wrote:
> Since commit 7b11304 ("dma: mxs-dma: Report correct residue for cyclic DMA")
> the mxs dmaengine driver has support for residue reporting. So there is no need

Applied, thanks.

--RDlw+i4ZlNgx9Lt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+f+AAoJELSic+t+oim9lVcP/30KrSD5jJejIQzKX+qvCzyd
3GspST4pNv/6fPP/HCJD9b2pqwuSzmEBZAgjEBQoW8M3uwuumLhhq2OCql7Fo64w
fuM4EYA7v/adEVsvboAAQB7dnVPgQQxnj908iVC5LsVAgcFaodE/ikgWK0QxC0o8
FF63192N1sLpDpzJwcOtVoPm7pP+/FWCQoKc8YN9QNKoQR5p1jRo+BhT1ho3RqN1
zrAUGWSYAEIUEd97xaIA2Wlw7Ymo9Zun0OC5HNjkywwdE6W9EtX54ByQhZrChA4Q
pGDp41dEgPTjC2o+DvtejU8NV0W4FbVE2vGLtyebJPK0N//pBVpTDI1ZXIrSpV2x
ODNwAiLN7DcCv6vRzgwUywDOD5kcb2dQ1m+msxo5xVD9ry6m0FA5VIYSyVjBT1xH
lZZttjxyw+x3K3kLUTN56ACb1DsULoaJun0Wb+tiUirhZsf/gMbPMiB2II3p40CZ
BF8+hjV1CpqwQWaibpDvhQ7x2C9vcW6Y9nVhPtykyZ1RL71FlZFa4H1mBsq5WVHg
rOK8a1Kv39uAHfDfdNqb5Hw/dXj6W8De6UUJndgwkpWH4MKRUGzTFziPLA2B+zzH
tAcQgu93WWmHsdV2v3cRSlQqqLmjuQhice9WU79xeh6SgHYtlNiqIap7r7BKkTsE
IITUveHOn/3zQgM35Z2T
=53v2
-----END PGP SIGNATURE-----

--RDlw+i4ZlNgx9Lt4--

--===============2836588757394518307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2836588757394518307==--
