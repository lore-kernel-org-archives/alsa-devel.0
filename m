From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: atmel-pcm: add dma support
Date: Tue, 20 Nov 2012 18:24:35 +0900
Message-ID: <20121120092433.GB10560@opensource.wolfsonmicro.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
 <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
 <20121120085728.GX10560@opensource.wolfsonmicro.com>
 <50AB4BBB.7050308@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z4ZSWl3cPHKQyRxO"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50AB4BBB.7050308@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Z4ZSWl3cPHKQyRxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 05:22:03PM +0800, Bo Shen wrote:
> On 11/20/2012 16:57, Mark Brown wrote:

> >If you're using dmaengine you really need a *very* good reason not to
> >use the core dmaengine support...

> You mean I should using the soc-dmaengine-pcm, am I right?

Yes, that's right.

--Z4ZSWl3cPHKQyRxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQq0wBAAoJELSic+t+oim9igIP/Rr6CuLFujilpxVFd1RsOi9q
w7hFu1ntrFr55tApuMKrLbjc9xLyoLkocvVs9ccMtYgkbsEcWMossnIqArckKIUc
CZiK283Xbm8hTPqy0BZLsQP6NvJYY5Uh6o3nPppV4Ob2VzZfEkQ/bHDaUcEURJ/5
X4b/cePtfRKVvgqiqhRSzxKYP2/Fcl3R8ftn9ELbi1VcZXF03Lu13FprDeUHq2xQ
rH+Jg83B+ZZGiMrn1h1auU23TboP+U6BmD8WiqQf+yrwtUpCryr/9aTIVkUE+vIq
cf7RqcPinSTdI6TvjkgnXw9JuKPgA2JIZaRzV1OJml+2QyuSnJM2mo2FxhDJ7opp
NDEX7UgD9hXwffAfqQuox9Q5N5ckbLi9bzmXSlqTSdTe2BCWWaEjoD3c+HmC1YfJ
gbUHyH5siq7xtFrtVa6++MBLrnjvu/5TmH2LG83rleVuRvXO/uaAZ9TyAVvPZ8rW
Du51odVXOsjtDSa7/EK9zjb/MJARDzdWio0thbQhMiR90VGKkC5yuSG7zK5ZrYzF
fnc7mEP5D4F6ehZMN9nNvF93ySLlO0GvrIrZiWDA2ilSVBJoO3YejjTXGs632jTO
psixRu6TTt7wCTzM49rmHKfTl9XPiPk6CFpz28xv6OYmKz9An8RvAC9yDjVP1RTC
HDTNiqn6dBDNHKhWTBYG
=VD1N
-----END PGP SIGNATURE-----

--Z4ZSWl3cPHKQyRxO--
