From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] Revised patch(es) for
	CLOCK_MONOTONIC_RAW timestamp
Date: Thu, 10 Jul 2014 16:51:25 +0200
Message-ID: <20140710145125.GI30458@sirena.org.uk>
References: <1404997458-15377-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3091843645764501200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C92412610C1
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 16:53:04 +0200 (CEST)
In-Reply-To: <1404997458-15377-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Thompson <daniel.thompson@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3091843645764501200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ARHwKispuqSRPZ/2"
Content-Disposition: inline


--ARHwKispuqSRPZ/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 03:04:15PM +0200, Takashi Iwai wrote:
> Hi,
>=20
> here is a series of revised kernel patches for adding
> CLOCK_MONOTONIC_RAW timestamp type.  In addition to Mark's original
> patch, the new field is added to sw_params.

Reviewed-by: Mark Brown <broonie@linaro.org>

--ARHwKispuqSRPZ/2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvqhqAAoJELSic+t+oim9dVoP/3K9zr5FKiAjn+4qJNThyePP
gwIiyQxr7hkNppkj78+h8waSbZcl/DjV6SaNKpsr8AgTPVv3oupes92uTlWT+Xdi
LiGrLFjres2VbJ0xBc5uFO9cFlpuJ6QtJ9RLEeSMJWv9iHAmTnSj0RG869Hi73y/
eCf3LRZV5HWfHimsDavfsgErKh0jvMb75lCMUPT6kMIplD1PSU3U0jBHq20zSxvR
ocpIVBAk3u/wPlibNB32vRuonPWfoiMcL2MOG3uTvWEUz05NPNouoWmhbnTWkwmD
ApPJKQPeJupT130NGVvg51JUfIcvZfSE3qf2sX3JKpZ+Euu1HOT2w+4DjG2yp4hf
WcX0kzuGZkFoWoV1/8pXrcBghtq0No1508Lc5MmjksQ2EaetcGNk/LqnNdFEdfnN
wJn0u11j+VJGRvHWNWVJ0VPkCh65TP3aZHSRoJ0NcBeaTHSRQXYSZZgETHHr1KnO
eRyNOGK+BjukovFlhcCJHyBQhqdWF0zCxbTpp3x22jYF6B8hJxitOffLp3VbIOwk
amgz/aDDD1f702jbdzMaBAfFKfdYLqKFIAEwh4l0QwALx1/vA1K37UREdoMGT/+8
xJ7lcnWaAk7lFBlTsqEo0vAFKnMg89i94ItBzwGDp5lEbgRWvD/cKGK1zOcA6sxO
Dg2EHNIdaWDtNJr7/OWc
=rXLs
-----END PGP SIGNATURE-----

--ARHwKispuqSRPZ/2--

--===============3091843645764501200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3091843645764501200==--
