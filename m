From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] ASoC: davinci-mcasp: Dynamic AFIFO and
 DMA configuration
Date: Wed, 2 Apr 2014 20:38:43 +0100
Message-ID: <20140402193843.GG14763@sirena.org.uk>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7467787870093210717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D6D526550F
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 21:38:55 +0200 (CEST)
In-Reply-To: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7467787870093210717==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2014 at 03:55:06PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> Apart from the first patch which is a rebased resend of a previous patch =
this
> series will change the way McASP driver will configure the AFIFO and thus=
 the
> DMA burst.

Applied all, thanks.

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPGdAAAoJELSic+t+oim9gTwP/j7HSsZhzl5X9YfbCzo8K3Xo
JzhipTL9QDd2H1Q6yu5RuYO+NOfY+FssOEikh1otpPGGozBQBcbuBZgpAJxCXFgW
vv7eP0flfaQLvHQzYH7w+HcRNeStAo9EgaaMehDchPg47VwOyebWPAIa4sZbZzH1
iMvmyA4VSnAsm6xrH7RHeJcccK9vant6l6FHiczL9LEOm32sluQrbud56PPtSaES
4VrMgawkSIcefRoyX57zWtGiaoDsvyiHjTng2U0xCtd+gRIPHNwIaSVPTnxpzMsK
T6gT8BZi8scl+ifLU5WF0e5Ac49wdSBqlEL8MW7JBR6P1t9TJlogTMnkVAVelI+6
ZTJ0OTq0RcvU5GxcwuWuyEzU6aBkSxk6ZiVDypwLWgwV0I+99N3TTrX6IRQ9tqq9
FF2OjAQh5yXb4Y+G4+UmU2IJrFIyKqBxz1p4XuyDYxsgHZsZgrKjrDGhY8MRYPXK
l2W8VXukDKeg3kIMDypH6qqvyHtWaHqi7eJq6mY/3FhvIRzJPV6eq71VdS0hewfS
z1bUNc0so4UqYOpXFKE3fQmsruvb7vYSEk9U+i8jx2eaQrPJo9/UywqvK2zswYqn
kW1KrjAKCS3Br0RiFZRO4hrhRgkV6CQrw5UClHQR6zJoblEYY8wnO1NwRx3VCZ8N
hyAlAZVVpZxAPos76a1l
=UYmg
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--

--===============7467787870093210717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7467787870093210717==--
