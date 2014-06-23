From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/19] ASoC: Intel: add mrfld pipelines
Date: Mon, 23 Jun 2014 12:24:44 +0100
Message-ID: <20140623112444.GZ24291@sirena.org.uk>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4520632101275019177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE0432608C7
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 13:24:53 +0200 (CEST)
In-Reply-To: <1402662848-24534-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4520632101275019177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zAZKrYjO7GRpkTOs"
Content-Disposition: inline


--zAZKrYjO7GRpkTOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 06:03:56PM +0530, Vinod Koul wrote:
> Merrifield DSP used various pipelines to identify the streams and processing
> modules. Add these defination in the pcm driver and also add a table for device
> entries to firmware pipeline id conversion

Applied, thanks.

--zAZKrYjO7GRpkTOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqA55AAoJELSic+t+oim9JhAP/i0+ckSWX74PtzExksOLLp9Y
2MhRUrbibq+pDbbNFWNqbEnYI+2RI6VO1mlhRIcLsXFnDQdYg+cmtYU1jQzfAj5P
F+eDTlX3ma4btc0tUwNyfQT92hdfwGzrIlcj5BQqa3Y5dFWmnj3kwdI0JPkzdN3C
8pwH6K9kfoCzCESQqtlPOBx+C9DPMDaGBVEhiBPSdiGrqfHq20LKfD8jRZYtjirR
3bAhwpblXiFwofsUKEK8O80qgJCeZWBcPRNtnFdM/xl3gUOa7y5aI2SxMrxGxmMV
+2Gqf3uLdpcYc/Qkt3s51SOgpRxzu1ZtNUEfyVE8GKCBFFHvWbMnPHkbivmr//U9
TgTFj6F/MUmNIT7A0/EhIexC8cy6jhdseGKOmcsHIA/bs4nrPbo8ZXyuByu7P/gw
6Wqpos3GbnphxQzc/G4NsvKnx5rcMLvnDrogQ568sSqO4u9tuDZB8p/w8oDVu0Ko
nOttiphTZbhIxB8MSTic3poF7vEn6QpHdaXTHft4kPwx6Gj0g/cX/H1Thso52WV0
gMS6INV3J2Df8tYBy+oQKfXtucUHHhEFx1cXtwucFY5vJ2GPAKg0q9OpvijQZhdQ
WXMvo8SjtL5H6b7SGYonkDaMgGYf2aXJZvDZI0bxxYWid04NNxLLaaDpGaSidcqQ
EJ32imDO2M1ilPX2VjNC
=TGPm
-----END PGP SIGNATURE-----

--zAZKrYjO7GRpkTOs--

--===============4520632101275019177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4520632101275019177==--
