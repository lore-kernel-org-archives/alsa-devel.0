From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: ssm2602: switch to SPDX
	identifier
Date: Wed, 6 Feb 2019 15:32:44 +0000
Message-ID: <20190206153244.GB17630@sirena.org.uk>
References: <20190206152947.2789-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6570600096311820732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 79FAE267466
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 16:32:46 +0100 (CET)
In-Reply-To: <20190206152947.2789-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============6570600096311820732==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 06, 2019 at 04:29:46PM +0100, Marco Felsch wrote:

> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * File:         sound/soc/codecs/ssm2602.c
>   * Author:       Cliff Cai <Cliff.Cai@analog.com>

Please convert the entire comment to C++ style so it looks more
intentional and is consistent with other ASoC stuff.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxa/hwACgkQJNaLcl1U
h9As/wf+N73Y6QrY4vnoOWH/HOHZguMae83q2Khci/gYn1QIVJylVKpvam03F6v/
AwBAFjEDcZUDOLzxO7hpSEe4bNdgv5/wcO3QrHNzPy8ltZqiaiB8ERRdiqf9xFPo
LKmsZWUSG7hKIjgJeDMP6BzSri3GQqPKr8llMgvX8o0qVi1gfXv05jW/8+mFF/Jz
1w6cVYP4mwOiTcg/+d1Kp+KVjaSd/eYqtLHkpqnh6Cs7wwHWVJcrMmpHMg7UJxr3
WnsFxKeBDhh58/P+B3kFTlalpRPGaDaiEthcT4ansehopXa9bTfzq6OeYGIdQDjx
8XFd/x6HnKF+vj1a1c9hjxwshjDKaw==
=WrLU
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============6570600096311820732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6570600096311820732==--
