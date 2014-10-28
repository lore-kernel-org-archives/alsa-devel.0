From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: es8328-i2c: Fix i2c_device_id name
 field in es8328_id
Date: Tue, 28 Oct 2014 10:48:12 +0000
Message-ID: <20141028104812.GQ18557@sirena.org.uk>
References: <1414457977.5091.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7838192872110803630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F695260438
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 11:48:37 +0100 (CET)
In-Reply-To: <1414457977.5091.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Sean Cross <xobs@kosagi.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7838192872110803630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWAGJYLEitsbNOt2"
Content-Disposition: inline


--pWAGJYLEitsbNOt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 08:59:37AM +0800, Axel Lin wrote:
> The convention for i2c_device_id name does not need to have company prefix.

Applied, thanks.

--pWAGJYLEitsbNOt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT3RrAAoJECTWi3JdVIfQys0H/2fGHVOYKrTR2Dvxq7I0835C
7j8iWkt4aEWBQnMa2mMPxRllA/vsJgE0XWPx8Kp2mb4UYT+XfhRvSvrEypaWYFGk
3+k1LJGsulpygqXtGVvdqhNuir0CV0MZg6E+EDcO7Jd2K5qBBqkww/2q7GN2qZwW
GicI9IV/G0lKjPQSxm93r+WybFw5iFZKTaTroQKzqn/oleGPa4V+LoQqiqoe3IRf
rNQ2YEqtfe4KNiVpb7h8uAO1TDHjT9V24xwVNmWfBOJ5iAngS7jWTF5PdLdLQBrW
+f9/pdKv/VjkGxQGZIj9jAtNZmbMYZoKoayOV/IQmgm0q097tizVX12i65zvFt4=
=Njbl
-----END PGP SIGNATURE-----

--pWAGJYLEitsbNOt2--

--===============7838192872110803630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7838192872110803630==--
