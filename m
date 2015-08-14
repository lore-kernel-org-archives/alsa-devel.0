From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 9/9] ASoC: Intel: Skylake: Remove CPU dai
	that is not used
Date: Fri, 14 Aug 2015 23:06:33 +0100
Message-ID: <20150814220633.GX10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-10-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1231701676393640977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C950526627C
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:23 +0200 (CEST)
In-Reply-To: <1438976184-6160-10-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1231701676393640977==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UaIp6+ubhcbWp687"
Content-Disposition: inline


--UaIp6+ubhcbWp687
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 01:06:24AM +0530, Subhransu S. Prusty wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> For each endpoint instance, need to create CPU dai,
> Removed unused CPU dai DMIC23/HDA-SPK/HDA-AMIC dais.

I'm not sure I understand the first line here?

--UaIp6+ubhcbWp687
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzmZoAAoJECTWi3JdVIfQtugH/Rw3iPnCfhjS8v746jWAGw5s
jtZuPo5qzKI9g/9LP4NLBG+MpdXj4gtY2XX05nNT7L99rkz0At6ijO0gCcAC96UQ
WZeCIB8dFkhCtWDI9PoyHpo0fDclpKldD6uyKcZR4lxiR8g5J5I4KxckOzgg2myp
W8btl2y4E0TBM4sL1vs1g+0kuI8KWF7TekYZTK1GPqNIND+P5FbeEPFMF3MxZ+lB
g8CQ9IuPzAZVb13rVk7ZeiH4xgq/NBgLu0GuU8cBdweClnKt/FnacGvzpPAOmL9p
DCejm3Cny4tMsHbbNqwb79emU0pCKvlSkjWCzag1vuoM/eF43rmylEw78UZU9vE=
=hNSf
-----END PGP SIGNATURE-----

--UaIp6+ubhcbWp687--

--===============1231701676393640977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1231701676393640977==--
