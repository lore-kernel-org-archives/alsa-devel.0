From: Mark Brown <broonie@kernel.org>
Subject: Re: [v5 2/2] dt: bindings: sound: Add bindings file
	for CS35L35
Date: Mon, 6 Mar 2017 11:22:56 +0100
Message-ID: <20170306102256.hisrl6o55vj22fe6@sirena.org.uk>
References: <1488550172-32299-1-git-send-email-brian.austin@cirrus.com>
 <d1e85503-c400-45f6-aa89-a24dd16cb44a@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5009467364020186733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1044A261740
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:23:08 +0100 (CET)
In-Reply-To: <d1e85503-c400-45f6-aa89-a24dd16cb44a@EX3.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5009467364020186733==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ehvn7yol7aykndua"
Content-Disposition: inline


--ehvn7yol7aykndua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 08:09:32AM -0600, Brian Austin wrote:
> Add bindings documentation for CS35L35 Amplifier
>=20
> Changes for v5
> Make IPeak and BST parameters consistent with
> previous devices that have similar properties

Please put inter-version changelogs after the --- as covered in
SubmittingPatches.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--ehvn7yol7aykndua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli9OH8ACgkQJNaLcl1U
h9DnSAf+LjfF1h+yuEXl2O76DmUBM01wHKgx9ae/sqqq5btCcYCpz3uT3ifKzt0E
84lic1mK/eyCH4rfCgJIGyGmc9JL40HxNDluPzCSsvtG1EULFRA/PFLWlN/6nXYs
mn8bsxREUU4moPyv7CZYYeraoIgDYxox81i1ZxK5LnSzbevF/5WVjPCr5uH/hiSX
JnP6bJT5fzBJVsQd0oKdjs3iOjVylJGa3kobNIGmhpashsRHYq0A6jISf6IW0Q52
89gUbQck5YS619ZQXSdeL8zI3t3bIT04h8ODiyZQsCNLFUGgyD0G4djgonNVR4vK
x9I8xw8P932rLxONNDM5mivVsqTnqQ==
=BjfZ
-----END PGP SIGNATURE-----

--ehvn7yol7aykndua--

--===============5009467364020186733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5009467364020186733==--
