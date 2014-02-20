From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 035/102] ASoC: lm4857: Use
	SOC_ENUM_SINGLE_EXT_DECL()
Date: Thu, 20 Feb 2014 11:23:48 +0900
Message-ID: <20140220022348.GN2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0820175269276915185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8462B265708
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:25:09 +0100 (CET)
In-Reply-To: <1392723517-12772-8-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0820175269276915185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwZyQDcvxrekjiAO"
Content-Disposition: inline


--hwZyQDcvxrekjiAO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:51PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--hwZyQDcvxrekjiAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWcwAAoJELSic+t+oim9PtUP/RqkM8Dk6Lv8kF1HN4b7AqHL
OVYN2tP/eoGm7VFFsJH94E6w37ORLcrRHEAn3lnX80fy4Dq5hj1uJRuChMHAQL27
MNzaO6NcqVTkJ7puCl1+S5fvVppJnBCJ+OGVBAaJ2Oqr+Y2nxsCPELs5KrMTHpuh
jKiB4wkPubsvumeuh8pESMFt9pqeDYZe+iFjbgTu2HaiODkfOtdfPOX+F7RJDTiJ
jdVRex64RlM8Lj+DeizgiDJLSMj4qoRpGsO3n0liKYwR0hESINFZzlMFbDb1FG9m
kk1XiHn79sKqicMIeaOIYRoSBM89QPWEODSRC3xCzqf8TrBRwdjWYdtfvl0GikNm
mlgQxQATsIao0plT5sgeZwGJPH2KPD92zXMJPTKVpF1XwbW7ZhElfiSQ9nPCaKgS
08WISThxLUWmgfS9bAiI3cJU65AudluYoF0HNVKmsiL57n1alTSUTBLUcBalIbZR
SiFpA2P7gU1HHMCJYK7FKLSEcCCEI+5IBtlyxzxRmyHZgURU/HdXfG7z9fc7LbT1
FHa3VI/Fr+cqqT+VKnqbCqhp5JA1eneWBtUH92Sh9utXbdeG1fcTA2lvnOAjaQT9
+x3Qs5s9AJHxQdkgMcgpFcEPNGWbOp0jK48xZA+FLJK6wGcQlDtg/fYKLXByd4yR
R5qSRGNcBRFQMt1S8Kt4
=USY0
-----END PGP SIGNATURE-----

--hwZyQDcvxrekjiAO--

--===============0820175269276915185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0820175269276915185==--
