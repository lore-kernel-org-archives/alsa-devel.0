From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: jive: Automatically disconnect
 non-connected pins
Date: Fri, 16 Jan 2015 16:59:19 +0000
Message-ID: <20150116165919.GF3856@sirena.org.uk>
References: <1421415293-29589-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3701471259192659746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FBF3260414
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 17:59:30 +0100 (CET)
In-Reply-To: <1421415293-29589-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3701471259192659746==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 02:34:52PM +0100, Lars-Peter Clausen wrote:
> All DAPM input and output pins of the wm8750 are either used in the card's
> DAPM routing table or are marked as not connected.

Applied, thanks.

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuUNmAAoJECTWi3JdVIfQ8koH/1bJlEwfKpnf0yj08Fe7e6r2
teGIV4mGwmssdUgMMc8L5kJbMYw8M3dIBMOxjBelg0ndPDifGF4B+8KNilK3HZfv
B3PSVd7aAvFNq0iNyPjWzMyKHX79IV+oviK0MWiG1rrauT8Q9ftJYrzwhipZXP5d
OlGTZOi8eSutyMqebBxtbEMhNOyW9dbABeIYCpFRVPK+UNpxScg9QkdR36FvylLT
T+kHzaJNPuJqv3zrErFcapVqOgtzUvgOAESIr1SuGGBwo5PGhjfF8ZSFtAZZoMrl
FS221Q8XkXZDNXcCeKBjer7CaN5dHXPa7R3pBxy53JKiOnxgvMbEqSLTKTQXKM8=
=ccMF
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--

--===============3701471259192659746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3701471259192659746==--
