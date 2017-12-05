From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC: uniphier: add support for
	UniPhier EVEA codec
Date: Tue, 5 Dec 2017 11:59:15 +0000
Message-ID: <20171205115915.GB11658@finisterre>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-5-suzuki.katsuhiro@socionext.com>
 <20171204182027.2k5uw5og65h6ac7w@sirena.org.uk>
 <CAK7LNAR=-vHN5k6irpaDcAUYcH2kjCXLJpf10RMuq=GZB3huog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8683592337963725759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A16E266A74
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 12:59:21 +0100 (CET)
In-Reply-To: <CAK7LNAR=-vHN5k6irpaDcAUYcH2kjCXLJpf10RMuq=GZB3huog@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8683592337963725759==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 09:58:54AM +0900, Masahiro Yamada wrote:

> Indeed ugly,
> but I think this is intentional to make the SPDX line stand out.

>=20
> Linus suggested this as far as I understood from the following:
> https://patchwork.kernel.org/patch/10016201/

> If you use C++ comment style for the entire block,
> it will not stand out.

It's the first line of the file to make it stand out, if you google
around you can find some other conversation about how C++ comments are
a good idea in general and this might encourage them.

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlomihAACgkQJNaLcl1U
h9C3NQf/ZoLjydjXpiCZxv4eVvZkj8DoVueUDFclZMb0P+Xhh/jUvBPTEnr4s/vf
1VoDLyF3b4tlLKS4ctWGyEpjn2wGOMS6tyu2187xtf4CXBo0eFXzDwh5xBbUAOLp
Y+R+R0vdCxcogJUlgtd2ktPYr3+Bp0YjEIdQP1IbTErntuQUz6qaqF95sYFyxS8H
Y9plzNRzdWjg1Wbk6NkKBDhVaxKih1dpFmA9IX2PEIF8q9jDYEIhrsFU6tr3zH75
Tp/tyuwKYG4NJ9+8QMiQPIUGbHyIz1iDv3oJ2UlAHbSkg6j9Et7flpHPmbLbdicX
8kbPLjisDlNFiBgQdfKaqKl23zlMqQ==
=RgyB
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

--===============8683592337963725759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8683592337963725759==--
