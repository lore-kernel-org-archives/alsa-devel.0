From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: TSCS42xx: Remove
 Playback/Capture in names
Date: Mon, 18 Jun 2018 12:31:54 +0100
Message-ID: <20180618113154.GC6928@sirena.org.uk>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
 <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4656627134611528635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 186582673C7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:31:56 +0200 (CEST)
In-Reply-To: <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4656627134611528635==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 03:46:28PM -0500, Steven Eckhoff wrote:
> These aren't needed and some userspace apps don't work consistently with
> them.
>=20
> Remove Playback/Capture from control names

Really?  They're part of the spec so it indicates that the apps have a
problem...

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnmCkACgkQJNaLcl1U
h9AtMgf/db+DeLAlSJqM/obcQty/4KCFpwgIxy9w7jWqIyF37Cw9IzMII3WHrON2
SmXGsFvc/2CdDLMnqnWxgLOJpyZZGtQngc0F3OfhecoffUzLhF2ZzB9EgzJaWzbq
Ooik8l5WpaXYt+qiECh8m3z6vZFvOKHkq6BClH+UXgGNICYnoI2w3+ncfpQuQ3tx
CWDqx6Fq8fhmxdgM5Ovvnq3veSIseHZfkZLd3cQhGHNSIjBtGQw8cbeMu11VZwFL
LknamhHW99ROpck4uVIpItNi/4pgfZXvyKhbnWCLa8VRbm+xX7/lyEjyhfeUGo7y
axmcx7YPh7G72cZG5r+Mf7V7d4MMvA==
=cdsd
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============4656627134611528635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4656627134611528635==--
