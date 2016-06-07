From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/10] ASoC: Intel: Skylake: Set the pipe
 state to paused when paused
Date: Tue, 7 Jun 2016 13:56:21 +0100
Message-ID: <20160607125621.GW7510@sirena.org.uk>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
 <1464958783-19344-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8081406137606955568=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A7932606D6
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 14:56:29 +0200 (CEST)
In-Reply-To: <1464958783-19344-3-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8081406137606955568==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cf1qy2gtPj5yoBMh"
Content-Disposition: inline


--Cf1qy2gtPj5yoBMh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2016 at 06:29:35PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> When pipe is stopped/Paused, set the pipe state to paused instead
> of created.

because...

--Cf1qy2gtPj5yoBMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVsR0AAoJECTWi3JdVIfQ6i0H/0uTNnHxSrXH+GtmfBobBE3A
eS6QF6YCUXhnVtQMQBxXZ3k95iiSbUZqOHJr+12vzaxjUblvGu717kd6Cxzqt+lk
fYHLphIZexJTi+0CqSSVlZ5R3XzAZlEAbExSA/pq3OGQV3gWiOTUeQQmDPdiiSLH
78ieYVecJuhCCdf+pQahiioi4i/4x4kmS8M1Er3oywD5M23j4N3KXkAt7WH/Q/QU
OIQ4UR4Pqh8LM4U+Jyr1wnGSuwsAhxZhczT4jGXpK6fHIUdQQuiqx6WXf0IZlFh0
c8cn8N0EboIxOSbV5MQfmmfkFd1WabzCHkU1sbYxwJXWmrJEqmrYMlTMD/GRUMA=
=kiLx
-----END PGP SIGNATURE-----

--Cf1qy2gtPj5yoBMh--

--===============8081406137606955568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8081406137606955568==--
