From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 09/10] ASoC: Intel: mrfld: Use
 snd_soc_dai_get_drvdata to derive drv data
Date: Tue, 16 Sep 2014 16:40:07 -0700
Message-ID: <20140916234007.GI7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-10-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5136531143401291943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A369264F22
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 01:40:24 +0200 (CEST)
In-Reply-To: <1410255693-6958-10-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5136531143401291943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0RrwLCq8kVvUIgaI"
Content-Disposition: inline


--0RrwLCq8kVvUIgaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 03:11:32PM +0530, Subhransu S. Prusty wrote:
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Applied, thanks.  Random cleanups like this with no interedependencies
should be pulled towards the front of the series.

--0RrwLCq8kVvUIgaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGMpWAAoJECTWi3JdVIfQwZoIAICYWzznUb5YHOnScCPRVi/P
TvzJGnXtA4sNBTGFaAD8ScjCllBS8cvzcD0YXSF0s5C2Ze32hMgTYLLsDZgxv5zB
1U0fGsFdRfY+V6ZL0TWxS1g7d7n4ab+bDaWi903fhuFHhTCFy1SBTCIljTWWAZfd
RwB16u4Az4v/nm0ozmeabvg2WmnrdJwibSmVb1lc8jNLksOQMdqWLhoMbDLBmvmV
FIUroLMhW46doTTMuZxEAUKGlw2X9JoqhCk5uMlzj+Q2XL3F0akQoWOKQxs/8tJM
LfnvnoDK6EVE2VOIqw8O3QWEUg70aJWvUoBLhHrDUt11MZjNI9tgSSkIYnpg2is=
=kXeX
-----END PGP SIGNATURE-----

--0RrwLCq8kVvUIgaI--

--===============5136531143401291943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5136531143401291943==--
