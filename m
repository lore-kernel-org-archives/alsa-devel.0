From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: update stream only on stream
	IPC msgs
Date: Fri, 1 Aug 2014 19:13:07 +0100
Message-ID: <20140801181307.GH30458@sirena.org.uk>
References: <1406905843-31223-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8794183902247071540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB902265696
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 20:14:25 +0200 (CEST)
In-Reply-To: <1406905843-31223-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, pawel.piskorski@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8794183902247071540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQKdfr6GvE2xHbL0"
Content-Disposition: inline


--uQKdfr6GvE2xHbL0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 11:10:43PM +0800, Jie Yang wrote:
> From: Pawe=C5=82 Piskorski <pawel.piskorski@intel.com>
>=20
> Only update the stream when the IPC message type matches stream type.

Applied, thanks.

--uQKdfr6GvE2xHbL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT29iwAAoJELSic+t+oim9mf8P/0pjHnADifN4jjn2LIIBV3/F
k/LOuGTCS7aWyGV4PvYtN1DyI9aSctHAZ5FwT4OXtcdkC35y7YXPnoIBIjI5qM4G
tvyfDCzCpIOVTWwBUvLyU41LzDQkKWHfdC85ZqCGjudJUtkJOS7SacewR73e8Vqs
9z484saPDHcJpTQBMUnQadLgPn7nyxh3tl/N3/iux4Abg7DOcwWh4u2p+XTrr9IK
Ta9O/O901J9PfteWT9sR0KtzaihdtqEqbhYf2PL0vfmM/8ah5db5BBYw8tbeM0k3
xKt8OKBx1gAqq+o7fHnFh5hvlMGyvTMTOoOlYk7nTj5Urpbc4ZXMVuCv2TT5kIwz
hT5q9KDeZIkhCtcDrM9whf95eKWwbI0CCV91ggeX/3dA+wMRdM95vfe+JFHHI1if
/tiPgRqFbJGaFpkQwFVeWYNNiXf+JagyZXc2qCnFSC9acAr6JDTpJ1kOB8HIRYW4
/P8EOmUMr1XaQ8uV7HxribLl6gZJl476WTEXgB+yoQfpIw9HDSv7hjq1fQ/ajbis
vD6+TzirDYEFNybtbbZ3cUvaPKXpwHlpYjqAe/w38tuldFb+stJNd/Q2nDZh1LTz
N6GNu1YHPdHXNzjwE9nL09shDNoLkPdoygaySkFxHGjlaP9/sbjypdeI3rbYZg9X
4mame8xhZf362FP1W7bg
=NrB2
-----END PGP SIGNATURE-----

--uQKdfr6GvE2xHbL0--

--===============8794183902247071540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8794183902247071540==--
