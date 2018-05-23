From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 14:56:09 +0100
Message-ID: <20180523135609.GK4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5910659268855792181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BDE57267265
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:56:17 +0200 (CEST)
In-Reply-To: <s5hmuwqpjdd.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Guenter Roeck <groeck@google.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============5910659268855792181==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJAclU0AInkryoed"
Content-Disposition: inline


--IJAclU0AInkryoed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 03:54:54PM +0200, Takashi Iwai wrote:

> And I'm wondering whether we should move these definitions to uapi
> headers.

Yes, we should.

--IJAclU0AInkryoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFcvgACgkQJNaLcl1U
h9DoKAf/USPmjJ56h/dkk2Lo8ldpcGetP2ZQMIa3AcdlOdduDJK/gi4NSf+cF5eo
n0H1IdBK9pwF2PVjCtGnXm+DivEvhD4IH6nKG0e94OKSAvP+S2vqT3LJSIX5+h59
G7D17OtHQABd4VOMCGIGMx1PZRvKO9Kui3YUWr+uCMUreNlAvJ+W+bnmO10l3oWm
NoPQDAWPkpDinukGVO3fZueTF/QI2o4lowMf0UgPdshsXNDv3xk4VpH7l+nMG4H3
pWRQF8nnqVz++h0Ckwns7Zs2mct8w9CICK6Fu4APfU4uhCCPBEzQACE1+39na6+e
lJd6E5HsJhDqOt2sGKQy4UrsTZ4J1w==
=dMFf
-----END PGP SIGNATURE-----

--IJAclU0AInkryoed--

--===============5910659268855792181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5910659268855792181==--
