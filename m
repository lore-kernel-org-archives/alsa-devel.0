From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] MFD: twl6040: reg_defaults support for
	regmap
Date: Fri, 29 Nov 2013 16:04:31 +0000
Message-ID: <20131129160431.GE27568@sirena.org.uk>
References: <1385733827-19831-1-git-send-email-peter.ujfalusi@ti.com>
 <1385733827-19831-4-git-send-email-peter.ujfalusi@ti.com>
 <20131129160032.GC26982@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4712408112161781952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 65C9D261676
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 17:04:40 +0100 (CET)
In-Reply-To: <20131129160032.GC26982@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4712408112161781952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jxJZfy9MYHgKPwT/"
Content-Disposition: inline


--jxJZfy9MYHgKPwT/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 04:00:32PM +0000, Lee Jones wrote:

> The code looks fine to me (me = !regmap expert), so with Mark's Ack I
> will apply.

> Mark, is an immutable branch required for this patch?

Yes, please.

--jxJZfy9MYHgKPwT/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmLsMAAoJELSic+t+oim9WygQAId6aXD6wTYsgpIrqZkiIJV/
Idi/Ddg247MLIu+yYZioKgRhSg+u5b9hzQg+XpPp0Dhr9a75rnwReB/aCExQwRmU
TdHhdpv0TiLACXxLioSN9PrsyFrbzjiPI3xr0NJqIQ4xp9dKDOLquAvSdGk3p/7B
I8i4NMMnyWu0856sa3OhHPNEiwgDtj4d+3Q+gihT/8JelDyHdLHj+POdIN/ICuxh
6r4y21AcZFEoJUnD6hrF5TqH2cAoCXRG3m3LbJCP4a9PKEkyBk4V6LMsmmKm4YJj
sSdjIQt2reMcLn8EZoBF1AHAe09jfPz4kecn2PNq911CbJYmeAPMWlgXcoqgPLjm
HiVJOJOMuHI0lq/gr993fOUvLZ30gFwmnMLNQY1J2S7BcEgRbocD7oCDoCZG0hwF
GKJv3kB8EMwVq8wPZL3v6nrVl0+ZbBZViGvEDeLEwbZ+sSBsh/tjhs49o5Zfr21c
T0jkdycTLFiM6hVdglcmbygiajInZh8KH/kJYsV5Bzn8dMlDrhlhbGNVjtsMugVA
jruMxPuJSqIzaBu/4YPD2/EWscix2DtfQGLNXd36kKDb3CnSIDDZtmxYRMIdmKqE
IP2LCPEJ2cCRo1ujKzniTTuKBus1gbR40G5vE5+gsFifflr4q9oepAuLwQjJ0flZ
CHfpy3ClLxnNeS5mpOBe
=JlEr
-----END PGP SIGNATURE-----

--jxJZfy9MYHgKPwT/--

--===============4712408112161781952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4712408112161781952==--
