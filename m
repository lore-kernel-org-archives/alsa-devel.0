From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Resend PATCH v6 1/4] pinctrl: atmel-ssc: add pinctrl support
Date: Mon, 17 Dec 2012 20:24:29 +0900
Message-ID: <20121217112428.GA4985@opensource.wolfsonmicro.com>
References: <1353464229-20846-1-git-send-email-voice.shen@atmel.com>
 <20121121022441.GJ4673@opensource.wolfsonmicro.com>
 <20121217093947.GG23971@game.jcrosoft.org>
 <50CEF298.3070508@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50CEF298.3070508@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2012 at 11:23:20AM +0100, Nicolas Ferre wrote:

> Mark, what about rebasing this one on top of current Linus' tree
> (toguether with the one that you have just applied on the topic/atmel
> branch: (ASoC: atmel-ssc: change disable to disable in dts node)?

> I hope that once reworked, they will be able to reach Linus' tree soon
> because the lack of this patch is causing DTB compilation errors on all
> AT91...

I'm going to send a pull request for the last one today.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzwDkAAoJELSic+t+oim9gogP/01hA5sTydKQgw7S6MhGzMu6
WnV1/++0jYbJODdGO6GXXwH7/cUAsWQxh66mYRfHdirKnS4oszsKOKCHCxvuatFe
y9GtDd9AI6nC9VdHtIG/vgfAjyG6LPBU1y7FZhSFIbl4kfPtaWYA6izD6bsZhp4y
zjKTAwqOwGNGMUVuPARVXVvM6MznWLm/TudR/KMRvAxlRJiDk5YXVERwmInJxZ4s
+4vt9B/29MUNIBq6VHBvaN+o0yJpozrcac350y8f9t7qQ+AwRDYrcHPAfCmpqGvb
kfjFMT3wvqgP3tV2UMP72ky1npzTuz0I8c+zoMFqayswptnLiZB6OL8H1J6L0aXy
qDHOq/UzuDy19qNsaAsYNCCtEnOQNX9084S1AoIZC0EEF3CIHbBZ04aUyummOygr
AveYjCaXudoQYIFtV2lIiveM1m8KgEzl4HyklreIJnscCKDFmEOVpo6SJimsgoqs
GUFXjLAFJzIxEuZTENYn5PoQjGQD08mE1/kR0BU8ePTjyE4quG0CCDfIklpoxmhs
vrh2ZSno+P8dx7sxb+T+XOselmm7YrVgzejyH+cmxVNtjKqYtPrWJuD2Pz6/p4wl
uANpcroo6wNsN6pWYVoigF3rkD0bCLXLEt2f7cHdMmfACy0eXwhosrQeYY2gm7Yp
lNFEA4e9Tz1votvySFBy
=EHTI
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
