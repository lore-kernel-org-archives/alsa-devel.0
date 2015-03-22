From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7 linux-next] ASoC: fsl: constify of_device_id array
Date: Sun, 22 Mar 2015 18:03:05 +0000
Message-ID: <20150322180305.GO6643@sirena.org.uk>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
 <1426697344-4884-3-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426697344-4884-3-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 05:48:57PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwPZAAoJECTWi3JdVIfQxoMH/ipuHsWLOP3xp7Rbs01AdHRQ
jpFX9rFdX5qqrQ+gpBQOSbgdmq+BNmrL5xrE6Ocp12kw1dobinPwGz76clWlhGDb
cPtW1qZX7O1DZlw2baFv6R5c4aFw37I1JClshQEfnLTzO6RxfFi7Oiq7qfUxF30p
ukW+FSLBPPCim9XJP1nmlxPLZ3C11mMg9CAb9GGiDgJbmbimfESW0+fGmSfijZsX
nATVgcaLdcTctVLC0C+NDT8H33naRszsgkgpeQbvqZ36tjfJSKhW6vg80xbuV2bj
p/2PFc0lnNvDTUUOxUgfO+gNrkc2YI0ItVCk2WQVJue6aTbEbNrlcJBQibCnbdc=
=A+y2
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
