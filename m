From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: fixup channels_min
Date: Fri, 10 Apr 2015 11:04:10 +0100
Message-ID: <20150410100410.GF6023@sirena.org.uk>
References: <877ftk8j88.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5789914746065743872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA73C2605F9
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 12:04:16 +0200 (CEST)
In-Reply-To: <877ftk8j88.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5789914746065743872==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sLSV53n4FQUQ2X45"
Content-Disposition: inline


--sLSV53n4FQUQ2X45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 08:46:22AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> ak4642 doesn't have Mono record, ak4643 have it, but not supported.
> This patch fixes channel mismatch

Applied, thanks.

--sLSV53n4FQUQ2X45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ6AZAAoJECTWi3JdVIfQDDwH/jFM1Wf4poeAPftNDvW4Sx3n
ROa55Ff8FLpxF1Tj66uPJYd9OLTeUyV5IcNNlHUAf2PIxtnwGMANgoCtuFk1B5zD
CrSvBZDKu14j1FWxGFmMZgkvEwdjhbGmEtWAaPFz/jQAc8M3Ie/tX9ws8OBAs5Wf
0+PE36AJbV9uDk/cQUbK2ovDYiNDJeSTjf4sUX2DcC4S8/oRTBkwUhN5n5BXQ7mw
pvm+Fmu3MOdo1v8J/1ut+htuGFO5ES+Y68K9EL87MZGOMGreYmPCn7zBAkaIpB9S
gvtVGvmT1bxp/98S4vZhoK5BF5ELWE54RWYSUNG/A90c1FMS+PP8tRyzYQz9C5k=
=VIrS
-----END PGP SIGNATURE-----

--sLSV53n4FQUQ2X45--

--===============5789914746065743872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5789914746065743872==--
