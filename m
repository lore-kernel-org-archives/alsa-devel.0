From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ALSA: pcm: add SNDRV_PCM_FORMAT_{S,
 U}20" to the asoc tree
Date: Thu, 30 Nov 2017 10:41:59 +0000
Message-ID: <20171130104159.r2zgwblievcyfpya@sirena.org.uk>
References: <3a279ea2-8098-d5a4-a53e-b0e3585fa9bf@maciej.szmigiero.name>
 <E1eK7aT-0004iV-CY@debutante> <s5hmv34ixtg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5016317532407380294=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BF82E26698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 11:42:07 +0100 (CET)
In-Reply-To: <s5hmv34ixtg.wl-tiwai@suse.de>
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============5016317532407380294==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="amgpeomm6p7ycbrs"
Content-Disposition: inline


--amgpeomm6p7ycbrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 10:23:23PM +0100, Takashi Iwai wrote:

> Mark, I already took this into my tree, as it's a change in ALSA core
> stuff.  As mentioned in another mail, the branch was exposed to
> topic/pcm-20bit branch, so that you can pull cleanly.

That's what this is reporting - the result of my pull.  My script
reports all new patches I push rather than things I apply, I pull
infrequently enough I didn't need to fix it yet.

--amgpeomm6p7ycbrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlof4HYACgkQJNaLcl1U
h9C8dwf/c225aQcNBAPeEDVGx59FZBrBkNJeUG8Gqt8mDKvCyQ8NkBXXZxLi2URn
BexsCUBUBqq/0HnaI+EpiZZyR/Uk0e+lxAJ6E7QTnLAfuTiMPuU5sp0n5Lrj5e/C
UNTBwZEPut4+VkQMWvd5jjSrwcmDK2hf9xDhfnmhFIgC8PAuPBFm0qP1UvJWHhls
VNKSYh0Awl9ZDJ5n9R4Ufxve7/3faCEq6uTWq8BHA2VQva3KOGODhpCD+bBCNBzf
j4EHzUyx08rfSNXy1muAMnz92mbJ/wl5yLcUx2OaZzu5w65tWHh2UIL/Hh2FtTwl
9wkajHmo4MudzuK+oBejRaLu1JjNJA==
=tO2u
-----END PGP SIGNATURE-----

--amgpeomm6p7ycbrs--

--===============5016317532407380294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5016317532407380294==--
