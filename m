From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] ASoC: Intel: Use DMI name for sound
 card long name in Broadwell machine driver
Date: Tue, 17 Jan 2017 17:56:36 +0000
Message-ID: <20170117175636.laoybapp7jqtpzno@sirena.org.uk>
References: <cover.1484381178.git.mengdong.lin@linux.intel.com>
 <7d5a432b03df6298e85b2af1f520e48821ada648.1484381178.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5840487398065023733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F97326725F
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 18:56:43 +0100 (CET)
In-Reply-To: <7d5a432b03df6298e85b2af1f520e48821ada648.1484381178.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5840487398065023733==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ngrrh7bjrovdcvkd"
Content-Disposition: inline


--ngrrh7bjrovdcvkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2017 at 04:13:09PM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> Intel Broadwell machine driver will call API snd_soc_set_dmi_name() to
> use DMI info to make the sound card long name.

I guess we'll see further patches for other machine drivers?

--ngrrh7bjrovdcvkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+WtQACgkQJNaLcl1U
h9Cnmgf9Gk+UqJkAqZeI1X/+oH6BlYeVFHUVMqj3WaAzwNBNyfDWq66ZFWckNiPt
RMseeoKamnBM0dBKh4+2W43Tqb0DOM02IqTa5QSNd3PtCLY/GoReFbxxtxl33m/3
U7rah5Dq8lJ+KZIGZaahZ3sZXJKyo/LYKyRcaHb6zCgfin/T0IATyzArd9MKLQxk
JwmJseRmvfzRSuZyLCJp9q1qxj3B4MJENUtmKpjAj59+wapAT+jrRCDShW+AWc72
OJnXU3ocX0pEn+pkX2horSkiGWp3Ufn/j7dKgVL5w5AaqjPd4d1miV2ovKjo4Oyf
m8p64ao383rdh7poNQSACgv0zJotWQ==
=Prjd
-----END PGP SIGNATURE-----

--ngrrh7bjrovdcvkd--

--===============5840487398065023733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5840487398065023733==--
