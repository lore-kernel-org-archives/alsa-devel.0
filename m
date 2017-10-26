From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: sgtl5000: Remove leading zero
 from '@0a' notation
Date: Thu, 26 Oct 2017 09:41:26 +0200
Message-ID: <20171026074126.pe7vzws77dt4kyv6@sirena.org.uk>
References: <1508952290-18794-1-git-send-email-marco.franchi@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7476574249816128518=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E17A1266A0C
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 09:41:27 +0200 (CEST)
In-Reply-To: <1508952290-18794-1-git-send-email-marco.franchi@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Franchi <marco.franchi@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, marcofrk@gmail.com, lgirdwood@gmail.com, robh+dt@kernel.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7476574249816128518==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohocs6mgsip7aogz"
Content-Disposition: inline


--ohocs6mgsip7aogz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2017 at 03:24:50PM -0200, Marco Franchi wrote:
> Improve the binding example by removing the leading 0 from '@0a' notation,
> which fixes the following build warning:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--ohocs6mgsip7aogz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnxkaYACgkQJNaLcl1U
h9A9bgf8CuLdhG267vYXLM2TiJT0iQqPYOTFiIu3fWy+hT5Wh3JSX8XwxJK1qM6F
b5COUGnvKD3Fk1BLPGfplkxGEmG5ExtUEDvTb5QslZ0rVO7+NtJFbnQummHtNU34
xWPz6hEpQyHCeWi5f9f7KWOgfg3q+REGOSOYXccbUTvqqoobWxpFO+RmhPq9NgkP
fhqKEx3SzzdQrgtxVUaCTJC4Y4i6L5oB2aDqpZaSAQBKCq84IJs1sMbykIe+Uy3H
d6F9UHZUGgM703M1FJvfTBs5whdWnFzcGEuPEjoGDDyVpMQnz79YhqM28QGpMXi9
dn5UZsKmrxbejRibxLEHHFv0eRFoUg==
=4Y16
-----END PGP SIGNATURE-----

--ohocs6mgsip7aogz--

--===============7476574249816128518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7476574249816128518==--
