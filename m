From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mioa701 convert to snd_soc_register_card
	API
Date: Sun, 1 Jul 2012 19:33:21 +0100
Message-ID: <20120701183320.GH28922@opensource.wolfsonmicro.com>
References: <1341077108-18455-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8993494693843847048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6974E24396
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jul 2012 20:33:27 +0200 (CEST)
In-Reply-To: <1341077108-18455-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8993494693843847048==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SIpeN1L2gmCc/JOo"
Content-Disposition: inline


--SIpeN1L2gmCc/JOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 30, 2012 at 07:25:08PM +0200, Robert Jarzmik wrote:
> The mioa701 board code is converted to the snd_soc_register_card()
> and snd_soc_unregister_card() APIs.

Applied, thanks, but please do try to use subject lines appropriate for
the subsystem you're submitting against.

--SIpeN1L2gmCc/JOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8JfWAAoJEBus8iNuMP3deVMQAIiKN4kCI9EgUvIKMHpsykmv
aoaL52N0APxBVOTwo8dvPI8uspJGBrN9BlZ1RJzt8n36k7/01TPDXnsrDWLmSL57
nrG2vT87dR7NZ/59wBKNhKPMCRNxFH+72ScwouHMIHW1pRYlzHVNG3hM1OOWNB/r
M7IK6j+hmL0BSj4v/Vo+AYHzF/yACmMyGoJtN0UlsEfG1pFFmedHzOGY1vRU0P1P
fAdXlKVa7ZlxkxVTGQqKLiMbtdQgS6rkxC9DM6vhBzKG7tGCKyG/igoZZNVNBmbU
U6iJhPXALjNWZDLLpowI6CyUHsHL9J/Qp7lhAeYhnaqH964agI2UPuPn0GXRUdpD
UF0pt13tqHd7+HyJW8n5nMrzE1tiZijoS3P3LaUHtlJIs10A856oY+h2S52T7v8a
nyCEV90kjVtUIGuCvihWFg12HJbk/IfF+kkEyc6xTerGUB+dDjh/xDennOvqPdeo
cfho0wBUvyqppMba+Y+ryUxuXNaJLixXJ35fx2Fy5rTkg7JVqLUkzOk3h69OKHAx
n9WrG2/h5OKb/IlMJdFYCeOYho7IO7xQpLzyYfwc6scj2NwqasDulrdUlnF19Z5K
4Iq/MLxotWuWxiZC0Emc/bl0W2iZfniDqggkDgg5sFHsCKYNmJqCTlJN19XgLs+g
gNJ9hlNdDPy8zfmRSeQ9
=izkT
-----END PGP SIGNATURE-----

--SIpeN1L2gmCc/JOo--

--===============8993494693843847048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8993494693843847048==--
