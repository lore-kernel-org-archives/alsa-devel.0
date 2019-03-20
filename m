From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH asoc] ASoC: wm_adsp: wm_halo_ops can be
	static
Date: Wed, 20 Mar 2019 17:18:42 +0000
Message-ID: <20190320171842.GD27518@sirena.org.uk>
References: <201903192324.Mauv8ezY%lkp@intel.com>
 <20190319155552.GA1200@lkp-wsm-ep2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8655508228173833517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EDBEF80736
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 18:18:54 +0100 (CET)
In-Reply-To: <20190319155552.GA1200@lkp-wsm-ep2>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Wen Shi <wenshi@opensource.cirrus.com>, patches@opensource.cirrus.com, Piotr Stankiewicz <piotrs@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Stuart Henderson <stuarth@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, kbuild-all@01.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============8655508228173833517==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 11:55:53PM +0800, kbuild test robot wrote:
>=20
> Fixes: 170b1e123f38 ("ASoC: wm_adsp: Add support for new Halo core DSPs")
> Signed-off-by: kbuild test robot <lkp@intel.com>

This (and the other fix for this file the bot sent at about the same
time) doesn't seem to apply against ucrrent code.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlySdfEACgkQJNaLcl1U
h9BaXAf/comCQqrDs4CDdNJ3G7cL7I3XRkq2q8w/WoXCqpKWcmRMNS0FNKjLkfCV
OcG1Lq50Xj5Tevg+3bNL1LoaRWdsyuzqzHLxwY503oBIKQhGCnAOh7Wit3/EVn36
kTM2fHTRi5C1PwTtE+SpaDSfMtR6qqecpr8bYcZ8+fE0PL+NhXd9P6qxQN7Cm7r6
rYKjhP6/3JB94V2HKY8tm7hJL2HsSLbe4wmoaTKwi/3OGs5wZ89NhSo5J1l+WSRl
+s/jLglVooCwOtJ6JtZLzY058LxM/iTBcQ5Nrafm74FmRmrlgyvZTu+CSjXDMZNj
jcOYa46aZNoxdbtDk/vNaVfLfjhH+g==
=ttlA
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

--===============8655508228173833517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8655508228173833517==--
