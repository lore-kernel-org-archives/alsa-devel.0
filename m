From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/6] ALSA: hdac: structure definition
 for ext_dma_params
Date: Sun, 1 Nov 2015 11:56:52 +0900
Message-ID: <20151101025652.GA17819@sirena.org.uk>
References: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
 <1445931737-30393-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4412343695801759593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62FE526061B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 09:54:02 +0100 (CET)
In-Reply-To: <1445931737-30393-2-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Yakir Yang <ykk@rock-chips.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4412343695801759593==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2015 at 04:42:12PM +0900, Vinod Koul wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
>=20
> This extends the structure definition of ext_device and adds
> definition for dma_params which will be used when hdmi codec.
>=20
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  include/sound/hdaudio_ext.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Takashi?

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWNX9zAAoJECTWi3JdVIfQsH0H/RcD3J/xUv5ueY03GUqyQ49M
S3M1Gh3B7W4a0DvPK2nQIXuS9g2pMvLEMYpfjS3196NeEuacv6bEGhjo8lUsIHdp
7lwnIvE6oKtGdEedgUz7pnS/UBsDsWiLQzybXEC5sfjWSmxnYJYtR+QnHdApO0Zv
Qkckxh6fSajtUkq94DpzERPt2pHvjW1QfmLg8/1NHLIoqzoOKZYb5L/PkjPNSFRi
9FqavdwsyLv2UDXSrI3kHIbt7vOXUnud1BCebsbX/cLVzfM+HrnDkW3SPtX3K/qJ
m/vi5Y/kbtXzIrB45JXJ3ylMQp9UMo4/hfxYkWImQ1VHUqWYT0TR+m8XyDhhBaM=
=aJj4
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============4412343695801759593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4412343695801759593==--
