From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6 v3] Add ASoC support for AMD Stoney APUs
Date: Wed, 30 Aug 2017 22:10:03 +0100
Message-ID: <20170830211003.3qyilnuylzwjeium@sirena.org.uk>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <CADnq5_NV0wmstpos9Hqc_dbTAOOOUozb=B_-6vd1PhD=zCMLhQ@mail.gmail.com>
 <20170830151913.6vknazyhh4se5524@sirena.org.uk>
 <87h8wo28o1.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6621469559267433925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DDF38267217
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 23:10:08 +0200 (CEST)
In-Reply-To: <87h8wo28o1.fsf@anholt.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Anholt <eric@anholt.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6621469559267433925==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kdga3jgkexuzuwxn"
Content-Disposition: inline


--kdga3jgkexuzuwxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 30, 2017 at 11:49:02AM -0700, Eric Anholt wrote:
> Mark Brown <broonie@kernel.org> writes:

> > You need to get someone from the DRM side to pay attention to the second
> > patch and you need to stop resending the first patch since as has been
> > pointed out a few times now you need to stop sending the first patch
> > which is already in Linus' tree.

> Alex *is* from the DRM side and has reviewed that patch.

*sigh*  Right, OK in that case it would have been really helpful to see
either some mention of this either in text or via a pull request (which
would show the patch having been applied).  It's difficult to keep track
of all the different people who might be DRM maintainers especially when
there's process things like the resend of the patch from Linus' tree
going on.

--kdga3jgkexuzuwxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmnKaoACgkQJNaLcl1U
h9B1mAf+Mq9Y+4OevcPeaMP3ivrgW3bF1JvxUzFR7eaNjjfOJlf/3HLL8UZ8SCLi
3eRKAsxC1inzfq7HbaJe+471BnPkhxWKUMwRgRvaLKbTAXN+S+ShSDBkKHKekC3W
QgZ0fj3WIXBq0aThjfweSZjPMAixBRCjBjPDZbxM8CVRMIK5eArh9UAURWRHc/tT
qzYPjYOM2MOeOPxLdOAOsRjOotA6cRJGO+1dK0FNeEpTU+Y6iBuB5SlJot3EiOw8
w91YcSl2LxxCgyhcOEacPrPA2mEogZ9+HPW8qOEPugTLvdFXRsG4+UlOhw6deA/W
n1C6clLCfGNMGy2MyvpoA8Z4jale0A==
=rgvt
-----END PGP SIGNATURE-----

--kdga3jgkexuzuwxn--

--===============6621469559267433925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6621469559267433925==--
