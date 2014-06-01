From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: Add Baytrail byt-max98090
	machine driver
Date: Sun, 1 Jun 2014 11:45:17 +0100
Message-ID: <20140601104517.GY5099@sirena.org.uk>
References: <1401452203-5444-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7461734483665562326=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F1BE26524C
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 12:45:26 +0200 (CEST)
In-Reply-To: <1401452203-5444-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7461734483665562326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9WMDU/RdULAIC7Q"
Content-Disposition: inline


--+9WMDU/RdULAIC7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 03:16:43PM +0300, Jarkko Nikula wrote:
> Add machine driver and ACPI probing for Baytrail SST with MAX98090 codec.
>=20
> Jack detect code from Kevin Strasser <kevin.strasser@intel.com>, GPIO
> resolving from Mika Westerberg <mika.westerberg@linux.intel.com> and fixes
> and cleanups from Liam Girdwood <liam.r.girdwood@linux.intel.com>.

Applied, thanks.

--+9WMDU/RdULAIC7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwQ6AAoJELSic+t+oim9/NEP/R5yo2/u6BDlMs5SdFCJQeYu
hdJSfXqDSbp4GTAkr3yFMm94W+O3OqimHF0TPJsI5/Mmjvr9yJOisBjH7HwLVUxA
z0CyB+vI/wv+977rRBw+xaHKvlkv3dxBeQpdUEtdmiN4VyqTUMyTFfDWbZko2O/U
biFD7j+1vJN1f59RTNzESW2nUNOAK7q1R98RTLAPymBCPK4GS5hk2QSRHA7xFKMO
CCCW2W+t4Jjh96luRZ9nSVNjEgp8dEJOqdXWXXYaiy4NzzihnIGU2b8bhzN7oGCf
BYflRsGYYo7iGfzPbtRB/yJeEVMTWTx4CEIzO3miFciGlx9xZdrYfuTG50FXXhmV
ysJVBmlCF+ZMreu9XPG8wT0NvxB8zgYAsPv0cnbvLG6F50d5xBLXBNlgF089eYNr
z9KQq6Ia3b9x7Pm6YRXiEBYpesjO2x1XwkVwbCJMHQsYocFwWicHv/9zSYizbB4z
xMXawhZJ8ixeI8FMHUNg2b2dsIKofDZZexa/THH1m7GRPZfmFTiOBCdajHRu5ctZ
PWX2Dlz9H62g+fJ8xr812yjyDqDNM8CEAO4gITcpgNbPGnrIvZahjaRPKln12r1g
M3Vs6455L4ezOew2pVkj8RrGb8rIruFXw8wVhFY0X/prVVve562JI1WjHu5hIyqy
04M0fPeH9yxt5H8QVjbb
=H6iv
-----END PGP SIGNATURE-----

--+9WMDU/RdULAIC7Q--

--===============7461734483665562326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7461734483665562326==--
