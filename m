From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codec: use enable pin to control
 dmic start and stop
Date: Wed, 16 Aug 2017 15:50:05 +0100
Message-ID: <20170816145005.t425cvny6uzdchd7@sirena.org.uk>
References: <1502436689-21123-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4801023036710724124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FF5E266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 16:50:44 +0200 (CEST)
In-Reply-To: <1502436689-21123-1-git-send-email-hl@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lin Huang <hl@rock-chips.com>
Cc: alsa-devel@alsa-project.org, dianders@chromium.org, lgirdwood@gmail.com, arnaud.pouliquen@st.com, briannorris@chromium.org, dgreif@chromium.org, tiwai@suse.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4801023036710724124==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="frdhubpke34qum3c"
Content-Disposition: inline


--frdhubpke34qum3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2017 at 03:31:28PM +0800, Lin Huang wrote:
> on some board use enable pin to control dmic start and stop,
> so add this feature in dmic driver.

This doens't apply against current code, please check and resend.

--frdhubpke34qum3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmUW5kACgkQJNaLcl1U
h9AGfgf7BxZiZ+k3yHfGcvGM0moN+MVFD6krcbiI+WZCLUtGeJaQDd6IFwQKhIHH
TvF7PzYt2QhxOgzn0w7Ik8oMszB8hW12InvSK6CfCVrOXwGdjv9TcET5fHN4xH6x
01IQxwwXfUz6pJfK0PeoEGhSsD8xP3/Tu8KmrxzU4AHz/lLE+DJ1VJoFC7d8PWg6
l/zDhqOkz9qO4tAOnvIhmxQBaKwvgEuIKk0jZaLJ77mS4HvsoNeTCyJLlhAwBVoD
E0MLO/SLFFa7LjXVio39zghXdYHBj870ADk7r86ZKjdbr4PCU2y0txQ0Tlx73gyK
KCtOiOdQTf8PSES7/YV5FeTgGOBqyw==
=YAh9
-----END PGP SIGNATURE-----

--frdhubpke34qum3c--

--===============4801023036710724124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4801023036710724124==--
