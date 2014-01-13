From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Mon, 13 Jan 2014 12:37:21 +0000
Message-ID: <20140113123721.GV29039@sirena.org.uk>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
 <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6437626759403969015=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A742608B7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 13:37:26 +0100 (CET)
In-Reply-To: <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============6437626759403969015==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFtobK8oO579scb0"
Content-Disposition: inline


--iFtobK8oO579scb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2014 at 02:48:31PM +0100, Markus Pargmann wrote:
> Add tlv320aic32x4 to the compatible list in the binding documentation.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks but you should really also add this compatible string to
the driver.

--iFtobK8oO579scb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS093+AAoJELSic+t+oim9GzIP/0njhTLculfBAArOvEUSNSuS
V2+CK6MVMZwpAEKeX/06yGtZwbJUJS0P/4vsn/O8Qcv4faBtc12wgf1mbrMquIkl
OaXgPVZscU/J0a8N0nQjX7zxXvUZUBxNj7AZWGmV1J11ppJ+4eVg0d1cChc4tKyh
v3Dk4yBxbAzBssYX15x2JnPLlInI2ZDtNK878NlMGW8O1flCb57vlupTgnDJvqb2
SxVP60VV0vZh05uGU/6ntaq7fqnzn5LD4+ZbTTWy8/d57aN2oG/5cYfGIF1C9H3x
lelpOB685cOkMPKasXFmxuQgoZxqKArmdXb543Pa95dKT69AJBsdXlpv+D+WUQZb
1+5H7rSma+xxt1l531eEHs09S47Zzj2qb6d3oZOAo0oszoFU0hfIn0TCFpQAAqRs
3Mwyusm1MLGxrc8t3mMja3X/N0dIjb+yJid7MEdkYAMxpiLt3TgCqvh8BBD6rRXS
1041accsv5Il1M08jA4ajGQNWmB9dcpRtd+isFcUyTW9lMAEuVWN992ExqLQdOTQ
lPkr1/El9tlMRFqQyxt/cEzyzUxjceW0Zmhjwp6GyX/PTEEcH5pFRlzpz+mgdDkd
A7++j5f4J9OssS641fpmVmh6JMq/kkHA0GQ2Hd43t1Mhw648ymN5hEyrRZDWPOkv
bQT5xE4FEP9J1/0VP+dC
=cPhi
-----END PGP SIGNATURE-----

--iFtobK8oO579scb0--

--===============6437626759403969015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6437626759403969015==--
