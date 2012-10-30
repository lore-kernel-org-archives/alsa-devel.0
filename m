From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ARM: at91: atmel-ssc: add platform device id table
Date: Tue, 30 Oct 2012 16:07:22 +0000
Message-ID: <20121030160722.GW4511@opensource.wolfsonmicro.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TPGKQYD3WP7vMswh"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--TPGKQYD3WP7vMswh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 06:17:55PM +0800, Bo Shen wrote:
> Using platform device id to check whether the Atmel SOC support dma for
> data transfer
>=20
> If match "at91rm9200_ssc" which does not support DMA transfer
> If match "at91sam9g45_ssc" which support DMA transfer

Any comments on this from that Atmel folks?  If I don't see something
I'll probably just apply.

--TPGKQYD3WP7vMswh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQj/skAAoJELSic+t+oim9ckwQAIkmYadW1rMowFh2dS/3SgGN
FRn7B4RxKvUpiJ6fsHK1UBwvqnB/pAS1Ry22lm63qJlU+o0hh3A14zSZzUsr1zl6
naIQAKdYCzLe3QsaBqIkYKfjAuO2EbkeCJIyqoTizrELWg23dTfZFwErTDtvgJKm
Yh03yoelcfoC+z34PTdlgPsUcbsIo0xbWxHyjcZm75awjNFK3RS5nj6mv/gh8Ppe
AEu/eBy4n7cTpqPQseFizusbZFVpmCGlmXMJ89Tj4VrUqPJikIfOAtkVEJT5GCo2
rfYorM5acKW+LB3i5ahZ0GWLkWla3+sxlnL0h2ymkXCJ7nYr/1B0GQP3SDeeAZKn
AqPFhWvuQRojIS+ki7MrNkTXWUH72VD0fX/NKzPOtRdURw2zvB9nQAa1E/LjSuQe
eT10AKcv+SL+8G2hXMNn64Hd6f5V23jVPBZv1wKQI8pXcVWGR+i8Q7BIz4ZZSgDv
eGzBrdHlph6z2Z9BGTCjLEhlUQ1CfGxUvldIDEiILx5C0b2YMc6Q5K8iM+I+SITR
wRCtPCORINha3ZzfLXTY/xE9KSRpruoxznOZiNQQdC0SG7LOHbjkMSpEQWBvdkQU
2ztjR2bdRz2OBBeVLvmh0sRJoSRkzeu5spRWOkwsvCoeMvC402G/m8+6pQOaz3Nu
vS2iMhP1/5ldpPVZinqX
=u4Vn
-----END PGP SIGNATURE-----

--TPGKQYD3WP7vMswh--
