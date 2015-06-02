From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: max98090: read micbias from
	device property
Date: Tue, 2 Jun 2015 18:11:17 +0100
Message-ID: <20150602171117.GW14071@sirena.org.uk>
References: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8231794629662924998=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F728260560
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 19:11:27 +0200 (CEST)
In-Reply-To: <1432925772-117760-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============8231794629662924998==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dnBRaVjvtun1Q0Od"
Content-Disposition: inline


--dnBRaVjvtun1Q0Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 11:56:10AM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> This patch reads max98090 micbias from acpi or dt

Applied, thanks.

--dnBRaVjvtun1Q0Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbeO0AAoJECTWi3JdVIfQW8UH/iFYSUwZJ1KSubqa2it15fjV
Zbj7vTU/AWcB7HlZdVFeDICWvb4WjFc7za7h6Mrsvli6i90QasPem0XX3nSqtJH1
SYvrHJ8/js+IL3W2B3yN0VHkgRNIuBkENj3yBZ0ffk14xpLV8iIdgHi7ulq+UFfA
PywUiUIA95v/3M2aMXIcdeSRmVv1aVkHMwjsmlKwY/gsEpaZKm/2rOwRC5HKF9tn
a01wJZ/XDhbAUuwduOoId60aklRL011PMXEhx1HXwFbvNse71Ez/JDExyUscZnG8
qT6ufsTQnPjVMzZne1bKoTT6cVvusihATIIH0cCqQoI7LpxEiybB0MtAZScIaoU=
=XfAA
-----END PGP SIGNATURE-----

--dnBRaVjvtun1Q0Od--

--===============8231794629662924998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8231794629662924998==--
