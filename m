From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: ts3a227e: use device property
	api
Date: Tue, 2 Jun 2015 18:17:34 +0100
Message-ID: <20150602171734.GY14071@sirena.org.uk>
References: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-1-git-send-email-yang.a.fang@intel.com>
 <1432925772-117760-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3799209429060761254=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC604265300
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 19:17:38 +0200 (CEST)
In-Reply-To: <1432925772-117760-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============3799209429060761254==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g3W8FGNyQaC+nhss"
Content-Disposition: inline


--g3W8FGNyQaC+nhss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 11:56:11AM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> replace of_property_read_u32 with device_property_read_u32

Applied, thanks.

--g3W8FGNyQaC+nhss
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbeUtAAoJECTWi3JdVIfQdtcH/Ag0RcC8vPMe2uMBs0xd5faR
r0dMBfVyvkHaJ9DXkACgk9iLGKkui+TrBAaTEO/ZZSgYEAnH/RgAPSHw5WvzP30A
LrAkFr4tayMhKuHBaX2ITFo6MOj+lLRPWhXdQnvG1JTRbLT+/sDgpZZz+Nt1zBC7
fWwnF5ehaDurdZNRp7nDvVK22QpDB9hnMniLB3ksQeovpQMRq3uSt9RBp2lTYIfv
TQtluMRqbEhyHRuOQRPranNVjgY6jQUf0sOHFUqkhL3ADB9ZGkczKu8HOmcRXVFA
Uirp4RB5uHcLSh3nutAnu9hYqM50BnCVgIpB75REDhpyyUS5JBsGBR4yojFe9dg=
=PYnt
-----END PGP SIGNATURE-----

--g3W8FGNyQaC+nhss--

--===============3799209429060761254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3799209429060761254==--
