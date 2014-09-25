From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8741: Remove unused wm8741_suspend
	define
Date: Thu, 25 Sep 2014 16:18:01 +0100
Message-ID: <20140925151801.GW27755@sirena.org.uk>
References: <1411654770-6511-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0545171380017921610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77818260458
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 17:19:13 +0200 (CEST)
In-Reply-To: <1411654770-6511-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0545171380017921610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaepPZQT0uxAV0NY"
Content-Disposition: inline


--XaepPZQT0uxAV0NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 04:19:30PM +0200, Lars-Peter Clausen wrote:
> This driver has no suspend callback.

Applied, thanks.

--XaepPZQT0uxAV0NY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJDIoAAoJECTWi3JdVIfQROwH/igTMT3806XMrVqL3KmVeoTB
zmMeDonC0rumibH6zFyAjBuVw7/GMrk/vPDfUEyVWBAzyafy8nuCzh60OuC8IOIS
I3Tj2O71eS/Tq9qWYHaJLNE8oa2FiBriMzgsUEN/FNqqamVVDK1BE+QVdT+5TklD
PVYDyUlxRnUSdF5IxFXzrHsqdMmynZKLBNEvm4ZvFEt81ErpSloCymgtM04bCPeH
pAhX2sxswO8ffcguchI+7plOhSwGm8p+bNonOvILnLvw2RzJg4RUs93loBWg+yEI
Y+nKmnrnGV/PXu8qFiRGt1r9rq5cll6EY/QSBTE7BHm3DMWPKTjYEg26PBZBEhM=
=SfhZ
-----END PGP SIGNATURE-----

--XaepPZQT0uxAV0NY--

--===============0545171380017921610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0545171380017921610==--
