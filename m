From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: Restructure
 omap_mcbsp_dai_startup code
Date: Tue, 20 Mar 2012 15:27:26 +0000
Message-ID: <20120320152724.GD3445@opensource.wolfsonmicro.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8615505358309882544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 759E4104277
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 16:27:29 +0100 (CET)
In-Reply-To: <1332242021-7494-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8615505358309882544==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 01:13:40PM +0200, Peter Ujfalusi wrote:
> To facilitate the period_protection feature coming up.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKHMAAoJEBus8iNuMP3dILkP/jYOOStnKNXZgHhGPaselyis
wxImQUbtLU14DLNH8prk/ZmMX/3GhL2r9bgC0LNctUkfxhZ0tIysBpntmb6zrvXN
99iChYKUc3FiR05HuHToUDuugsdYbj/7vpaqma6HrolUCucn0gltWqgVL8NuLqy8
wM6zna+4xJN0qMxNmJHIqGF01k9dCVKroM9VK/LHEpWdzGjin7Y/eavwugn5do2k
5EWoIPtVHeAdWQGccguS9A+oy+7ziajvuzwVtioYCCuTU2lNC39dvGvxK+N6KC/o
Jy5xmtp6wl3Z2qPtlSct7sPTtwic4AGwG/1H2d3BiTS8jZKNMDZHFdbwbXpNYgEr
1eB7Fez8CdkZH0FJQEwwbLuZR+K5+uowZoOS0YqeQ+S9Dl1MsfdUlSBo8W647de+
oCtpIJc2RmyfdARuddXBG+hhpA3o0xHxI+tc14TVaWNSw7DZGDfR+p6rgWyzThEw
xWDTazERqY80KCBIf4/2nBKbzotJfhis+0lAcABVmRJlpMGfR+NsBiylTg5IRGyZ
uWCL7zOr8S899/JMlOS4J3RwQ1ttECf1SFD0di4oXeCyUiRyeW1RQB8GtzpWtS2+
Y2ZZByIzEF7LKwkKGypurmZJ1fFvZvYHpbIyN8owKbO3Cw8sUpTj5j+RRMoDdxmU
9RU0nrooeP7gNHTip0c8
=kdRD
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

--===============8615505358309882544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8615505358309882544==--
