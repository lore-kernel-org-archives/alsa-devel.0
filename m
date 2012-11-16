From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs/wm8978: Remove remuxing of
	GPIO1 pin
Date: Fri, 16 Nov 2012 09:41:12 +0900
Message-ID: <20121116004111.GE4387@opensource.wolfsonmicro.com>
References: <1353008762-38012-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6722005299006415269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E6F3265CE6
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 01:41:18 +0100 (CET)
In-Reply-To: <1353008762-38012-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6722005299006415269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 02:46:02PM -0500, Eric Millbrandt wrote:
> Remove remuxing GPIO1.  Leave control of this up to the platform device.
>=20
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

Applied, thanks.

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpYufAAoJELSic+t+oim9xI4P/jHRh3KhOewyx2T8feemv0ix
NVngoXOlNz6avGKHPHRXnS8aR/jdJ7dQfHpxY1p8ruRWmtRIBvkXSYOTl/+jBc28
NaB30xdM4NvSREiZvR4CIpImWOWTFqmrrNPv2aZwVIOKxDJLwbrJ5DH/tPyKrntO
RGMzPR4UG4TT9yy8FKB9wPko6wM5wGF2xEHTnPiyvZqNMYce2bvUyt7spTjos2OJ
eu5ul6ObHRDhHNR+Xu9cI1ERGe2zbhhWgerRt0peMT87l0a2TbGqkOzeS2U8g4Ej
qe8JD0JPeZyINgfZ1xbYExNfzh70tbqn1GPF1C41sZG+caH/DbhdCj9YRFkPS7qO
QI5NW9kGIV9+eq5KG156GzU6vhhXX3chRyIptZSQUEnLBgW9V6RDKf2BDgvwTDWW
c+ZX8caGllt8dqctVIoZT0Eg5BsyNYNYhra13AzZLZ2xaES8EXgGaVZJs0Mc6RzA
NVgzYNnJocQ/sjn7FmasaCEuuIcuP415rq+c/u0vFRT6M973D+3KocPCzC3gfyDW
vfyCHdxv+8SdLkFYTUq9enH6ZF7HpysyzYiEQoZ0kTCEP/AbOPogXz0CbQVnZRx8
X4iYIlicTStKefP5hUPf1L7I6D4Fs0NErHTIHgqH7tRkBNrmxAhjk+C4aPQy0YBn
yixsXss+1ndUNFV+AY9s
=I2Kf
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

--===============6722005299006415269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6722005299006415269==--
