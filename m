From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: tlv320aic3x: Include linux/of.h
	header
Date: Wed, 16 Oct 2013 19:02:42 +0100
Message-ID: <20131016180242.GT2443@sirena.org.uk>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
 <1381492441-31195-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2265606081594417876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B18D326526F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:02:44 +0200 (CEST)
In-Reply-To: <1381492441-31195-5-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2265606081594417876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FWPj80eDhI2FxCDV"
Content-Disposition: inline


--FWPj80eDhI2FxCDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 05:24:00PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Applied, thanks.

--FWPj80eDhI2FxCDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtS/AAoJELSic+t+oim9CRQQAJfu1HY6gxVbIf2KKziyphiH
iu8Aw6YJwInfNdqpXpPfLIiwc0iQgFwAOa8Eymr2mEitidhhgJUAq7NYf2ttf2Bd
vW2uRhziLAiWYtugjOzusw0JeJTOd4If5DXA47UPYRX+97opMW0wbfd9TRUqJLSa
W3hLSdmvCX/laXRSmq4+TuHSFwBIYBvA1Fyeu6kLRsvhWClDNp1ykO7yARnmOSq6
HyBdhm4YD9qkOykD0dtntqrImila32rULtAR8cK0mrSFBAmp5BTbh7/k+NCbZYY1
QRLpJOtWPx92wATAoXaSOIwAutrIAQWW0qYcMY38gRyOlDv/NAZCEd/xz+SyaBu0
6tIJQXdeTz/A4Evr3UkRWw+j632PU3Jny6YJMNUbUTbX9nzPDwK59WhG1nFcIqpd
uWA3VK2XztNd0fAfCOeU2qNOItH2ILSF2p1DKLFSVNFpiqBuJAdAB6n2dwbcZuQo
tky7lu1YL7JDsWp03QH6DRP+X+60d3oaw+jPT6f9QUrN2RNB/LJan1BvAeQoZzW6
8FMdWnJ/MmxocZEGvux/lanSKP8NCIZMPd6Gwhz5Uvu5WxQeh15kuFfBezeIfBN1
RDHMOrNRg4wNIHTaPrMdx6Bc2Sn5adR8XqNpeLQMoBea8HlIBVGxR4NS5Lsif8KY
9iC8w36bmAPRRzfvQ83i
=dSu8
-----END PGP SIGNATURE-----

--FWPj80eDhI2FxCDV--

--===============2265606081594417876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2265606081594417876==--
