From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rt5677: remove superfluous set" to
	the asoc tree
Date: Mon, 22 Jul 2019 16:22:54 +0100
Message-ID: <20190722152254.GF4756@sirena.org.uk>
References: <20190711002838.35363-1-cujomalainey@chromium.org>
 <20190722122208.F2A0427429D9@ypsilon.sirena.org.uk>
 <CAOReqxjuZW8SP2JaReQNVej5=8qx7J_JfHPUAE9UhhME6_yVrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0904676439110807891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3198F800F5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 17:25:06 +0200 (CEST)
In-Reply-To: <CAOReqxjuZW8SP2JaReQNVej5=8qx7J_JfHPUAE9UhhME6_yVrg@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@google.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0904676439110807891==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2019 at 07:16:28AM -0600, Curtis Malainey wrote:

> Can you please remove this patch? I made an error in my testing and
> the patch should not be applied.

As covered in the mail you're replying to:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

So send a revert explaining what the problem is.

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl011M0ACgkQJNaLcl1U
h9BA/gf9EuLkt2SvEPYRSRoZj/gqyKN4Q9AZkfO1G5QS6Bnt5Wj1NoNyrFx0Ujnj
0izvRVLg6QoqCrBXxG+cvBZIysjkCPfFLjmVkVSHS2xmc/VH3w3Da2ddgnHAZaTm
TYMUk9VwZLohyU40eG5+62ZQqyQNsC3THAUZ/JSFvKs5a7qmUQ7BNgIz8iX5lhiD
Pm4A2v6NeTCjaQoK4+NhJq702tJutQYMbNXlLeGZnAq1y9BCuT1+hcfuD47vw7Jj
5Ra/dSnzw5z5qsjGTliGy8rgp8HV+RoN+B7G/ObUft4ggVZKE3jL4u6+GFlIbZuD
OiUuXe+B+ir7sQCqpHEE/ADFyxz3Zw==
=0s6k
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--

--===============0904676439110807891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0904676439110807891==--
