From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add platform component
	mutex.
Date: Tue, 6 Mar 2012 20:09:12 +0000
Message-ID: <20120306200912.GD19635@opensource.wolfsonmicro.com>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2525121063647137122=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6CA12440D
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 21:09:14 +0100 (CET)
In-Reply-To: <1331057779-4630-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2525121063647137122==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="89VDYHnQ8ukgENkm"
Content-Disposition: inline


--89VDYHnQ8ukgENkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 06:16:18PM +0000, Liam Girdwood wrote:
> Add mutex support for platform IO operations. e.g. can be used
> for platform DAPM widget IO ops.

Applied both, thanks.

--89VDYHnQ8ukgENkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVm61AAoJEBus8iNuMP3dwPwP+gMPOLNMmDHEB/xvzAfE4Jor
KFqyByORTCNYNl3A8eITIoGQi8Z435Bk8wfRoyjg3aGMDhYn44vVnYujqU90Jgs6
GRMhpZFBlExwGlF1c3EfiK6Q44XnIhHUVbVFuTDJAnfEZhjDBa1aWoWdFXziMSYK
qrKC45TYXxorvRwZIjGatsy3caPA2B64wQmAMJslz6OJ0Jfc2k3Ey8VYEkUdx/De
xoM8Z65dbGlEz6X8s5RD06sEWLmEzeRd11RH3QNgLo/DDJoLa4M9jvn2wAOy/GPM
GXzhVNDEF6NSbmB6EX6UJRDobwE9DpXYxUowJb0dNOtyal8wROJjbjnPyPEwVWDQ
ekJFDekY/wvNTONrR7beJJVCXVaw1yUHnVvQZd+012Z8O7pizSxxobGJ3fqu44lG
hhWJDiyB2qwTH+EwF7LqUlSdfI6nRU0+cGFSbfnPJ93lIRWh6ENjoOPtxyO7njip
RYr+Jq4ltybVuJOoE77Wb7RlbPB0+iw6XzHIPlOsxKVnl1mf/RyL+L/l9asfKta0
n6JBtuVF7sD0vEHns29z46AJH1s7lkxsLf29tNS9fJKGPBkMbsDH19Xf40wNcl+h
lsOIYENWTAj0C6l+sJHcSONQycgiBeHILdUolYFO7cN7FIh0Xlf0MlleSCjsIyAm
Gnf7AAybASvp6Ohr759Z
=3lza
-----END PGP SIGNATURE-----

--89VDYHnQ8ukgENkm--

--===============2525121063647137122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2525121063647137122==--
