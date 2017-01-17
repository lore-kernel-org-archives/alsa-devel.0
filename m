From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] DRM: add help to get ELD speaker allocation
Date: Tue, 17 Jan 2017 19:19:02 +0000
Message-ID: <20170117191902.zugqcnb4osxmcgaj@sirena.org.uk>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <1483458772-13658-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1210722427=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1483458772-13658-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============1210722427==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7bumbfcs752nywoi"
Content-Disposition: inline


--7bumbfcs752nywoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2017 at 04:52:50PM +0100, Arnaud Pouliquen wrote:
> Add helper to allow users to retrieve the speaker allocations without
> knowledge of the ELD structure.

You don't appear to have sent this to any of the DRM maintainers - it
does need review from them.

--7bumbfcs752nywoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+biYACgkQJNaLcl1U
h9B0gAf/dgASBWQ/zba3uAVk07GQgQ2bCmRikMmj8Cgwys8BWkMjUZepYESneMbN
Ne36S3xw/UcqqDBY5KqRnWrmUgCp5qKW2lD7xy1xQLD8KB7a6nEVEZsB5JATWdXD
POTP6OKaajzFp3Pe8QndyICsqEgSi4tGWsl5oeCy0BtP7Y/ypYchbD3vfkimMYn6
LThcSiahkAMmnYxpOtPfRNckHu8Pm4EiHafb0yndb1/OU1YPV/5CCznFxmi6ratZ
Aj542vaGSsfM8nIiTCynvrIo69EjeRFAaBYwZy+2wmqULIQ03PXJXTbuETSzqOOC
U80MDdJuYRzvDuU59uOjLp7RFIE5DQ==
=+odM
-----END PGP SIGNATURE-----

--7bumbfcs752nywoi--

--===============1210722427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1210722427==--
