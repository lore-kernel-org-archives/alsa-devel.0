From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic23: depends on SPI
Date: Tue, 4 Nov 2014 00:56:05 +0000
Message-ID: <20141104005605.GC3815@sirena.org.uk>
References: <1415038079-6490-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TMTfqzsZeEKgETVO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415038079-6490-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jim Davis <jim.epost@gmail.com>
List-Id: alsa-devel@alsa-project.org


--TMTfqzsZeEKgETVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 11:37:59PM +0530, Sudip Mukherjee wrote:
> Fix build errors when CONFIG_SPI is not enabled by making the
> driver depend on SPI.

A version of this patch has already been applied.

--TMTfqzsZeEKgETVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWCQkAAoJECTWi3JdVIfQXC8H/1e4acrJt2++wC/IS6f6xxAb
rBGW4KEou5YZOT6kkMeJE9WO/WkiaL/QTdwPELveqSQEWqR7cku6myooXqlaCaU1
GoQCCjHrPjttLZ0Hkfj6Gutu8pTBbF2/EB1KnyDWnuf3hdzgj03IsG1QcxEOS7qU
NnJ+jquAXcMUc/rt/d0u2Zxc8L4Mcirhvxjsu5B88BUEZtr3T9sUGmGfx0sIWwdk
L3VIfAYLOsRsgErDWq03fxwBeZBNjudQ/UODfVH+XKGudRKvQL194xoiiwOQlZzb
IL0uTf93r36ISBjvk+Yl64VvTrEkud6XRberayiDU5pA13vlcSCOTjDHtUu/ujg=
=iV62
-----END PGP SIGNATURE-----

--TMTfqzsZeEKgETVO--
