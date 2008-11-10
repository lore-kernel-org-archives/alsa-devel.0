From: Adam Jackson <ajax@nwnk.net>
Subject: Re: [PATCH 0/3] enable HDMI audio output for HDMI monitors V2
Date: Mon, 10 Nov 2008 13:18:06 -0500
Message-ID: <1226341086.31982.141.camel@atropine.boston.devel.redhat.com>
References: <20081107062338.158523355@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0776092279=="
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <20081107062338.158523355@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Wu Fengguang <wfg@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-gfx@linux.intel.com, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============0776092279==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OH4wGryk504mKfYjeS9g"


--=-OH4wGryk504mKfYjeS9g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-11-07 at 14:23 +0800, Wu Fengguang wrote:
> Hello,
>=20
> We can now enjoy music on HDMI monitors that are attached to Intel G35/G4=
5
> chipsets with the following X.org intel driver patches
>=20
>       [PATCH 1/3] introduce i830_hdmi_priv.has_hdmi_sink
>       [PATCH 2/3] enable Intel G45 integrated HDMI audio output
>       [PATCH 3/3] enable Intel G35 SDVO HDMI audio output
>=20
> _and_ the corresponding ALSA patch posted at
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012158=
.html
>=20
> The patches are tested OK on Intel DG45ID board, HP 2230s notebook and
> ASUS P5E-VM board.

Patch series looks good to me.

- ajax

--=-OH4wGryk504mKfYjeS9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkYet4ACgkQW4otUKDs0NPetwCgvq7Vq0cZFmbrV02SwXXC8bUQ
v8MAoOqix+0wesNDyy/ttaJr8yBKvLQ0
=mCet
-----END PGP SIGNATURE-----

--=-OH4wGryk504mKfYjeS9g--


--===============0776092279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============0776092279==--
