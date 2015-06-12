From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fixed incorrect sst pcm_delay
Date: Fri, 12 Jun 2015 11:24:01 +0100
Message-ID: <20150612102401.GC1921@sirena.org.uk>
References: <1434086277-9881-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5281202563525377209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 992E4266831
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 12:24:18 +0200 (CEST)
In-Reply-To: <1434086277-9881-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, sathya.prakash.m.r@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5281202563525377209==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 10:17:57PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> This patch corrected pcm_delay calculation in BSW sst driver

Applied, thanks.

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerNBAAoJECTWi3JdVIfQQRQH+weISeCjT7CCW943s7jv9Keb
ybYfAC174jEaNCkaVVKLOBQ2kU1jDGFnJGyFWlWs1lPGlW5XjsLI8A5WX83NzTbL
XuEbyGE2W1rNA8sID/A10OeEdb7PEtfTowZ283SX6yORyOo4QJDD/x8BtvZ0L5sE
BG/debxDOv274yQi1kC+QHVFWIl+vYF225otWa3jAVBX03pSNcLlkIl6rNsF+se1
yB4R5rJbyjxrVh7NpgZlmqaUDaakxhedq4CsHE0m7/7+2iEyBpka5Xd22BEbnTbt
nbywih7xZ3bPb4wonIlJriBKEVQ9NTWNsDKOv2YCVZs3BnIMeAYs073Fwyr85/w=
=nnUO
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

--===============5281202563525377209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5281202563525377209==--
