From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Date: Mon, 22 Aug 2016 16:04:48 +0200
Message-ID: <20160822140448.GP7104@lukather>
References: <20160822121242.18827-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6712591471322244519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB7B266A3F
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 16:05:00 +0200 (CEST)
In-Reply-To: <20160822121242.18827-1-pbrobinson@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, wens@csie.org, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6712591471322244519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kynn+LdAwU9N+JqL"
Content-Disposition: inline


--Kynn+LdAwU9N+JqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 01:12:42PM +0100, Peter Robinson wrote:
> Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
> these if the appropriate SoC they're embedded in isn't enabled.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--Kynn+LdAwU9N+JqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXuwaAAAoJEBx+YmzsjxAgEtQQALzi1rkqeNQgiKAD+gvXr6m6
mz+eGRkp1GkTEhVpbgBHW9Anqd2ZxpcjScsWMGVjtYroGVLca5+LP+c4L9WSPxQU
JSLbDIayTH0cefbQ+Biqav10Nrw+MJMtjrFaD3hQt/ztyNIwaz2dbPzS9O2RSqe0
h9FbTxvBP2q1W4aoW1F9g6k+6Aki90rFWFksMXfjpdiWM/M4dINPoKQOx8fJAXKg
chlKulPz9uozwH8wVVQl0Y3bSLJcaEcxaJs8Z6t8pibPRSu+HWN672JthCGvvG0J
G1KnWUISWoVF8H0em72x5tdWIX3XSIyBPfReJde/ozhyZgk4Hcv6whYtOVvLF6Vr
PS3zXbfbvxsiyoWRP3mw7bgwBOhuTZNKDCMTkgl9ZZ+IGuiGn0pbnEmNH9pvnFuz
I1ORrLO+79xhRZNcWFra4LdfLK3Gt49gAZCu5r6tYRJ5YkouhVlw9fSI+kWv0P6V
odGLn8fleUbKICmrxxauyCAQy9WiDu8Q2nCQGOrMYVlBLZjgMfDavnuZQt6rv3R4
lCpP5EVnfpoAMH1rIK5Nqa5PnjPgsKdws4nPMYB6qk57GQzCj/fC6LGoVDwHXsXT
mAVdSVlcaIrdY/2kkQwZEnbxo0ZmeOjIX+y7aECltHFQY1VseaQLhUrDTRHb1Ejr
nEvdFmzesHJ0bDOSw103
=HN62
-----END PGP SIGNATURE-----

--Kynn+LdAwU9N+JqL--

--===============6712591471322244519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6712591471322244519==--
