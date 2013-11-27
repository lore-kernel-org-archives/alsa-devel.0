From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/18] ASoC: cs42l52: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:11:54 +0000
Message-ID: <20131127181154.GR14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6425306552017261712=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 24835264FBB
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:11:58 +0100 (CET)
In-Reply-To: <1385044736-14911-3-git-send-email-fabio.estevam@freescale.com>
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


--===============6425306552017261712==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qeGiC+TUQd3u8fcS"
Content-Disposition: inline


--qeGiC+TUQd3u8fcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:39PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--qeGiC+TUQd3u8fcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljXnAAoJELSic+t+oim9zw4P/3t/Asne9CFO9VQWLM3uudw8
YhHxKAMZ+3lvLk3Ag6hEEn5hIstIyH6eqmuGc3KNHxuaoRomjPkGH66064Tsc1ki
jxV/5kt9wVRREBCEY9UrZflSt5ljmqNNSgAbTHGlwTMXXtEO2e+WVDxD0PyHKp/Z
EL8eVr55CDXPqARv3XjVGVpcZ4ujsxrumR4CHpqG4UO4r0g78ZuWTw/P2/cs6pXp
Uw4K07poKpmMlZMexUmepLyUW4pkUSuvkjlx/BpF/uExmkMz6W3BmOT7pmdJpqTQ
jGWzu+JILWxdZAzcepS9RSD3amx2BSWMf09Fjhn7TCIPVPDGkVexAA5byhY7CmUf
ESSClhyWbxY0aKnun3r3EjkCGfdSikz8TFoJA/z1U1W2x4jqc8EeFoqNHWwnMwCN
sEZYP77jaBq778FAweTTFSsvtvPSxuCir1klS+VtsBQNjqor+QdzAf/AoI/n6e5j
gmNARxcMydyqKqC5nZi8KcUjZLiSjAStw4aSTdngYFEyVmST7FU6U+k3jsvc8E63
jsCuYoJmMkMUJqO6kVj4JTRTry17YLxDqVdSWPVpB2SZuNxM5e/bDweH9CF9U7Q4
vQ5QdebLtSodTGGWz0eQnyOrhQuqXcT2O0fwj38rlwY19AAx9/hVaL5Azx9yPSvs
0oUpBe7aIZ2WdVOoCFzh
=rBhZ
-----END PGP SIGNATURE-----

--qeGiC+TUQd3u8fcS--

--===============6425306552017261712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6425306552017261712==--
