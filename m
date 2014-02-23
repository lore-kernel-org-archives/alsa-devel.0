From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 076/102] ASoC: ad1836: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:05:12 +0900
Message-ID: <20140223030512.GQ25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-49-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5644345501496430996=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB3B2659A2
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:06:05 +0100 (CET)
In-Reply-To: <1392723517-12772-49-git-send-email-tiwai@suse.de>
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


--===============5644345501496430996==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dxnEAhtYrSdC5MGx"
Content-Disposition: inline


--dxnEAhtYrSdC5MGx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:32PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--dxnEAhtYrSdC5MGx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWVlAAoJELSic+t+oim9NgsP+wcGbbujb7pOS0d+GOYdA+zm
1ORUjUirauVfBUptn8a/2h43jsf+EVqcTjy4qzvxeUZxtE7HNH2j+dd8Qrrehvkg
Iuh0/b5GOINucKI4oE90UxAgiygfS+tLez9DfepezdBXvkVGpqtRJwrfL4JxM/Ot
1GNbO1BilxyeZqVMrCqSeUnmrd6B5Vr2szmVcGU5EepLMrKQHMMBodI8En8ZR6Hu
SpNvofFLDbLWiTkNPsIddV+wMxA3DcEtULEorUFvvRBNQfUw0urNRndWpsPUKzn4
npVImFIfvsT02pqTnU7Dl5b883cQFADwTqm0rTCaiY/Rcm9FxJpk2NzvmHUIzsiH
lbCsyDRvUnswyVJOIexcqsT8HOd1QODGcUNCviGLy7UydfIASnyVFRGafHzTrex6
/tDfXX4fV5d+abzWKxiuunA9DQfT1v09Vcah60tMR/Rha3dDx9RW69CQTGE3lrEc
1B7gJjrarYxZUkXjT3RoekP1eCxEqU4/o9bE3Q1xAYMIqxjCmz/rYysVFksseBol
ethc/Eu6WXYbF6dHT/jhRDvQqgBM9eoKO7goGFKkpFwq5sAA9IWvaBwDGy3bpa+6
JfRjAJGZGtQDdd6UzvoJsvchCKBlo4aFb6kFbBimMeXIUY16kR8kX1jNynm3liTN
CeA0OAlH9Fx3f+6cLm6p
=aGKv
-----END PGP SIGNATURE-----

--dxnEAhtYrSdC5MGx--

--===============5644345501496430996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5644345501496430996==--
