From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Thu, 30 Apr 2015 21:15:28 +0100
Message-ID: <20150430201528.GL22845@sirena.org.uk>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0234330125586926689=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF1926153A
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:15:34 +0200 (CEST)
In-Reply-To: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============0234330125586926689==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q9+FHXrkM6RBbzac"
Content-Disposition: inline


--q9+FHXrkM6RBbzac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 06:43:56PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> Add machine driver for two Intel Cherryview-based platforms, Cherrytrail
> and Braswell, with max98090 codec.

This and the first patch are basically fine modulo the comments that
Vinod and Pierre raised.

--q9+FHXrkM6RBbzac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQo1fAAoJECTWi3JdVIfQsM4H/0x0C4IVFt4/CQ9Uy4e/4KBT
ItgkXy3mDOny0Ay1m0HdMkgRjpfd3dmCViwWmPlrquP1wv8EE4FTAuDJBBa/rJSP
FoIjvN5hrHHLEwNROO1wFclbBT9/AYQ/5ZQZOboUc/J13g5FWKHckGrtDb1uY1sd
o4dMIU5qm5HS8lSM2KomhJI7olAlVS1Nef2rFMqK4b0nLWnZTucuurmd8Ve/La9B
TRl1Bdy96H9ZHYHJWaDZHJoeaiQhbiH31NWZi5HxwTICwsH0DJjOXNA7gh1DOi+R
HG3tJSCjYe27EP5OfKlcmiKWr9jfLDQrUfKoNBl8/EoEnYmCa5NeycL24tVKqrs=
=aNI4
-----END PGP SIGNATURE-----

--q9+FHXrkM6RBbzac--

--===============0234330125586926689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0234330125586926689==--
