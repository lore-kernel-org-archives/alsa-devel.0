From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [BAD PATCH] ice1712: Add support for Philips
 PSC724 Ultimate Edge
Date: Wed, 14 Mar 2012 12:34:56 +0000
Message-ID: <20120314123456.GF3133@opensource.wolfsonmicro.com>
References: <201203132159.19733.linux@rainbow-software.org>
	<4F5FBB62.4020300@ivitera.com>
	<20120313213322.GB16460@sirena.org.uk>
	<4F6051DD.9000808@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7929568373726659736=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A0AF1044F4
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 13:34:59 +0100 (CET)
In-Reply-To: <4F6051DD.9000808@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7929568373726659736==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2012 at 09:07:57AM +0100, Pavel Hofman wrote:

> Mark, thanks for the information. I searched sound-2.6 tree and found
> the only reference to linux/regmap.h in soc-io.c. Please could you point
> me to a place where it is used in alsa source code so that I could take
> it as an example? I have no problem with using the latest kernel
> infrastructure helpers but there are just too many of them.

You've already found an example, what problems are you having with that
example?  There's also other examples in the kernel, especially in more
recent kernels.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYJBqAAoJEBus8iNuMP3d5K0P/R5bMDfdv/sJR/qI94O5yu0s
Bxx1XE3D+sflKPZdVFoHR8Wy2YBDaDFS/R8JPMo+BSg8kBz4FmPPuOb3bvTtGpob
zFXzkf5yVf9OyhYZu2XQFJn26OYEfRijCRjWRZ43vFy99eZc9yiVoWp5LB3a1I5f
PBufOuxFsGldCEa2SIJwsci99ewcVBhVG638X5Fk+Gw9eT3x1fMxUrfGSxbw0CqB
0e6tfnQnYKtROl488426KU8H8DTX0BrEmBjwCgl8gC5rKrkvBxfEiIul5PTzwDdn
UH2qR8k0NgnwmrORQc/azD4hxSgRCp+m4kq7tJeSz2aE199YojxRiKk/4OOMjXOV
MaDUNZzQlrEeZc+2Ho4v6w4DSpJXOJfRmcOiWVPR5Jbop1/deMwYZ+llS5AziTfc
totozrOEZnjOXk5b4L8gEtFa59JyPoj7qqRBbsM8qnobSe226/onmfp1yor2eHmj
QDnYFup51nOfLfrV/Je4VBvr1R1vYUnSdCJ/fSfzVszGi1PrsjlGJ/8t5bK1rfFj
R8STSxOkxGUDorolZb4eZPV4OiH1IQWWGPyu7BOeCyWEDzBbga4M7+DwbG9UuobN
lQQoohnwnvYRZY9b37L8DKfHiCq1J+Ug/R81fAq2JuZ/G4rEKY33Y/g2/pq3uG8H
bNxKN4nNRA7bZ2Juqa4a
=18bS
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--

--===============7929568373726659736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7929568373726659736==--
