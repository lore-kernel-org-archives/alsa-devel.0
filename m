From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/14] ASoC: Cleanup dmaengine PCM users
Date: Tue, 26 Mar 2013 14:18:12 +0000
Message-ID: <20130326141811.GB18316@opensource.wolfsonmicro.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0869141538701416144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2635D26509D
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 15:18:14 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0869141538701416144==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MvEh5MSbieV/1Yst"
Content-Disposition: inline


--MvEh5MSbieV/1Yst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 02:12:00PM +0100, Lars-Peter Clausen wrote:

> This series cleans up a few of the current users of the dmaengine pcm lib in
> order to make the introduction of a new more generic PCM dmaengine driver more
> straight forward.

Applied, thanks.

--MvEh5MSbieV/1Yst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUa4SAAoJELSic+t+oim9+vkP/0wiIIeY5BzfE92a0S5e4Nry
irMp6M6pcSoe1S0CyiwIp9LdgF2ccMDTEAadjblFhM8CIuRgph/0HtxjYTgzQHpB
XHWN9lkUTJhrHsNWNUFQ7illE3Af0dU+uMJ/fjY1eXnlz9mPVHttOedTjZmsMfng
WIX4OI33G86AIhmDlxmtsglr4+svWRDCXiJetYs0Tv8ZlNbYNTJ5FKf6zmKz1Myu
15aucX6VMdtjM+c4xHTnBkmfAGHYbR3ffY6ycA5Q++YUlSOH1VRYbBHjKfgW2ipF
aEiVa4clQ7ombLzNREK5+X91Hy/YQaGN8jWy8WJpLxnpKi5ncP3ySfmLG54o2Wc7
ZVxMUKmBK3INJFerAo0IKX5Ebn+mOGIiJTLPFkcffkM2P96RJUTxWvCJ0VZL3SJ7
6ak2UIpfkp9QuixNWGf0I7flits6Ty0Yyu7uYe5x+k/LQHUhzW6Qc9x9CMnDGfBF
g1aNx3mqE26FJlar0MH8u+O2OkACAwb019LQXwyhNfFKmwUeX81qXuMRn9aM4kMP
RvoYdeXyKo0G/3zxBhGxiHkOblDO0KRkHPVRdnJDaxJkFxlbUGXJpqXHZPfaKn1x
/UOvvh5RkQhbt0ljrjE7H66At8cNCtJSYMyFI60cwCZRLagH1oe/Odr/gD+MR5Qz
R3yhxJDq2R8TlONqArq6
=L6ji
-----END PGP SIGNATURE-----

--MvEh5MSbieV/1Yst--

--===============0869141538701416144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0869141538701416144==--
