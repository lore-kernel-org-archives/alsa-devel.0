From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: tlv320aic31xx: Add headphone/headset
 detection
Date: Mon, 1 Apr 2019 14:57:52 +0700
Message-ID: <20190401075752.GN2059@sirena.org.uk>
References: <20190329154704.4922-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329154704.4922-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--JLiXfqD9/Kt1b+Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2019 at 10:47:03AM -0500, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.

This doesn't apply against current code, please check and resend.

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhxH8ACgkQJNaLcl1U
h9C8ZAf/Yxn+/gAw6NllkxZh49h6GowFWW6/Qq16wkCb+1bPpkCAGn5uH/ge6xTo
bTbz8j5zoW9QbvLN2LXVyzmW3gmXTcKzlKS0jogm/JUzbOf/RAbsdfUstmO6FF2Y
Ewj93DcuKx8DscRxx/rbQbzDZmwj3UPNaWlgz56/at3ieOa72Io8eXpZJy2oaWKa
ZBx1es7kgAg5FOdojs0oJMlB/xTykMe+kpZ6JdP0oVElkRhDxyOoByUeZzSgTgUG
1MinmsbQmsnIxy1MNf+o/NaCpG31smi2i28ErXUNTMl0E11L+JRdgmIEEx5CfJDK
COeZ5EkGZ6h2Zfp1gQuxr24QQvm7uA==
=mAL8
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--
