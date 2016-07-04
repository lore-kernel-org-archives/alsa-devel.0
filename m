From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm: sti: fix prototypes after API change
Date: Mon, 4 Jul 2016 15:38:10 +0200
Message-ID: <20160704133810.GF6247@sirena.org.uk>
References: <20160704131651.1083630-1-arnd@arndb.de>
 <20160704132230.GD6247@sirena.org.uk>
 <6436978.7TJhubtDTK@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="11IAkegDWp8TRrA/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6436978.7TJhubtDTK@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, kernel@stlinux.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: alsa-devel@alsa-project.org


--11IAkegDWp8TRrA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 03:36:57PM +0200, Arnd Bergmann wrote:
> On Monday, July 4, 2016 3:22:30 PM CEST Mark Brown wrote:

> > I sent a pull request for the API change to the DRM people which might
> > be easier given that it's a single commit topic branch rather than the
> > whole of DRM.

> Agreed, that is probably the best way forward. Does your pull request
> also contain an equivalent of my two patches?

No, I just sent a pull request for the API change - I don't have the new
patches in my tree.

--11IAkegDWp8TRrA/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXembBAAoJECTWi3JdVIfQrJMH/iCzkrn0UMtLOAuD2/uqNCOR
B2WGzbFO1RU5uO2RwJtU/fbsB1WX8We2idms1jxhe4BpjEY0HNjCzJ5MuAA/FvqD
XwxOLnhcRQC26jHQeH36Mjcy2wStkTdQ00i0StOjrNSjQ97isQ+wvWcGnBCdccUX
G8IIvvItslkznFXtDp4Jvhp2dSHqlAO8vwz0K8rplhQuiV+RBd+4upeFDegtwJOy
poWr2zRaYx2mUY4RyQmU/DEvzAlCWp4+RLfm2Tb++mBElLNoXuCrImARYQPTDI39
8vUSZXb57ZtqkqId2N7AuL5MYqd4CpRSGykczFxpQGTpFnSG1p7nVn1jpTGuruU=
=GGEG
-----END PGP SIGNATURE-----

--11IAkegDWp8TRrA/--
