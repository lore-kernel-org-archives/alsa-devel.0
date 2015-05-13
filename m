From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFT] ASoC: wm8737: Fixup setting VMID
 Impedance control register
Date: Wed, 13 May 2015 12:49:19 +0100
Message-ID: <20150513114919.GO3066@sirena.org.uk>
References: <1431228906.9088.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2811786423049641349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EC72266162
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 14:17:55 +0200 (CEST)
In-Reply-To: <1431228906.9088.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2811786423049641349==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6aLNMpa4RfPduGT7"
Content-Disposition: inline


--6aLNMpa4RfPduGT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2015 at 11:35:06AM +0800, Axel Lin wrote:
> According to the datasheet:
> R10 (0Ah) VMID Impedance Control

Applied, thanks.

--6aLNMpa4RfPduGT7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzo+AAoJECTWi3JdVIfQ22wH/2YPY/aUJlRhTLmzrUbUyYZg
O/qCgLW8ximQ36BRg8XM2CEShGMYAEM2cHYw5ZoZVDNYQuHLq5zs5IJYrnuGQxp7
FCvqqIYqX2HPNNwnSt6CZwrsMfdNX2FjHOr29wgZKZ7bVzkiBIjZdIiCFejeae78
nK9L/72MIbm/6Xx3wJCax7TCMeiwqDUDxR0Q9N6v/xcvR51a9JMdEC9n87H/I3JL
hI/ffHygbF++GvCIjsEuApCt7ZvdEyEhbg88LfT2CS/xLsBbV2BtokQaaBOa4p7Z
fDr6yf7b1Ak/wRmUma8kzeMKH5axupZu0fUFQGKw4cdW4es7IWKH1QFLI0KxAI8=
=hQZA
-----END PGP SIGNATURE-----

--6aLNMpa4RfPduGT7--

--===============2811786423049641349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2811786423049641349==--
