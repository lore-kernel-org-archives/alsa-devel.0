From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: nau8825: non-clock jack detection
 for power saving at standby" to the asoc tree
Date: Fri, 13 May 2016 14:34:11 +0100
Message-ID: <20160513133411.GQ22038@sirena.org.uk>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <E1b1D6W-00018S-LM@finisterre>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6668542505407763556=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7938C260564
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 15:34:23 +0200 (CEST)
In-Reply-To: <E1b1D6W-00018S-LM@finisterre>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, Ben Zhang <benzh@chromium.org>, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============6668542505407763556==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 02:26:08PM +0100, Mark Brown wrote:
> The patch
>=20
>    ASoC: nau8825: non-clock jack detection for power saving at standby
>=20
> has been applied to the asoc tree at
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20

This seems to conflict with some power management fixes in Linus' tree
so I've dropped it.  Please check and resend.

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNdehAAoJECTWi3JdVIfQ9jAH/R9D5VvL9hINt2+SZHZxDOq/
rajKEt22usPs+WcosAQ293ixzTWtS3QbZSBokGF01MP1Vrdjf+TSm3mLZKYJsNJb
L/njsjFj7dX/RVxSdPnY/bgAZPHG43IwKQ9KklIzAqzVgzymI3mvtiK3NRhqd/iw
3922a2bhWc7cTf6EXxkTJ1ZOrm11ixw6/CMURecc2+S2X35anNnTZB4cvrq/zaF9
zsvSaD1zWdz5pMeWwV61Kkz58i3Kkm+ltfiPnjj/3pVPXQAPDy5/eKtgNRyZAILh
YvvJc5FLhmjD2gvYL1kDlxQoJZ+0llRJ73OvPglBrnR9KcSklZCHg2YigoOtY3k=
=XefD
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--

--===============6668542505407763556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6668542505407763556==--
