From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: Intel: sst: add runtime power
 management handling
Date: Fri, 31 Oct 2014 12:47:24 +0000
Message-ID: <20141031124724.GU18557@sirena.org.uk>
References: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
 <1414739301-12659-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3736941460747818535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 08112260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:47:46 +0100 (CET)
In-Reply-To: <1414739301-12659-3-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3736941460747818535==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vr+XRlAyGyU9VZVD"
Content-Disposition: inline


--vr+XRlAyGyU9VZVD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 31, 2014 at 12:38:20PM +0530, Vinod Koul wrote:
> This patch adds the runtime pm handlers, the driver already has code for
> get/put for runtime pm and only these handlers being missing.

Applied, thanks.

--vr+XRlAyGyU9VZVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU4TbAAoJECTWi3JdVIfQm2wH/2PeL4AknqmyK1pBbFgxAe+/
Y+Hr9/LgBdXPTEmd1l62TX0haJ43h8kV6BawMamwNXidaWTK8LwUcO+Mx2bTaZKL
TYpgxHQC1ZhBZTMg43oinYeyw8NEgs0fNV159TpWStboCO08CHTZhO7EkRrAOP1d
cMT1NxzY9sBU7NufpljHOOxT/dBfHDRanS1JPnvzV5TO9FnB6NWdl24DAvxBOlVJ
Ir+0hkZPinUBWqUbx4eFeADpkrfyJRn8KD7UF/QLWILTmsrpr2HHNIzM2yo+MPmI
mMJ9OpmvivASVCGpGOrvdQw29zQ5kN9xZo0zQ2irH+BF7GutFnAWvwsRbMC0nLM=
=pkRj
-----END PGP SIGNATURE-----

--vr+XRlAyGyU9VZVD--

--===============3736941460747818535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3736941460747818535==--
