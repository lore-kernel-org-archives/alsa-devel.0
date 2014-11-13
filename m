From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: add register setting for
	TDM
Date: Thu, 13 Nov 2014 11:34:49 +0000
Message-ID: <20141113113449.GG3815@sirena.org.uk>
References: <1415843722-9003-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2398623972397812571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7633F260487
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 12:36:18 +0100 (CET)
In-Reply-To: <1415843722-9003-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2398623972397812571==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kw0rhxMYHDYgsix2"
Content-Disposition: inline


--kw0rhxMYHDYgsix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2014 at 09:55:22AM +0800, Bard Liao wrote:
> We need to set extra register to avoid a recording issue in TDM
> mode.

applied, htanks.

--kw0rhxMYHDYgsix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZJdYAAoJECTWi3JdVIfQk9EH/3twSCq+MjeToyL2R4/zcYRB
I88NTjJQzaCyw88Wp8VSqqly2AzNO3ePEMXT9hcDN42vAMV8GOXWhl1PO50fXcMJ
3veGAF3Zg/PfMyB+M49KO9cVfIS+wkTjIz7oceM54EWhFgI5ORl9AgStEnFk12ve
riF64TuJhFVSNo1nTN/BUCEgjYDTExPmcQuce3OcGCccE7+gIp6ywzX2zaZoOUqk
S1Liur46y8mYImTb1MxuLpCOeTLJbxXqVAu8FCrtAbuZ5kZxGvJ0tTeykNNyusZN
ukrtSQEHV1JqG/Qh4oXO33urvTYhkLEID3MWuUT8/hCGTxgUvnge8xTI4k883Go=
=P4Vg
-----END PGP SIGNATURE-----

--kw0rhxMYHDYgsix2--

--===============2398623972397812571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2398623972397812571==--
