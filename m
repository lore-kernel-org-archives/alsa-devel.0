From: Mark Brown <broonie@kernel.org>
Subject: Re: [REPOST REPOST PATCH v3 0/3] ASoC: Reduce audio
 related kernel spew.
Date: Mon, 27 Jun 2016 15:50:29 +0100
Message-ID: <20160627145029.GX28202@sirena.org.uk>
References: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
 <1466815031-31922-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3809908291489138549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC0FB267A13
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 16:50:39 +0200 (CEST)
In-Reply-To: <1466815031-31922-1-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vedang.patel@intel.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, marc.herbert@intel.com, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3809908291489138549==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nrCuQK91QKw8CgBg"
Content-Disposition: inline


--nrCuQK91QKw8CgBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2016 at 05:37:08PM -0700, vedang.patel@intel.com wrote:
> From: Vedang Patel <vedang.patel@intel.com>
>=20
> There have been complaints regarding audio related kernel messages floodi=
ng
> dmesg. This series tries to address those complaints.

Please don't include noise like REPOST in the subject line, especially
not at the start of the subject line where it makes it look less like a
patch e-mail and so harder to spot in an inbox.  I also note that this
appears to be the first time you've sent me these patches...

--nrCuQK91QKw8CgBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcT00AAoJECTWi3JdVIfQYOEH/RsZAWROOXBiphiEA+Fn6yR6
iI91hSg3GDrLBNz6gmGdhuTGdqRy+stbi50SEUkEVIPAl/yeE6w93XTSP2n94FIC
DVg/S6z4Pddj4DT/0fCmUWZegogLxY0bjpaQWi/Xw2BWlPCTu9LAaRZytN4ERxo7
nM/QJwDzVRPzj3C4WYqwuo4yO/R4iAInHONgylT9ztSV4WvIgbP30/XtYKUWpMa5
GZQlHtHI80kDl2VJlW/UMj6lPVRorOXN3ZW8bSf+aWFmCrs7/O3o7MaoOPO4AtLw
fUkK4YkV7+0pSaL5D/G+AXpfaFkVzjd7zIZ2cF5T/d3G48G3esH7BHOd+i2WJ7E=
=8oOn
-----END PGP SIGNATURE-----

--nrCuQK91QKw8CgBg--

--===============3809908291489138549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3809908291489138549==--
