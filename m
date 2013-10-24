From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Add missing pm to current
	machine drivers
Date: Thu, 24 Oct 2013 11:17:30 +0100
Message-ID: <20131024101730.GB17157@sirena.org.uk>
References: <1382609729-21954-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3512360859272935800=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AE0A26160D
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 12:17:38 +0200 (CEST)
In-Reply-To: <1382609729-21954-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3512360859272935800==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 06:15:29PM +0800, Nicolin Chen wrote:
> Add missing pm to current machine drivers so that all of them would
> correctly do suspend/resume.

Applied all, thanks.

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaPO2AAoJELSic+t+oim9/VEQAJ1Hc+lkU2e6Y2AiTmh4iWA3
tllHg3LoaAEYsC4yFADUCm3PV1qctsolEIUstKG1p0eyyngt9iqdPD+UGwibr178
a7arCYAyf31hn3pQ22mEGKkQ3dtvG/TFREKuQBhfXYKFK/hoZUVhqodO8pm7nnia
0gBURQscnZC+iRrRT1tx0GcoU/M5rkXrcu3Eo3YBKJ/IzMNUmEeTL/WKuek118kH
OSI/o4DXTCuV0aexs+W1Eyam2w++xOBw2pOic8qydBVlOkcvlmEZMizmHg+6xZgj
iBuHnJPGa1+WGX6cZzOAlMaMgttToPGA6LQLAKoBp6HlgpnHm0G0Xya5TiJ5gxkx
inEdfnlAOuakthOoay9XinrM7+mqjpI0owHsnbFcsbo4PXllV1GgPF+tNN9WryMN
WgNA84Wtxd/VFIU/ZTxsXJDuxC5zsdV0dFOREl0KL0WDUrDBEQjtd+AQgVHyAP16
2JOrEhcRfR4lqcQfllAQcr3KxDIujhzHPHjA8aKu3NOeMTmBXVBcHnptuoZldEZ0
YOQYPyTKl0waJuKkBVyg3zMaqprJheqGLq2YtnaOdMvui4kTYrySHbROFKrtWh+M
zcSA13Ib2H8vcOQY7hCa+Pnx4G8E2WboLg9+33FuRbI6wqP+TWua3zZ5qDc0I15l
0EzZTO/WeWzzLzLUgWJ5
=m38h
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--===============3512360859272935800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3512360859272935800==--
