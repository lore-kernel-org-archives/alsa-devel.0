From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/8] ASoC: Intel: add function to load
	firmware image
Date: Wed, 11 Mar 2015 12:54:33 +0000
Message-ID: <20150311125433.GF28806@sirena.org.uk>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
 <20150310203837.GO28806@sirena.org.uk>
 <B51200AC81AB024499A3C2C9A1BB90A8373CA7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8295060426302167196=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06BBC2651D5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 13:54:38 +0100 (CET)
In-Reply-To: <B51200AC81AB024499A3C2C9A1BB90A8373CA7@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lu, Han" <han.lu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8295060426302167196==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+WIyXkGFHMyqo73g"
Content-Disposition: inline


--+WIyXkGFHMyqo73g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 06:48:51AM +0000, Lu, Han wrote:

Please fix your mailer to word wrap within paragraphs, it makes your
e-mails easier to both read and respond to.

> But didn't find conflict. Is there any mistake in my operation, or
> could you please share the error log so I can correct my patch? Very
> sorry for inconvenient.

I've managed to find the dependencies and resolved this, applied patches
1-3.

--+WIyXkGFHMyqo73g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADsIAAoJECTWi3JdVIfQt4MH/Rtjsym43fAMV1S6tDYi/tup
w3S2zZkeVkI14gikKOj8ypVXtEVFIyf/FZp4K9q9KSokE/GoM8NdkZSE8CSK5Ecd
gh/0EapS3u9qKT/UIENvufEB9dRP2n+w2oqjP12zmqqk2P0ZR55ovdYV0IqCRFq2
yKdl3eRZ1xV855LHqpsPD23SOi8X28y79Gqh4sO/8qDEGY6F7Zzha3XbJvKyq276
6LgJEGSEmMjbwhy0uPuItTBCB8mLp9Uv4kxn58xx6tcGS/p/kWaAxsdCYKsWjJpW
ORleU90S9OnfyP/MkYTXxWj885xhUjQpJ48cgM8rfpPEBW1HgAmwNoC1D22l3dM=
=CL82
-----END PGP SIGNATURE-----

--+WIyXkGFHMyqo73g--

--===============8295060426302167196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8295060426302167196==--
