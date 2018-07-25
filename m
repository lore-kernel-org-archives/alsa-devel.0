From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5651: add Volume to the name
 of volume control
Date: Wed, 25 Jul 2018 17:13:23 +0100
Message-ID: <20180725161323.GB6315@sirena.org.uk>
References: <1532051300-11884-1-git-send-email-bardliao@realtek.com>
 <ABFD875FF5FB574BA706497D987D48D702846306@RTITMBSV02.realtek.com.tw>
 <20180724144047.GE13268@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702846FDA@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3671844928700622742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EB1532675D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:13:26 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D702846FDA@RTITMBSV02.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3671844928700622742==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 25, 2018 at 02:01:21AM +0000, Bard Liao wrote:

> > The RT5631 doesn't appear to have any users except Arndale, certainly no
> > x86 users?

> As far as I know, there is no x86 users using RT5631.

OK, I think it's probably safe to apply that one then as I'm not seeing
any in tree users except that Arndale expansion.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltYoaMACgkQJNaLcl1U
h9CWrwf9G+QW2BAfzKuqFX0/DUWDaSPxlAqgZzBfBui3iI9AKsaGW0o8NeYHEyCG
mtE5BSiJSQbTvxdDpVahoUWtC1ybsClKefEGhMwc08T4WdHodlaIThzA4Is4v7DL
Kk/SQprokDoPvBPO0q5migzK+dEZaeycqh3CILXffG2qKleQl8ScN8jabEStA8T9
28xTjYPVigijRbqgc/TLvY78pKQ7ppwJgIK++whndsnXUd3Szx1x3AFajC7gbA93
15SDMMLb2++44IVnJfla+fIC4Ko0DhfrceEMcgPm9wNt7Zgsa2Stnv1qLCNRZ3lh
49mEkjEuvQ4AZN19XOqBBCT3/Debbg==
=462E
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--

--===============3671844928700622742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3671844928700622742==--
