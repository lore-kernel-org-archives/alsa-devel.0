From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7 linux-next] ASoC: kirkwood: constify of_device_id
 array
Date: Sun, 22 Mar 2015 18:03:42 +0000
Message-ID: <20150322180342.GP6643@sirena.org.uk>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
 <1426697344-4884-4-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i0LFOk513GRb+T2w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426697344-4884-4-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--i0LFOk513GRb+T2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 05:48:58PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--i0LFOk513GRb+T2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwP9AAoJECTWi3JdVIfQQAYH/jVPtlVJKdFPc4hFW7JIBpz1
/1bL0dH2ssQJyuemXJ1e42ETl5Bwp4ERKmmsqovPaaLuF/RrYFPbiTijpcnMRBd2
W3kZ/NVlg6Jn+gogg1/aqqAV0KmIcBZxxMNz+ZtzbltfSS7fsE/VSrC/D2kdEDNK
TZZkVIRLSMGIOqBo75nNJjlJUBzYAxV9tPVa3jUxH/oRRZo8TTzwTrL2iNCes4xG
SGHcOo3tzKf0fZeVvYvJf585XyeP8Bh7uZC4xQJSm+pGb9L3ukUSlDhgzMTGiBkc
MG/CROCtTipRZrWfvVkLng/+XiDz/xE6TfqGsb4UyAFCEsDAd4RlQkzQ7HnSj9o=
=vRqq
-----END PGP SIGNATURE-----

--i0LFOk513GRb+T2w--
