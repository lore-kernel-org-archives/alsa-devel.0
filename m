From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: lm49453: Fix adc,
	mic and sidetone volume ranges
Date: Mon, 24 Dec 2012 15:44:39 +0000
Message-ID: <20121224154439.GF30837@opensource.wolfsonmicro.com>
References: <1354879810-6452-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3050952101101463930=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA62B261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:44:40 +0100 (CET)
In-Reply-To: <1354879810-6452-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: vishwas.a.deshpande@ti.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3050952101101463930==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2012 at 05:00:10PM +0530, MR.Swami.Reddy@ti.com wrote:
> Add adc, mic, sidetone volume ranges and appropriately added the controls=
=2E=20
> Fix the DAC HP/EP/LS/LO/HA maximum gain values.

Applied, thanks.

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HhVAAoJELSic+t+oim92koQAIxE+CgE4RgYOeC7Sj1yXABF
ieIK8v/opYjngF7CjXtDCqMGOmjmXTHMG+VVaZcmQpciQgNSjVoTWIcNFbjXhr98
Ai33sWJX41X2D3LuvIP2oKNKwcKf1LTFnwk9+TV3ttjZ5BUWIYfp/Po9D0/A4MYK
xI7o0WLSNMymvRkbnCwbVWj0sxplZWVdORzMlIMDJhv9oMdrhq9CCaBOhEhOTgv/
2jpj9ooQ7PuKJeU2EC42UKzPVPexs6nZtv+NJ2Wjy/QcUGNRpVhmmtzZMh6O1hNy
b4uxsPryJJlm94JHqECtiwJPQa8KbEIc/rUEQNWvvkz4jhRfI8MnoABy+lxh+EoL
QmCQl9fKcVIamiwxpWs/J4A/yik4ez9t5hbyHsEvT1REgt6rcwByrY+ZxN9A+x5a
QOgGTFJ+vkmxHTMPCPvvQbVZPRbyhKpTyCDVy8Yl3jE1F1XB06zG6CV9Ja5nmIgn
EG/V8nmqvnhmJwwqMv2+c3D1fb/OK6tCjcStdQ2IH6r9yb9arFm7El/7w+XhY1p7
s5cT4gUSEszCGbaPZp8KxC+5wZSFxaNIBo0RCbMgHKjtshSnmS/u8n5U04l3gsgq
qxO1n3nL8+eOsZa1gj2s4iT/rDXmCc41KOp47e7cGB10jRDNlkWpP1O8Jg5WpQjq
DtKlRKigfKs5L7+Odlr9
=BrbE
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--

--===============3050952101101463930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3050952101101463930==--
