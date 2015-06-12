From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Add the device tree parser
Date: Fri, 12 Jun 2015 11:30:26 +0100
Message-ID: <20150612103026.GD1921@sirena.org.uk>
References: <1434091656-12800-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1155308625877131553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 931F3266831
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 12:30:58 +0200 (CEST)
In-Reply-To: <1434091656-12800-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1155308625877131553==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 02:47:36PM +0800, Oder Chiou wrote:
> Modify the RT5645 driver to parse platform data from device tree. This is
> missing from previous patch in sound/soc/codecs/rt5645.c, that was present
> in v3.

Applied, thanks.

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerTBAAoJECTWi3JdVIfQ4DsH/39/Qp0zjCH50TEQvfyTLeuq
n1yXk4S5FNEocxSKb1+7hgJsYFlBBir/pqfhE50nvHxEPJgc11bU51FgIRIax29V
2g6sx9TMZ1QiDV0iWWV73IDq4iWuaEsd09iCSscBQShHyJJZW0hktjo+zJjA4bQM
IBtnMXaEOvGwZa68TqbvkCadOLrLty4QRpBe41+W/7OQplzsualS3sqSxBXVIIIb
ZZ92Ww2piWji5SqDRCMzHkL/aQdds+jsqKYwl60DgPyjAi1mLRDMEbtreVXUy1nA
lCNIJ7u8/RFWMaHfeDMbYJ1wIbUASnyLUIkXm2PAZMyrlW1Ym07iVy/AAGKrYdQ=
=b5iU
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

--===============1155308625877131553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1155308625877131553==--
