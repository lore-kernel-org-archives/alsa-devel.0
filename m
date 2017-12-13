From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename
 from header and switch to SPDX
Date: Wed, 13 Dec 2017 16:01:40 +0000
Message-ID: <20171213160140.GN6416@sirena.org.uk>
References: <20171212224311.24045-1-afd@ti.com>
 <1513131575.3036.67.camel@perches.com>
 <3ff091f8-1366-ab38-dd7b-2633e6f3dd80@ti.com>
 <aa585d9a-a68c-95a1-b156-26f65aa1b890@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1028433631493034717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B46EA266B67
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 17:01:43 +0100 (CET)
In-Reply-To: <aa585d9a-a68c-95a1-b156-26f65aa1b890@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1028433631493034717==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Content-Disposition: inline


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 09:50:34AM -0600, Andrew F. Davis wrote:
> On 12/13/2017 09:44 AM, Andrew F. Davis wrote:

> > By the way, do you like these spdx update patch? Or would you rather I
> > drop this one and wait to let some script do it for the whole subsystem?

> This last question was directed at Mark btw :)

> Actually, I'll just drop the spdx change from this patch, no reason to
> do these manually.

It's fine for me, probably nicer if anything since it avoids issues like
mixing C and C++ comments in an ugly fashion.

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxTuMACgkQJNaLcl1U
h9AOFwf/TM6dvpbbvAWb67iaab3ydyhrnBY9CWKQNjI+dtc6duPQnCAu5BO9noWq
+AyZzAUmQPl6V23urVDmBN6sNz1myDWW2tckD+4bzKOpC79kwhW05iTICqw3iowz
IOi0em4gc12EwUbQCuLs44jF0McfR8Uqat1EH5Jr6zZHL0N3/cyBzYL4Nv0UmhDQ
3mvDPi/emwTyqpvcaj/fqg81fDpEcqDP82FWimPtiJNc29/1SrHluqqPCwc3FNRz
bn4+/neJkX4dYalfOGupEkbOgfHaNFSggjYGNUkaAGPC1AbH//o8BHFMbN45bln5
8S2BVPfqWoobA/H8UFkcaRPz3d+p3g==
=fOnV
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--

--===============1028433631493034717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1028433631493034717==--
