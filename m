From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove comment about SSI
 running only in slave mode
Date: Mon, 17 Nov 2014 23:30:12 +0000
Message-ID: <20141117233012.GC22111@sirena.org.uk>
References: <1416190579-14006-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7877013613811736509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5622260626
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 00:30:21 +0100 (CET)
In-Reply-To: <1416190579-14006-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7877013613811736509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 12:16:19AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Current driver can also run in I2S master mode, so remove the old comment.

Applied, thanks.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUaoUDAAoJECTWi3JdVIfQ6pQH/2JHiyS7dvY831DitmW/vuTI
lPthuGet2/MUlsThBdJm5ANW9IqKzyomH4J7QKZQUeaeYYog1j1xNS9WHBx/g1oF
jl/ihqnw36Mqarx+5zNw0oAEJsIw1no6/QNCxmHKF2ZV29C2NaFiPzsQTDIepn46
PoOAAtrvz7+D3MQGsnxOpuf2+Nn+2ra4SSk5F7CU6asn5BEPrEf/ANuylUYX9kYj
O6M2hpukgjL7ydrooxSTJc1u0bQhgFmwmSVZPwwvgIK9Uzq8aMTPfEr0RMskf43W
zn3QUADpvMQRkkNdIUIItyBIm5QtYmMplhwUanaQiApDy5hQ1Yy8i3sgz94y1Tk=
=ny3Z
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

--===============7877013613811736509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7877013613811736509==--
