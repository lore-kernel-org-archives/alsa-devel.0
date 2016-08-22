From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: Intel: Skylake: Parse manifest
	data
Date: Mon, 22 Aug 2016 18:47:14 +0100
Message-ID: <20160822174714.GV22076@sirena.org.uk>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
 <1470985193-10680-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7196672039012196658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1996626585A
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 19:47:24 +0200 (CEST)
In-Reply-To: <1470985193-10680-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7196672039012196658==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dRgc669pgRVB2OqT"
Content-Disposition: inline


--dRgc669pgRVB2OqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 12:29:53PM +0530, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
>=20
> Topology manifest has lib names and lib count info. So,
> define tokens to represent module private data and parse
> these tokens to fill up the manifest structure in the driver
> accordingly.

This doesn't apply against current code, please check and resend.

--dRgc669pgRVB2OqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXuzqhAAoJECTWi3JdVIfQBCQH/1UUrlUrRNxfZE+eSB3uS3+X
UuUCsrwPELi0zNyj7Bi526zJzQgfxsq3HNJGuLbZU8lo7w0mrmaXqlxLWVOi8g1G
QJ03omF0vbqkBsn9VmlyYL1S8/3KcB0Rr000Vrcp13Sr3fnVlf45ldCwVwAi7l7N
lDOY9ySt2z0u1f/PHYcyJ9vnmsPdUETsJ+/EzIAgkBMItvgYTr7hnf/8ElQN/m+Y
MQlqM6313MDtY6pCHMiY8ayYFz0LsBYQBJ/8snGRhdqgcoSl5jJ2OLeoz/BIg/56
zt8f/8amitg45CpOA3qn3eI5BQtNeKD4KrJO0b9OIfVCV6qojjYxdXCIKQS6WVE=
=Ds3f
-----END PGP SIGNATURE-----

--dRgc669pgRVB2OqT--

--===============7196672039012196658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7196672039012196658==--
