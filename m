From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 040/102] ASoC: stl5000: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:21:30 +0900
Message-ID: <20140223022130.GF25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-13-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4607049443435817929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B0A0265051
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:48 +0100 (CET)
In-Reply-To: <1392723517-12772-13-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4607049443435817929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TUvp6TiFcfhGC84w"
Content-Disposition: inline


--TUvp6TiFcfhGC84w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:56PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--TUvp6TiFcfhGC84w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVsnAAoJELSic+t+oim9iggP/1AgkmDnKzkukCokpmyHAmOd
MlStQqgtc0guKSoHekzemiQ9U8lDiEO42DnAtwMYzRju9SmtF1N6iMdRQFigjcd5
yrDOi8Y2q4n8+TAsYeguvI+vFM3jpPNK8dgAuvWkF/yI3+BCX5q/bl+RrkcCxLau
/67T8FO02NMTrYcQZ9cNsY2AiPrAKNHeYC7hyR1iKeiygdlxIZYz7kAfIX8BxCYK
7sxKf5cM+gyP23F1DndNRtypkgJAQ3o63Ncm8qSLgxDE0qrxm/SzjEoALWbjLKdj
/Tjdp156wUhnsaU3qvv7z7Pxz/GqFnriMPtKtT2P4jOcZUvUznfDdVHDquX/zZq0
vPSsty2erdrtRDEC/gTlMw2pJMBUmbe0LEMh87ytFcZR192VRXhAg7r6zBpGqisR
dnUJKhh8VfVYVFOLPyE1lo6jTWluoqrkOjdbW2hYfqzv4jez47ML2UgsfDu9yJjD
dIedtvN/GDLb7KIdyX69OAzBV8u+fWe54b3MmGFLLUQxu6mqHxcciZEyzU6GnIEl
5CSh8Rl/MJZO35hsl8k26ymCaSTms1lLdZkXwEMX8A9ko6mRclUcDHGlylZdVMsP
stF2Zkxu3YLy6NVtfKuttT0igTQFS29AKraMetmUofPjjeXRNGHbFWdJdG9dLW6M
Db/l5u476/JomTTY+mJ2
=QpH2
-----END PGP SIGNATURE-----

--TUvp6TiFcfhGC84w--

--===============4607049443435817929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4607049443435817929==--
