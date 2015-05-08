From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Fri, 8 May 2015 17:46:33 +0100
Message-ID: <20150508164633.GA2761@sirena.org.uk>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <20150507125142.GW15510@sirena.org.uk>
 <554BAED7.4080705@linux.intel.com>
 <20150507183629.GM22845@sirena.org.uk>
 <554CBA8C.4080909@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0208464330904657164=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D7B265DDA
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 18:46:47 +0200 (CEST)
In-Reply-To: <554CBA8C.4080909@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0208464330904657164==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 08:30:52AM -0500, Pierre-Louis Bossart wrote:

> Agree, but there wasn't a clear message provided to the readers of this
> mailing list. A 'should' is a recommendation that provides no real incentive
> to move to the new gpiod framework. The message would be clearer if
> maintainers stated that new contributions using of_get_named_gpio() will no
> longer be merged in the mainline (maybe after a specific milestone). That
> would set the direction for everyone.

That's what's been happening...

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTOhoAAoJECTWi3JdVIfQZ+4H/33ztvnKHL4UvxKDbo7pDTvX
NumHBZIKqkLjcvrat/uIdxaedD9/YpaRrG/P4Bh56viznfeLCbQMjVorWS73L934
zDNhsGFGxGJcDbDUVuVocT62sUueTU/Hsz75fTKroHJ470fyYcv0o5E3BJOoq6PC
iqONVYv1aPuMqXdGXxa64erytaqn+L8wpBrq4u74Y3Cm5FWB3YyzDLxixFnChvZy
uUnJtTKcwyWq86aajkd2xoRwT+0Lgo+hSJrL/jWjZQbFpZrioY5BkuYLx6zYh6Tr
LYJue5K8Nm8LNyBHUzdnESpqx35NLJWkbme20xwDX5qE7OZWto3zpd8GBhLCYI0=
=KqAK
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============0208464330904657164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0208464330904657164==--
