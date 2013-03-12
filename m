From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 05/10] ASoC: pcm030 audio fabric: remove __init from probe
Date: Tue, 12 Mar 2013 18:55:50 +0000
Message-ID: <20130312185549.GW19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6991229811840859789=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362940391-8338-6-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============6991229811840859789==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1d8mk/W7pQzMfc7"
Content-Disposition: inline


--+1d8mk/W7pQzMfc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2013 at 07:33:06PM +0100, Markus Pargmann wrote:
> Remove probe function from the init section.
>=20
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied, thanks.

--+1d8mk/W7pQzMfc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3ovAAoJELSic+t+oim9IagQAIAgTj49yWUfNlLhJA38sTDb
cOo0dI74d+OcBf3H7X1lgFvbgEpP56ekouznk/0O3cOnk+qu93RWVefNKmMFwS6c
EgdMPOj/gK0g07gDaAlFv6l/OlFlgoM0MxrsJzrOhQ9/hHMNU7nvAWLhZ5LH6ESw
yf/yMvXirCy8XEvvrmAjjztUZz0ldCXRM1F87EXthdePDQd2lnhTIBLyzE4SX2WB
LWRX10wDS83qeNCQ+fK/Uj07wASsiq+NiE/JXFWvJ0IFk8ERet9W9Th7T3NlCDG1
LxlSMGB43hgZbegrof5fSN4AekZr67+2cSHICc80BDvvSVeNNJsdCQ+eTGqb255Y
9nRY5W9caxL8Z+aFjHFnTJ8/xqiElXbZsvCuCpumfID0XhiPV4jqFIpCCTbU54+X
kQUyvLkIrus3MtaVlY3GriveeNiwZW3IByaUCInsNmTmAeDErGbAfbYwgoQ9fElu
bW8USFBZor0OxbM8sXiVDrp6ANpXjyRrCxFzybDENFPRvidw0/CvfuYPD3tzd/m3
XMqi3b3fh4F6/USgbqCSWkAtBv+C6BgApGzgM5FjoxnNXaJRHSQwLW5bUy5GcaIU
hqAKJh2np+TmPu0q7y6gpXhGjPvJJhR+facfUeOtSWeD9BmoRWsLUZRRXumNfF4k
oKUd6ikZklnp6XkFY6Dl
=6/bq
-----END PGP SIGNATURE-----

--+1d8mk/W7pQzMfc7--

--===============6991229811840859789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6991229811840859789==--
