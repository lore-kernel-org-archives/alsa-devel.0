From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/3] Generic HDMI codec: Add channel mapping control
Date: Tue, 17 Jan 2017 19:39:03 +0000
Message-ID: <20170117193903.rgbkcwrzoxjwfdop@sirena.org.uk>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <CA+M3ks4rM9Fyt9ysjtruqzJeJj=cBgKddE+n0UFHpP1RMy6OgA@mail.gmail.com>
 <968a714d-c802-f3de-00de-4e4889c82c63@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1199590349=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <968a714d-c802-f3de-00de-4e4889c82c63@st.com>
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


--===============1199590349==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rtcoikflgdgr5wzf"
Content-Disposition: inline


--rtcoikflgdgr5wzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 09:54:31AM +0100, Arnaud Pouliquen wrote:
> Hello,
>=20
> Any comments on this patch-set?
> what about the introduction of pcm new callback in DAI ops to use chmap
> helpers?
> Is it something reasonable, or should i come back on V1?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, though there are some other maintainers who like them - if in
doubt look at how patches for the subsystem are normally handled.

--rtcoikflgdgr5wzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+ctYACgkQJNaLcl1U
h9CQhAf/UDkOXdJlkX730TFuj+Y9iSZA6JVsnyB2lnNnw5sskZ3YOsAjuZ6pv5Ra
hx3DPzaov8EbJZBMqAogeaVstmOsVXM82k4Ru5fjaJ424TXo2uEFjx20AI3vHraz
TsF8fcnzaZ8M4QsxWchGjh/cpSZB34Fy07DdrBYujNuj4yrn/61ZTpOw+D0N+RrO
q26Abn4ix0X2ZVnZqor+85s5wL/NuVPy2GS5s7lTVxasti7z3dTaBw2Ot61FYnYr
Bv0A3s/lKMEd8ntk85OYYiR0E1oJ5GvBTIo7Qy9lfMBlKMMpT1YcTosQu4ocyBbL
9Kpk51bb9fiFqjpZ5B4cDwWsrqnPcA==
=50q3
-----END PGP SIGNATURE-----

--rtcoikflgdgr5wzf--

--===============1199590349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1199590349==--
