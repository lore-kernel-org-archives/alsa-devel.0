From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal
 supportforRT5642
Date: Mon, 28 Apr 2014 09:52:45 +0100
Message-ID: <20140428085245.GC15125@sirena.org.uk>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
 <535ADCD2.8050804@wwwdotorg.org>
 <ABFD875FF5FB574BA706497D987D48D73CE0EE@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4430207683546134436=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49DBB260816
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:53:14 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73CE0EE@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4430207683546134436==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 27, 2014 at 02:57:24PM +0000, Bard Liao wrote:
> > On 04/16/2014 08:24 PM, bardliao@realtek.com wrote:

> > Is this derived from Jarkko's patch? If so, shouldn't he be listed as
> > the author, not you? If it wasn't, then presumably his S-o-b line
> > shouldn't be in the patch description.

> I am sorry. I don't know the meaning of S-o-b's order.

It's not just the ordering, it's also the authorship information -
signed off by has a specific meaning about who wrote the code and
handing off responsibility for it which is important to licensing.
Adding a signoff for someone who didn't write the code is therefore
particularly problematic.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTXhbZAAoJELSic+t+oim90yEP/ja+NaqvF5qzzbPlHBOH8UBH
XlfUwKX9zxxPZYTXedoifuEursZwJtTCPWnNIDWKoW8JVBWzrFMl/dxc7AmvBoxY
cy1F9TFLZNsWNpiu5acIfTHwVAXv+4vbBerqkft4AjRqxFPk68HU1ru3yIe7uU7Q
6zws7Btg7k5xo8138Q6ALsWN9A4Xap7fsrMsJV7NFMlDV6WUR0E3TjoUFUpbz9Gp
LLQxOIZBUufbKwavyY3bC/U9zgggJwGHiCPz6VPLc7HDSONXXC+kpUI1/bz/YJwB
J+qbqTOBWy5xDv6qCfLLyv/bQESeckBqGXzcvO8wFrnrvdQl18/GYAnrMdYqiNgd
2e1fhVV4P551jvmWmHkoDiLGYXEyqa6np7qn4HRT9GlRKCGnshFVJSrVRh0b4MY6
e2scWNmeAoYK492pcj4fMSYHi973nIllwvn6Z4uNbbzRIJ+RKGdzoavcI1HJUSml
q/lHPGeLK8lG6w9bt2+7AzPuUwhQysj8LzmkVlfuKFadIgzDcDSVWTkIJg4spXc0
Wf8+xbEhgsmdSd0TOOtZ4P8LK5mUPSSsxbiey0/LAi50xcMxnXaxArBBL2/CoDOV
Sve3b3O3946QP2LkqU6QGAmFM7BctgrjbDJIivQbEVXZ7HPUxGcNPCERoJ2DcV5q
n/XFMT6BlIRwS9lNEjol
=nlAc
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

--===============4430207683546134436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4430207683546134436==--
