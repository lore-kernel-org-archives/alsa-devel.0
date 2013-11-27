From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/18] ASoC: wm8900: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:19:34 +0000
Message-ID: <20131127181934.GA14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-14-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3426988928742097481=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BC5562651A8
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:19:36 +0100 (CET)
In-Reply-To: <1385044736-14911-14-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3426988928742097481==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TH+WuvBP3vzEx0cV"
Content-Disposition: inline


--TH+WuvBP3vzEx0cV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:50PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--TH+WuvBP3vzEx0cV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljezAAoJELSic+t+oim9RSAP/3Vy9e7khlnu2eVZD0DQNslp
6kgbIf/lMZmdmRWQM0U5pCkbMCE5BrnHWJSEnFOUh0UIDNQxGQuVoNrrAr9FSmp+
OkLiGTHeHAl6/AJks0eme0sPoMmIQtAlZ15SPIFNZtWEAxr9OnBTlt7wrz0CHLIW
h4EzG0NRaRp80OLKmBSHifXXNaCj0m51pQDDLN39E1PbxMgJ/OkYucagT41xz2Rg
Lh+cgI8+OZG53r5+qLiy6GeG0mWFfuqQhK+80rz3Y9E6hjfnduFMomJAVJ1q8wCm
efhOcrPjfIWCPNX6xK6W8vR1sE862pNzmI2WEO3OFXj7XxaDsLCIm9NMQeq4VLrW
434GLbMtvN3PVslZxq0P92dTRFqN7KfFdIjd8n0ROb970dLkPYWvk9kIjtnAwRTb
+pRielBbGuPD5m4dDmnj1CUGXbCmka15tsxuHTmL8ymNgYPIr7LKA6SJoUXHTgF0
kOvvDwz64ebrP1UWxW3T2sv5BcmNuj40+0awr9jiY4lIyy1Ciuotbhv4LjxwGT9U
DeHZnrdedv580oSIqaDUqB9fX3nPLCWe7MHtZrHFXSgZnudVBiSAXzPZUZ233KZb
ZtiyE3Bk3ZhsUJCLmXCE4efuCl6ojIFYnbZSY0XzZEFEirl6TouEPAV63i/z0otd
XdGB/ajaEOMzjE+z81LX
=hDqY
-----END PGP SIGNATURE-----

--TH+WuvBP3vzEx0cV--

--===============3426988928742097481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3426988928742097481==--
