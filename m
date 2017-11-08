From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] FIXUP: FROMLIST: ASoC: amd: Report accurate hw_ptr
 during dma
Date: Wed, 8 Nov 2017 18:00:15 +0000
Message-ID: <20171108180015.3uspwemnuiljbtux@sirena.co.uk>
References: <20171108172404.19118-1-alexander.deucher@amd.com>
 <20171108172404.19118-4-alexander.deucher@amd.com>
 <CABXOdTdgxOFJb0B7VRivFaf1ihfKQWiyXRX9hFnKetTanmjd5w@mail.gmail.com>
 <CADnq5_O4fm6f1n42Wb8=b2-5UeoO3VLTOPKnCenFSRT2xGLA_A@mail.gmail.com>
 <CADnq5_N6hKegjtKmeftewvh1u4g_2zVMtm47JCL9m9OchpysBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0554339484=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_N6hKegjtKmeftewvh1u4g_2zVMtm47JCL9m9OchpysBQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Guenter Roeck <groeck@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0554339484==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ahfazquvb2o5xoz"
Content-Disposition: inline


--3ahfazquvb2o5xoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 12:45:16PM -0500, Alex Deucher wrote:
> On Wed, Nov 8, 2017 at 12:42 PM, Alex Deucher <alexdeucher@gmail.com> wrote:

> > I'm not familiar with which are chromium specific (TEST, BUG, FIXUP,
> > FROMLIST I guess?). The info seems useful to have in the bug, but I
> > can respin if it's a big deal.

> s/bug/commit message/

All of those are Chrome specific.  If in doubt look at what other people
are using.

--3ahfazquvb2o5xoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDRi8ACgkQJNaLcl1U
h9Ah6gf/VEo44eqIRzUGHEj61vbMbhYqdBbpXylr/wUw4LkQ1lBNH/IwSpPPUm1K
fv8GXrRGMmkA9X28NezjcWhE7eLj8BXCqLRUU441NcYAg1I4Ee4CdjzkdzLktqhI
nzWR4ocrdE1GHDJxjYY29sgGN8PvDuQfhN7FjfItRAoQZXvT1MK94JPSgnuI3BCI
XF2zPV/FrERjNoXn/F3DBOMuSuQeDXMNO8Bs/7oKrw2dx4uOTgxxfyUT3+Q4RaUp
ifGTRHASOjgm+JdSjvsasU2JTFHX18VuzjhpW10Y01XSzoABK8FK99wGsg+a4b7x
rIlBnW5BH6udI95JAAVb7N9xcuVPHw==
=ElLJ
-----END PGP SIGNATURE-----

--3ahfazquvb2o5xoz--

--===============0554339484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0554339484==--
