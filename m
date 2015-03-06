From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: Intel: add function to load
	firmware image
Date: Fri, 6 Mar 2015 11:36:21 +0000
Message-ID: <20150306113621.GL21293@sirena.org.uk>
References: <1425281778-17513-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9189243196727986056=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 774FE265D85
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 12:36:28 +0100 (CET)
In-Reply-To: <1425281778-17513-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9189243196727986056==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7LZL2/UTTh9BROn2"
Content-Disposition: inline


--7LZL2/UTTh9BROn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 03:36:11PM +0800, han.lu@intel.com wrote:
> From: "Lu, Han" <han.lu@intel.com>
>=20
> Add a general method to load firmware image, and apply to base firmware
> image loading. With the method, the driver will support loading multiple
> different modules in order to support different features.

This doesn't apply against current code, please check and resend.

--7LZL2/UTTh9BROn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+ZE0AAoJECTWi3JdVIfQKl0H/0gA3GxOX6WA0OHXyUv+sulE
TzN1MKIR0eSCg2dPvUpAeTqU0BIJXh6odnkzlZuZrTkWGANPuSGLqWuunE3mNMwu
Smm61/V2ZU7krdtP32Crol7yfNFcnCsRzXbq2d6q7QATFT8w7VHs6Gugm3HS/LPu
jhRlk/5U9/I+1uHri3Z2dY473WGGAItlgJLIDvw937+1AYrBe1qMVMBHXyBqR9Vv
HBQWDYSuoWrgcDMSFsvO2yyPZ+THLD7oIY9/JLhfgV4NyFzoxIiLX8q5FhweETK8
s1uWwfZ+26h0p9CGA0IEGX3nZd2z2pOERI7QmEwcXmGQzcRJAer5R6+VpexMFjA=
=ZLbv
-----END PGP SIGNATURE-----

--7LZL2/UTTh9BROn2--

--===============9189243196727986056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9189243196727986056==--
