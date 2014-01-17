From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: tlv320aic32x4: Use gpio_is_valid
Date: Fri, 17 Jan 2014 18:40:29 +0000
Message-ID: <20140117184029.GE17314@sirena.org.uk>
References: <1389886227-876-1-git-send-email-mpa@pengutronix.de>
 <1389886227-876-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324171526209256049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B81E12615B9
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 19:40:41 +0100 (CET)
In-Reply-To: <1389886227-876-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1324171526209256049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V7LzxcfGKRikha15"
Content-Disposition: inline


--V7LzxcfGKRikha15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 04:30:25PM +0100, Markus Pargmann wrote:
> Use function gpio_is_valid to check for gpio ports.

Applied, thanks.

--V7LzxcfGKRikha15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2XkaAAoJELSic+t+oim9gKcQAJIepoJWslKNtxXrrd0fnEMz
0pjclsGIA7UfAor7szJRgLrpdtdq1+a0ZnmRS5MZAc+Aw73hCcjP7N0FrgHtCeC2
D0MGbk81+U79LWAoftQY1EHHwJVl8ji7PdfxUpaa1RIFtycan06/2QnuQOnE1j3u
/XP8M2UUj3q4303zuy33drUGTs0SDJ/nINFtP20BmIuU/RNseeBrGWhiBJr+HXzQ
CQzDBoVVzkHFVDG4YN0pKL++CtQo6kihNInhMlG4qD4AOQF0I973/T9ZGvXe5KZj
/a00V5fY503lJ6bMmyFUmwP38uSHcWshjvE4Em9pxV+54od0vUK8gitNXuNBidmE
V3YkwnlXCHeaiNhCKRdAvODyuLN7hWRNIBQBSWHcuWsi+W993l06XvAnJwvinBod
lKH4maqtDdpNBcqS+VTXW4HZ4F41kLG8ckLNHQedG1+OhND9bL84gCiYkapd+HWT
4CClRe4imLGfRDDhTAKLOAgFIAz75WCJbuiLtSz1mrWuBXyjQIpMsmBUiaDAx0yC
HXG6T0zZmD/ZIuq6nrxax/L2HADKXicDs02A78BZ1bu2m92j9smZcfxyJVtyWZzq
JiS9ZqVRWG8YqGEUs+NeKPVIY6fVrcp4hon7/XR/4KbMgS6zfbvqWgIoGvnOvyth
NXNgcx1zCPuMRIE4b9cx
=ls38
-----END PGP SIGNATURE-----

--V7LzxcfGKRikha15--

--===============1324171526209256049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1324171526209256049==--
