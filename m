From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Support transparent
	CODEC<->CODEC DAI links
Date: Mon, 16 Apr 2012 16:05:14 +0100
Message-ID: <20120416150513.GD3219@opensource.wolfsonmicro.com>
References: <1334342704-21495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1334588378.2255.1.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7210069417882150458=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EAA2104218
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 17:05:17 +0200 (CEST)
In-Reply-To: <1334588378.2255.1.camel@odin>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7210069417882150458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2012 at 03:59:38PM +0100, Liam Girdwood wrote:

> I assume the intention here is to have a graph like

> some widget --> DAI widget -> DAI link widget -> DAI widget --> some
> widget ?

Exactly, yes.

> Acked-by: Liam Girdwood <lrg@ti.com>

Thanks.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPjDUjAAoJEBus8iNuMP3d30QP/RDIW+UGENMy4C6g3ZmiLSt2
6C+l/lq+OzEaEg+4Lylg7KsG6V8jbsRJx4yYBlCn0mwVuPi2zY48taUYqJSj8q0D
k9oM15eiubFTmFsfx+JTglKwBe1aIqWu+QPSi7fbtVV4/OHqmLDbq+GwSIUnm5v/
ClmJZBqkCA6fKWTG69B89LhrIUvnwgIG+GtpoD5QbS9l2QQstXxMdS2ZtAyYxF3c
kiR86oaXI5+vxEX68ojov4cXciasoRhV0oSF3NaBoHJ5KlS3OjfyDkZ5QZ46REZc
dwy1/Q7uoJo4ekpmlQT/HqkBmFe344kdfOUfytPeiKRvShaDjwp1G/msJnmMI+Am
G4pBAUC4U/TYE+wgI95YYU4aOabjGSZgMX/5knBR6GMebdmH/VngkrDMWqVPw5OJ
ioKowdil5tdwVmpFFD/FVIicByXOSiDohRSu+pQGMA/H8uj/RJKYDvJJrcxBBh6Y
b5EkFlPhb4XdncQGQgsxpjgT1m9sF8j11DEGoSG6Bl3EakpmnM+rZMl7IJHaqWS3
+ZiHVqYXxB5Fg5+SMsrgcR3Xj5AWr7riEGsIPEXH/FHlgT4QcWn30PLHCex31Dp6
w06/yWsoFMITk7kxDuIn8YFLJOUPxVowVR8RwS25UplkyJ0lQOygqJZG81CyDVCM
gin+VUjZ7V5UM1Rtoq8L
=WTcJ
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

--===============7210069417882150458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7210069417882150458==--
