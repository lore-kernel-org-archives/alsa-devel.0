From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: ep93xx: Use generic dmaengine PCM
Date: Mon, 6 May 2013 20:41:32 +0100
Message-ID: <20130506194132.GF7478@sirena.org.uk>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1701575563693731768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E9C52261B0F
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 21:41:40 +0200 (CEST)
In-Reply-To: <1366478947-9377-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1701575563693731768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:05PM +0200, Lars-Peter Clausen wrote:
> Use the generic dmaengine PCM driver instead of a custom implementation.

Applied, thanks.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiAdpAAoJELSic+t+oim9AkgP/jzpm1Xolzo34CCd7tDZ7VmQ
ags8tt/8uaIQ9beaWW92WPttaMnLf5rcSJxNTzuLTwRD2iPttEMZOhCGZC/lkPjZ
aIhQrOeWxxr8WY5GV30CV5emacgGMpyDLC7lSYKwac7yS50pYc8L5z/s2tyi8QHr
Hv7zewisFxlsHu7xrfPTHZQ2B/AP9yr0WStkwATuEgUFro7t7o/l/FU4ID7o3wKg
ey9qWMcMzP0YIw2+vfpcmXL+Z7z0XQVLLJYn9VarAszW/rEHRlGJw/j4hBq8S2RX
vwrK2lnoIMVRKHhPPHN4yIR4E/zgg++LCENsI6Qj0+9ToxtLE626hqNtvykpXPFF
Q8rMbZoUm4BQwz0lhlDmaNbPGjxtk6vtS+WFL+6zDtqTLieeIW92L7w8nyJP2aXY
WVSGVW0kaG9+QYXC78FSAZDzmPgePJeyGWlLMJdRYVu9YWoITyiL4EaGsYpUVc+E
e7yh388m/qGR2yfoLyCSrxLs+3DOr4rhyapDy+i4AfH1IctgpFnmwmIZ3pldYZWB
C4lv/GkHSVG3+j+wGq9fr6OSu+IXfIgaREc8CZXznbsPfsesQKxgCj0Krj9PUi2h
93G4irDV20IsmAXvdMPFcEyBQCn8tr/Jb7sALA4IAErxqiJGgx0yHrBrs5Yy/+C0
nJLbM7D2h8TfAQtqoth8
=+LRG
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--

--===============1701575563693731768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1701575563693731768==--
