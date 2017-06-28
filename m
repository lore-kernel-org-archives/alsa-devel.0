From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm: adv7511_audio: Add .get_dai_id callback to map port
 number to dai id
Date: Wed, 28 Jun 2017 19:50:31 +0100
Message-ID: <20170628185031.7qgc27xofbu7k7ij@sirena.org.uk>
References: <1497391189-9301-1-git-send-email-john.stultz@linaro.org>
 <20170614000543.l636aslxdt5xd32f@sirena.org.uk>
 <CALAqxLUqt-pyRimWjJL6QYnvX17wSjbkdy_Vsynbhrf8bfgfnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332140327=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CALAqxLUqt-pyRimWjJL6QYnvX17wSjbkdy_Vsynbhrf8bfgfnQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: John Stultz <john.stultz@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, lkml <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Herring <robh+dt@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0332140327==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rvtcqjw6gjm64yh3"
Content-Disposition: inline


--rvtcqjw6gjm64yh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 09:31:34AM -0700, John Stultz wrote:

> Hey Mark,
>   Just wanted to check on this to make sure it didn't slip by. I've
> not seen it show up in -next yet.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--rvtcqjw6gjm64yh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT+nYACgkQJNaLcl1U
h9Bf1Af/V9VWccsEc81EnuUrphBqTcwOhebFZVMlhZvXUtfNrN2emQ18qmiDdOgM
MwOiEA0PuapanQThJ612d9WDCs1cmgMMk1rfP4ADw6dnOnZuGq6tXGSlsZGxXFvr
2eNJ/bI0ULxvMpKX9+bEWJ87UrDgvvPKRDCVEk4hJ5Ij2iHZOOhjmZxoVoR4uELg
M3ydRxacgbYGow7NcoMvgT5KHTFH+oH2clJPRz61zo0bp5e42+twXay+D3u1rXpf
3syAXK+DX1duY4M4Dx7nT53lo42/ZUalVaP90dzch62fKZwW9GaX7jJsQ8M2GVQ6
OGWqmD6AqWBX1BRvRyl0zJU3MRYYUQ==
=X/a6
-----END PGP SIGNATURE-----

--rvtcqjw6gjm64yh3--

--===============0332140327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0332140327==--
