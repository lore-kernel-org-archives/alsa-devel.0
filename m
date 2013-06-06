From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/2] ASoC: WM8962: Create default platform data
 structure
Date: Thu, 6 Jun 2013 14:26:44 +0100
Message-ID: <20130606132644.GZ31367@sirena.org.uk>
References: <cover.1370518627.git.b42378@freescale.com>
 <7e99c1946386e241854a3d7659a7a6d4201a5b34.1370518627.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4995267095246473153=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <7e99c1946386e241854a3d7659a7a6d4201a5b34.1370518627.git.b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============4995267095246473153==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LgjTlQw5wen6foCl"
Content-Disposition: inline


--LgjTlQw5wen6foCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 07:38:45PM +0800, Nicolin Chen wrote:
> Embed a copy of struct wm8962_pdata in stuct wm8962_priv
> so that there's no need to check validity of pdata any more.

Applied, thanks.

--LgjTlQw5wen6foCl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsI4RAAoJELSic+t+oim92ucQAIk610XHoIvdWLP+X7WXO5x3
JnCt+SqWYRbLsHMGlGOb8CQXWKsr5KbN0rFQtDIzdpBb6Zv41HUvBA0CFf6uPP31
/v+1RBEHzu2bFZk9EmOrHfG5aNxeZ9HlDSWIRw3KoMo9y/BJ6tI9DXflhUaRVrhE
Mtj2qXVWagjQ9GyCRPGRLRHWJQLzep6WMvjcnHFbQPmxgtC3tenENw9UyJ6y/8Sb
fSVe08UXMHTzaBymoVzFMeCG/hqxnQ3XWQ3H1c6iy+4T20dRSOFCd8Mn52/z6sw6
3VDmSQnsNjzFHxiQ2OwZ/2P5t9vDP3UYiRH3Z67aF/at43NFY1U4O0XLUJL2e3s6
L4X5dYqPlqBOIzuHnvm7TJEiH+ZjOxc1XC48tw4ow0mThnvSmvBvI5rROtUsRCDJ
lUVItCM35brX8EQIk+5xDuaZ+CuAyQoGnPefpbK5hzq9BRGBNrj8PoT5xU33PHJ3
kJyIAPvVf6kOBC0EaoJiQ8mrO/4ddLu1r/i4uE7Jyl25N1cCT6BylmARTH08j7yV
z+H2pXXdBfwabQNm+Uui14lJisZR7ITv0CVhvo86/35CfLEpTHGYZ8UBj4OnWqLA
Tpl37Ac94nBEw9o6d4XZOpaDttxhB1QqLIV1+E6KGDARyomw0EnR/Fz3fB4/WUFZ
6psCyGbnbFwRCrhOmmsd
=clt7
-----END PGP SIGNATURE-----

--LgjTlQw5wen6foCl--

--===============4995267095246473153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4995267095246473153==--
