From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5645: fix add missing widget
Date: Wed, 6 May 2015 18:48:38 +0100
Message-ID: <20150506174838.GD22845@sirena.org.uk>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4347794513752537467=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE9EE260631
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 19:48:47 +0200 (CEST)
In-Reply-To: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4347794513752537467==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h+fVSf+UNmt0b7TK"
Content-Disposition: inline


--h+fVSf+UNmt0b7TK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 09:42:00PM +0800, Bard Liao wrote:
> "IF1 DAC0" and "IF1 DAC3" are used in rt5645_dapm_routes but missing
> in rt5645_dapm_widgets.

Applied, thanks.

--h+fVSf+UNmt0b7TK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSlP1AAoJECTWi3JdVIfQlAcH/3f++ncNs0Dw13lgQTcXisxj
dalkGEdm3Obv7e/o09eI70FebfQ5TWEtc0ylM/KuLeAZiArPGeA+KKA20i9wncmc
idg64YplrLBkfhnw6Ex3SmWX82tcIR45Sfs3AlaXqSR9NmwbE/9lLdxX1Eyx3agI
dswPaem7c+fmVF2mwOuq1KMaspkRO0cjmyF1A222smWYzS/UBntISmMwAJXCfXkj
oUCXLETaSNGzlLPuZWR+hsSRGwFm3sf/tc6kdIqd/XFlf27VJAFYAl5uCHn20ywc
H8XK0B45hRbIe3Lb3shtkJfaXN5msCmH+Z5S38qbo4YqRNhVYcXheVZaBdpbiLU=
=ZJ+Z
-----END PGP SIGNATURE-----

--h+fVSf+UNmt0b7TK--

--===============4347794513752537467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4347794513752537467==--
