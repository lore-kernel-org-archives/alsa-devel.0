From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: reduce power consumption
Date: Tue, 4 Nov 2014 11:15:59 +0000
Message-ID: <20141104111559.GF3815@sirena.org.uk>
References: <1414738336-17371-1-git-send-email-bardliao@realtek.com>
 <20141031110851.GL18557@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70101E1B3@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5377464346216399242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 398952607C8
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:17:23 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70101E1B3@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5377464346216399242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEfZqDS1MPR2ysog"
Content-Disposition: inline


--DEfZqDS1MPR2ysog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 05:18:19AM +0000, Bard Liao wrote:

> > Please also fix the comment style in this driver - spaces around the /* */

> Do you mean something like:
> -		/* power LDO1 */
> +		/*power LDO1*/

Other way around.

--DEfZqDS1MPR2ysog
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWLVuAAoJECTWi3JdVIfQCh0H/RanYfF64CGJ1PSxiTAztxv4
CNEf4qr2UqwsaRgP1WOpKH4ta7XpRXL0nV0dHWLVCWaQMIWdqShjb7phxmvC55mQ
AZnI5kvUx5qDgZnf8GAwYSRxkYgZU0xDaXKcxwxBMyhW/D1RaNuvdzHBSLzZHEZm
sNvqusQvLSSoMbAtJYdy9u1NuKuuqfqBC5OW49pla+AbPpmFN0pxjmJuaJWI8AvA
UBDv06jJh2MO4TMHG6Fj2LGZqKR/LWqlEl32FPtxGJ4g8vjG7Q9pcOBz8RpiIfBW
FROxVv95+2bh26+onIrMhh1d7kzqOonA68KpyPh+0EwUfN3+IdpAz5UTIk+iAQM=
=8X1r
-----END PGP SIGNATURE-----

--DEfZqDS1MPR2ysog--

--===============5377464346216399242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5377464346216399242==--
