From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4 1/3] DRM: add help to get ELD speaker allocation
Date: Wed, 18 Jan 2017 07:38:53 +1100
Message-ID: <87bmv5wheq.fsf@eliezer.anholt.net>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <1483458772-13658-2-git-send-email-arnaud.pouliquen@st.com>
 <20170117191902.zugqcnb4osxmcgaj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1907636008=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170117191902.zugqcnb4osxmcgaj@sirena.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jani Nikula <jani.nikula@intel.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

--===============1907636008==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> writes:

> [ Unknown signature status ]
> On Tue, Jan 03, 2017 at 04:52:50PM +0100, Arnaud Pouliquen wrote:
>> Add helper to allow users to retrieve the speaker allocations without
>> knowledge of the ELD structure.
>
> You don't appear to have sent this to any of the DRM maintainers - it
> does need review from them.

It was sent to dri-devel.  That's us.  And the patch already has a r-b
From=20DRM on it.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlh+gN0ACgkQtdYpNtH8
nujrGQ//bnFAgc7y0qf7004kLM6EJRnVhC9wher87A0KhhgkhmRUg4xRa44QStiF
FWrbl9VvpyK/LLh00KVrD1ZodnCRods8wj8xIt+CF9y1e3uHyRGmBd55CtutMYh4
fY5pdt5ufsF6Tmbuk/YYDJR3+TVMSp+QS9hbsQyinv4X1LSsAAooYMtBHJAkHPes
GXInLDi+PWCsQp04kW3OoGcmr5tsUWD5rU8eTrRByPf8Gkln+t1JPnco32xbFBmW
TTm01mtFVo8J+77enYku1MA2at3mUSvVFsYkQvwgSR8up6yep4Zwe5wdJ+1roSyR
yrbebfMOPq8Tc0c8mH3EQZ1cEwnOhPKBqVtK0i4xmPYdDr9blmC9jiutS32ORg9j
sFWhw9rvIkzdCqjuJFBP7Ai7ADNv4P2Skq5Ckq+fJtY5Sht8mfXJTwDTmRElECVr
izw74hWBoSMRtYgud/SE2IiuubCN0HONc/JaLbu87W8yQA3h5prmVwCllH8SLTH8
u9Jh9XsTmTrJ3aA2Ifr1m6Lvt0ALIO0kydf1IBgL66QJDK+w/P8vrhNFSvf430n3
4d3Y0zg61rEZdGyWu7s4XFg2EYlptXJBOsIqYCSjH1/3GmgisB4gUN6h1RvBQFdy
O7et5xu7G8fb5RJdSiTO0tAltgrZJNItnDV6OzrAg0IAhtSRUcw=
=+0Eg
-----END PGP SIGNATURE-----
--=-=-=--

--===============1907636008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1907636008==--
