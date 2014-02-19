From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Add support for
 multiple machine drivers per platform
Date: Thu, 20 Feb 2014 01:42:23 +0900
Message-ID: <20140219164223.GY2669@sirena.org.uk>
References: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3081768349903784724=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D98A26568C
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:42:40 +0100 (CET)
Received: from e0109-106-188-144-10.uqwimax.jp ([106.188.144.10]
 helo=finisterre)
 by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WGAED-0008MB-Cy
 for alsa-devel@alsa-project.org; Wed, 19 Feb 2014 16:42:39 +0000
In-Reply-To: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3081768349903784724==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHIpmL4a+UjiyldO"
Content-Disposition: inline


--UHIpmL4a+UjiyldO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 04:35:58PM +0200, Jarkko Nikula wrote:
> Initial implementation of this driver focused only matching SST ACPI ID
> with single machine driver and same firmware file per platform. It was known
> restriction to be improved incrementally.

Applied, thanks.

--UHIpmL4a+UjiyldO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTBN7rAAoJELSic+t+oim9iroP90VkA6OJcuVK7vKRWftmMG5M
ZBv63303pIBVJBnVMkPFx0GAlKgIocRAMIKvDXx5TZG6kRSuyxTmIFErPLWTDLyC
QYad0RKClS+V1jQpck0fI0+T42Mfnh6TwW55A19gBWzm95fEZT7KAswchDt1epKr
oRfJDve3WV1QSuObS6A20d0q8ZV7BbobSoaG3DmJW33Q+zXRxvCEd48GXlDQYCAy
udl+5bC4CqhHTehg+xXojRdmi0BpaM9ip6fs9vwLJoHkZSz7KifDXSKW+vtorW6G
iDqJBl+etini/MgwSsJzhHBreDspbDsejUglom2Pou5H4pVc+4G1RarklhdpeR0e
lmL1C29aF56IbAli+S+TM6Sqh3BIZJqXCErpT0oMLt2fLILMO8gVg2NxTzO5B6ic
4HPC5FJpDxJAB9scf+u3PWrCIlUH160IzFYk+MjJ0Ac9uiJ76qyPMmkbbXuFYp+d
LDiwgjlhmR+AEA3dXgNLqrnK2ASHgYjOYYfdJXKARFhKFXr19wkC3ol8Ms7p8CbQ
QFvNfeFJd7BdxvzbeAdrMpfDG7OkqpQb5lL4HRX9RjaGMvUr+4IUfK6G6LOWjDhu
Z2IAZ4WMZJuspFBwXar93CMeDZgRyRa6K+jQcKM3p6cwhuIF2RcUbPdcj5mWyPO8
VD/S8BB3MFDVhJ0/T9s=
=WTBF
-----END PGP SIGNATURE-----

--UHIpmL4a+UjiyldO--

--===============3081768349903784724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3081768349903784724==--
