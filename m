From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ALSA: topology: Export ID types for
	TLV controls.
Date: Wed, 3 Jun 2015 19:23:00 +0100
Message-ID: <20150603182300.GS14071@sirena.org.uk>
References: <1432922775-6583-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432922775-6583-3-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7504429539019247432=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B64B260703
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 20:23:08 +0200 (CEST)
In-Reply-To: <1432922775-6583-3-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7504429539019247432==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kz6eUT30PReluLpA"
Content-Disposition: inline


--Kz6eUT30PReluLpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 07:06:15PM +0100, Liam Girdwood wrote:
> Make sure userspace can define TLV controls for topology using the correct
> type numbers and channel mappings.

Takashi, are you OK with this move?

--Kz6eUT30PReluLpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVb0YDAAoJECTWi3JdVIfQ/hQH/Ahli0bHErfumPI0L868NmnR
torNjMM222mlkUGSUzMgWJCBa6/feBvDJXRPQiu3Ux0P5jlBgUPRvFZeRHqqZCvk
pVlG8Xq3iR6L7mTpUTntrbyv39MPUQ2arUKcVh4pIVsbov6wFVDVE5XYh5YoFuOM
XnXiHPqNUI5bd95e+NsWcJwncBbkzL52tvs7uVd5bgMohZRcl1SacdKSGpH+hZqN
L5r57iIJscKj8FNLGMd0EXLglrv2G5Wj9szEk0rbx/K8BYOonGRFQSvhS06dyCIx
XJlcp38Vsr5n+diepQ8J7KG9FlzPesSIVSUqYIXSV3Q36Z+H4ZzyMrwM0Y0PrTM=
=34BY
-----END PGP SIGNATURE-----

--Kz6eUT30PReluLpA--

--===============7504429539019247432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7504429539019247432==--
