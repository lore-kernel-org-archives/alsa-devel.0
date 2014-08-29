From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4 v2] ASoC: simple-card: dai_link->init
 should be cared when multi DAI
Date: Fri, 29 Aug 2014 12:51:29 +0100
Message-ID: <20140829115129.GT29327@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <8761hdia86.wl%kuninori.morimoto.gx@gmail.com>
 <871ts1ia53.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5050811017770693702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F872615F3
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 13:51:38 +0200 (CEST)
In-Reply-To: <871ts1ia53.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5050811017770693702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
Content-Disposition: inline


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 08:08:27PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> 6a91a17bd7b92b2d2aa9ece85457f52a62fd7708
> (ASoC: simple-card: Handle many DAI links)
> added multi DAI support on simple-card.

Applied, thanks.

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAGk+AAoJELSic+t+oim9SsoP/RCpV+54kP8nk40egS4S8ejr
l8PGfGsP68ihXYu9AoDgdUSU+Jwd89S0pv+Vama3eg5/7WT7AN8eYlehKVFchMgN
SEkZw/UMRdufjeScMgomr6Uvu4ld8vQdLr77xFJ4AH2TGS69+G07R+7WHjfai0xA
cZQLuDQKWglep0ccBzXyo4u3Q7eBq2Kv8vFC85x1XNX4MgkOqsrPRjrsSP26z/mE
kSN9DDcre4VLiB33gOgShX1T7SGYH/0XQqvC8RxnU9cQyJILIkmMlMqDg8BDCKCo
zQpwBovm+A0my/Byg1Zt/RtgH/CIL15PFq29FVt35d659q6Tf8Du8rXMZmjKPWgI
gRqd3GWHIqivqPFCtVLTA/yHeTYgnr3eoWZ0NTQV1Jp4tmHhqDDamtHt/nAxOH+P
9YocD6TnnZqOSyw8ili2TbSDm0h64lI2qoa3So/KRcMbbW+z7pWwYo/eHx11Gu0u
s/Jq7nzBFh9kuovPgolGeKH6wgKs7QKOxfD6BmDk9qjFKdc9BMLOuJXkqhgP1JZJ
aiwudF3JMYv+Qf8Xyucg9MB6gnKaWUkO+rxldoIYePfWtcgq5Y5G8dnuRyVQxeAa
5VH1rZx5bXo1WpeIpm27qTyrgXMfTwEnBawjUwhrOUpmu/SodfQfyjqEYRE+Co0C
ofYyq7+sQH7zvvLFEHHG
=ZRM5
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--

--===============5050811017770693702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5050811017770693702==--
