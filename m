From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: fix sst firmware path for cht-bsw-rt5672
Date: Thu, 5 Feb 2015 20:16:44 +0000
Message-ID: <20150205201644.GP21293@sirena.org.uk>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
 <1423167127-16029-1-git-send-email-kevin.strasser@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qr8RA0kK71CmPmG8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423167127-16029-1-git-send-email-kevin.strasser@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org


--Qr8RA0kK71CmPmG8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:12:07PM -0800, Kevin Strasser wrote:
> All sst firmware is provided under the intel directory of the linux-firmware
> tree. By default this directory structure is kept when installing on a target
> system. Change the path to expect a default linux-firmware installation.

Applied, thanks.

--Qr8RA0kK71CmPmG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU08+rAAoJECTWi3JdVIfQ5FYH/3Cbc21BCb7Dw4bGN3EZN0wM
ikFt+NozcKVJr1awKWqjzdfuag9ANJZYjH1c8DgHbRjg3BpBWJrMbEp6pPZ+QvBz
FAC6n/1b2S2ue6W9Fs64qfgMxVdPqlMtYC2ZEYiW2+gQtK6EwfmH3MX2OzqRu4eX
8mGroDVvEGacc3M+mgekrS6zuDP8Xu/1OzOyxvyp4VPCYufq+ys+Iwo9WCvcl8Of
6v7DUilLUhOExyIuV+hUeqBOV6cCEUPV8Px8ePMZXk6ewYP1ug1ypw48PBWSe/uW
YQTALMVke9Eon1ESt6V2+De+4f2Z5XGr0RUAc3JigM3omNAHXG9fFjk/+u7Xl6E=
=D8Fs
-----END PGP SIGNATURE-----

--Qr8RA0kK71CmPmG8--
