From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Fri, 1 Jun 2018 11:25:06 +0100
Message-ID: <20180601102506.GB8677@sirena.org.uk>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5679412912372968554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C742676DD
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 12:25:31 +0200 (CEST)
In-Reply-To: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5679412912372968554==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 12:49:21PM -0700, Guenter Roeck wrote:
> From: Guenter Roeck <groeck@chromium.org>
>=20
> Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
> DAI") introduced sound topology files version 5. Initially, this
> change made the topology code incompatible with v4 topology files.

No review on these from anyone at Intel?

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsRHwEACgkQJNaLcl1U
h9DI1QgAgaKFW5DKIHLNWriVAG2tJQsBwzOuzf5pMkVO/ae2hZuz2tf/+dF74f8G
4Zs/u+9xzVlxPGoisNVkgMUyLg6lQdmu7nRR5s475vN/3M0nIxaNCJF9rM1v3bXT
IUjcDS3F14lKt4f6Tz9Q6EWo/RESoFmUalCOlpKR0tLu+zcemumfV08jDHhQMP44
c4auS5T++wQdHzwSff2vhmfhzOkcERP9V2JGXOfazo/j3HO4ANBicnnPAL92SS4I
VXJs5MsLzIsC+nfLgdLzpZ7QqqhY1SJ/h/cpOcu2XNTp3HISevTH3KSGuLU2tJBB
dwcvyjwSAQEKYKjNzEnHM3wHKRhhYA==
=1ZMc
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============5679412912372968554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5679412912372968554==--
