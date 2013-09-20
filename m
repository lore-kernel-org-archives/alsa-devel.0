From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adav80x: Convert to direct regmap
	API usage
Date: Fri, 20 Sep 2013 17:39:47 +0100
Message-ID: <20130920163947.GO21013@sirena.org.uk>
References: <1379676580-19008-1-git-send-email-broonie@kernel.org>
 <523C348D.3050502@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4307128380209627295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BC4E265712
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 18:39:58 +0200 (CEST)
In-Reply-To: <523C348D.3050502@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org


--===============4307128380209627295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fcasAdn045BL8lzs"
Content-Disposition: inline


--fcasAdn045BL8lzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2013 at 01:42:05PM +0200, Lars-Peter Clausen wrote:

> I have a, in my opinion, slightly better version of this patch, just hadn't
> had the time to test it yet. I also have regmap conversion for the adau1373
> driver.

OK.  Any ETA for those?

--fcasAdn045BL8lzs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSPHpQAAoJELSic+t+oim9+zkP/R6nGmDu8GAPRfXC0OjITyiE
2aR9ig7ZEVpFSuwiKdc1sJvluFZJ1NrYCRk8kqIrmfHW9FhK2OxfDRD1nuWXuOD/
4YY+Urjv29vfZ44z5Yocck3UU5dXyLWdDzkFxlUkNdFgKYYPt8IQRrMIGtlOwe1I
a9Vwybd1LXGfgpRZnCMG6r+tlWn7qt9FG0Xu66H2zTbrHWumwFDZeEAV8pFyAIXO
MT62EJDAMbstlPeK3NUlWdFNcTfZmswVFw/FHT/UONO3BIDUeEAQVbZhIaqJaNLQ
EoiC3ZfWrDVNl02wZFhjLrhNaJRBcQGr6x5sAayAlQUmpuhtiBmycSnDr6bCESFs
if/Am1e6RD3267XcUCl518rg/dDBev8GEIcPrSHCc8fVGTdovu8SJ8DzLdbKgRZP
epnj7DYj/Pu644bMBfheMmnwetoPML4aY8V+toXgfD11hpwAX+RHymJXZEuFuWVT
8F0grwKUmDthqflbv1secM++/SCFKL6aKakN8t7FmRgsqJUxS5kIc5urKHMo7xxr
tBN9Ix7F/U839uaWa7pJQsCvETs/GFfCGziZZCdy3ZqIs7vys2t9dBygPWl8vhdm
AYPWlq0CqQD2eFAKPOAOhvQApQs1UI13+os8QhQtsXHyi2VFHByavYhSNJL4Kx7p
rQWrgAcq1tYQ0xeoUT/B
=lHgk
-----END PGP SIGNATURE-----

--fcasAdn045BL8lzs--

--===============4307128380209627295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4307128380209627295==--
