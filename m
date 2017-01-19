From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] DRM: add help to get ELD speaker allocation
Date: Thu, 19 Jan 2017 10:29:01 +0000
Message-ID: <20170119102901.h35ynrcztf5z7vb3@sirena.org.uk>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <1483458772-13658-2-git-send-email-arnaud.pouliquen@st.com>
 <20170117191902.zugqcnb4osxmcgaj@sirena.org.uk>
 <87bmv5wheq.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1721630155=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87bmv5wheq.fsf@eliezer.anholt.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Eric Anholt <eric@anholt.net>
Cc: alsa-devel@alsa-project.org, Jani Nikula <jani.nikula@intel.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1721630155==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gt6bucglh7jnb4lz"
Content-Disposition: inline


--gt6bucglh7jnb4lz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2017 at 07:38:53AM +1100, Eric Anholt wrote:
> Mark Brown <broonie@kernel.org> writes:

> > You don't appear to have sent this to any of the DRM maintainers - it
> > does need review from them.

> It was sent to dri-devel.  That's us.  And the patch already has a r-b
> From DRM on it.

I see.  For most subsystems you need to actually copy a human to make
sure that things are seen - just the list isn't enough.  In terms of it
being reviewed one of the problems with DRM not listing the reviwers in
the MAINTAINERS file or anything is that it's very hard for anyone to
tell if something is considered a good enough review or if it's just a
review from someone who happens to contribute to DRM sometimes.

--gt6bucglh7jnb4lz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliAlOgACgkQJNaLcl1U
h9DPlAf/WWn/5yG8E2gFEiHY7s343gXlVLOc8CZ3/sIi1VwTTwALWWg5EDWtYC+O
GDWmzD7da2iwXviEZ3pSc2kSduwqnYtRtyAVDJp+3FwYVzz9qa8HyWxLmesG0K8p
WZV+iJRC0pMYdK9r/LAJAg4q7GGvjHqXitlvJxbAQa0AJ77EPLK6lCW4FVRTORWt
HNPMb7qHc+hy6WiBRHpr4a6S8Q0MrYmldzl50jUSlmQP8JdVqBeJ/zVJTxk74X/E
dMyKRpnbA92Q67COuoQyz3XsXbNV01tYO6qpJLOuvguXWNLwNHjjvMKD0Yz6f0r7
loYXs+DC9tp/CT/0OFoiADqKAO2d1Q==
=jJkG
-----END PGP SIGNATURE-----

--gt6bucglh7jnb4lz--

--===============1721630155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1721630155==--
