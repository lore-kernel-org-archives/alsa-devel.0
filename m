From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/18] ASoC: wm8753: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:16:34 +0000
Message-ID: <20131127181634.GY14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-11-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4066984910998324360=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 608FF26545D
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:16:36 +0100 (CET)
In-Reply-To: <1385044736-14911-11-git-send-email-fabio.estevam@freescale.com>
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


--===============4066984910998324360==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OvHFI8f/INxOklTC"
Content-Disposition: inline


--OvHFI8f/INxOklTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:47PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--OvHFI8f/INxOklTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljb/AAoJELSic+t+oim97T8P/0xDCjvd5hy3dcw42M7EzsQT
Ojos/6VHjGSWMP6jZlkell5jLGFus4YA+LfO3Tz585N7275TuUBfSLuIYuyk5VYW
eN1asL3Y4boAp3vIlO01ibfPmUoBqA0PEt4eRld/je+PNkhSyd8vVxpflKVb07Bj
7U4qxLgDWNM9L7FN8Aq71v0vP14mGDKP2BkHvzKgqDu5P8hCoaiBaQ68TaoL6IXE
YcfOxTKkUkuwC+lTz+wNSLNhpBPTORoFFDK36dOcQ3AvvG4YDiYpStc/kauOlC2O
JTAPIBjBUgY96rLRfyIjmbg4axV8PfLCpnUHuArkrrCDD2oC3PQlozGhYWJldbIM
6JKWQrzpbHDT7p86f4aj0zGUY8+i3O+kXRAbI3oHy8wWbpd2XvPitSbZtuQyms40
UO5AMZ7Kaa4kidJd+oMnCJFkkmzpUF7i01di3SfTvNvzCjpshtQ8J+84XpXVjx6n
1+cErCHDugFccRWp++xUNsUUCvevDIX8oCQRaF5CgErHwPRRJESmcvyDPMGbCfI4
poZPCczU4VLysNAgtJZ3sD3ITjTLhhikn6/Yka4JwmvIRgxg6WcZMvsL5O8cCN+Q
d5pLq1RmgsE94ez9io4RcDA1uGd3Wz1NC5kCgEhelRRBET3GDacPTGVazNp0jmiF
ejbMeaXnetwgsJRZY5Ak
=Fk4U
-----END PGP SIGNATURE-----

--OvHFI8f/INxOklTC--

--===============4066984910998324360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4066984910998324360==--
