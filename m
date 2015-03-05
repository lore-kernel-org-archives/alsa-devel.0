From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add support for NAU8824 codec to ASoC
Date: Thu, 5 Mar 2015 11:43:44 +0000
Message-ID: <20150305114344.GJ21293@sirena.org.uk>
References: <54F70052.1070109@nuvoton.com>
 <1425508332.2090.48.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OhU7L4N+XivK3AnT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425508332.2090.48.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Chih-Chiang Chang <ccchang12@nuvoton.com>, "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--OhU7L4N+XivK3AnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 11:32:12PM +0100, Paul Bolle wrote:
> Chih-Chiang Chang schreef op wo 04-03-2015 om 20:53 [+0800]:

> > +struct nau8824_platform_data {

> In the future something other than just sound/soc/codecs/nau8824.h is
> going to include this header, right?

It's platform data, that's the whole point of platform data...

--OhU7L4N+XivK3AnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+EFwAAoJECTWi3JdVIfQDeUH/jyKKQ8u4OoFltQ/K26MG5I0
wTF46/tixokx7RDLJnA2AQ2YYJcsJ/DZIF2QcXy1ChBMGjQyLlswiKqdLVB0FA6j
BoZOswBYenHbYU0wPL6O1qVbnT7/zKOCiKIbozPs/eF6jCa31kFuARa6kTeP7Vqy
3u4ldcLotJ0tqc+U0N9e6Sk0G/pnVAQ2sM+a5oQMjwu3kRcHK/ZB+CTGkC7T65Z/
sIpTzCDfjhpKu84vJ1J3+SleP9RwaEa69Cg/Bqqn+xaJqZTZMeKCNDSU62ZNBDkR
dwUliRZxxuaWnI8qE1uDaeSknYuooPlkPSm1hdl5wFhPrDo1MKXHQYmD9OkmTJc=
=iWp/
-----END PGP SIGNATURE-----

--OhU7L4N+XivK3AnT--
