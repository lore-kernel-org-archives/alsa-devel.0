From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: ASoC: cs4271: fix sparse warning
Date: Sun, 2 Dec 2012 13:02:24 +0900
Message-ID: <20121202040223.GJ17981@opensource.wolfsonmicro.com>
References: <1354271337-15113-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3663190210916481692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53ED8264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:02:28 +0100 (CET)
In-Reply-To: <1354271337-15113-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3663190210916481692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 30, 2012 at 11:28:55AM +0100, Daniel Mack wrote:
> Make the flag in the pdata of type bool to fix a sparse warning.

Applied, thanks.

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutLBAAoJELSic+t+oim9M9oP/2X5qrQ6c2kruoWiWV7uEdfc
jrilx9OXdq8Okc6ZUH553qbszODJIo+Q0RcN9Kmyk/Kx0jCmKc4ts7Q5X5s8+H0v
GD1ehkdR6XcWoy6MhkB+k02Ja+v4uNuRKWYr8c5twawpMJbOGHMDqmI/PbSByA0I
pCeRXLpBR2jRpE3eiSamRrNBtsKns7o3TKC0QeOaaRUMUQbhIVbK9rPBKPPNWMeP
uttC0KSmj+h913Bqchopw9EzdVGOnaQRxMP7oPTbmJWxooduijiDzzZOWUV8FQ8X
58jyKJxU1d0vOncDSLy23RpNYKJhI/xcHAa5DWYxjBjorybt4GaeYRmPGvBSTGNp
gP95popwLSkdCF4XLotBV8kPZ3gfQyZlQvnG+IEkUHBXe/nt2duLU7tgJU84+jPE
aZuejGockFkJJpjDfTmrG7bDTPeHKA0GrZg5QibZDLBaCxiElT+d8SSNFI5cLS5S
F2uLCmSF/mgPoJSJU6UMkEhp/+MGNmulXah6z/g9Yo9BJGFMuuV68LtcQkKRSaiN
iJe2Qs15g2XYi0cNDy2KNqlOcbbi85NqQI5SFMbtzNujUbwaEj0kEmFI3UW2uxte
6etrD6Ah0Sxa8BeZy5HKbUZhgNDAYuXJTOx9u2uZWXXRI1gQEaQbQU3WF3arkgbq
58cHkR6Bndw4bSYTypC6
=M0j/
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--

--===============3663190210916481692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3663190210916481692==--
