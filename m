From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix broadwell module removing
	failed issue
Date: Fri, 29 May 2015 16:18:38 +0100
Message-ID: <20150529151838.GP21577@sirena.org.uk>
References: <1432793658-9463-1-git-send-email-yang.jie@intel.com>
 <s5hegm07n7v.wl-tiwai@suse.de> <1432827874.2726.57.camel@loki>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553BB6C@SHSMSX101.ccr.corp.intel.com>
 <s5htwuv64i3.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90553BDA1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5057418085621425819=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCB702668C7
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 17:18:46 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90553BDA1@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5057418085621425819==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cE0gyyZqYhyt+KZr"
Content-Disposition: inline


--cE0gyyZqYhyt+KZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 03:06:09PM +0000, Jie, Yang wrote:

> OK, then I will follow this.

> Hi Mark, can you help revert these 2 commits? Sorry for the inconvenience
> caused.

> ASoC: Intel: fix broadwell module removing failed issue
> ASoC: Intel: remove unused function hsw_pcm_free_modules()

No, please send patches for any changes you want to integrate into the
kernel.

--cE0gyyZqYhyt+KZr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaINNAAoJECTWi3JdVIfQrLkH/158AOZzdM/3gc95KUHkyK6E
5FK1HNmAIMIdWAQreVzvKnThEOQilqXzRGaXzECRmm+bhQD2Atksd8HZm0FdzS4L
O6nLyRrx0gqQWt90exIyBso+c1CCzJdhw67WSk2w138tVSUJqEjuSKb4jui1NBh9
PG+/ahxqamb69sznLM+SswFN7JbleJkGChr6TDKNIjn6hdWkFaiCFLCef75d+o0Z
IDGr6uRCMODjw0PQ3bQskdbDVbyF1Czj5pn145MwNg46jaDe/q99eMURxW0SH/xS
zvLTN9gb7jfjNzzl44dePPfVSL4V1ZG3gglLMv3PXcRWzTw7QJq46ymGvJ8qIwE=
=PWGj
-----END PGP SIGNATURE-----

--cE0gyyZqYhyt+KZr--

--===============5057418085621425819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5057418085621425819==--
