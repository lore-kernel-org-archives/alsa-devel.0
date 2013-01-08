From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ALSA: pxa27x: ac97 reset fixes
Date: Tue, 8 Jan 2013 11:30:56 +0000
Message-ID: <20130108113056.GT4544@opensource.wolfsonmicro.com>
References: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4617568091742090951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 319632615C5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:30:58 +0100 (CET)
In-Reply-To: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4617568091742090951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e4Ac2VUIqaLF2Uxx"
Content-Disposition: inline


--e4Ac2VUIqaLF2Uxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2013 at 01:55:11PM -0800, Mike Dunn wrote:
> AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
> problems:

Applied all, thanks.

--e4Ac2VUIqaLF2Uxx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7ANdAAoJELSic+t+oim9iEIQAJ3Lo/zSs7d7P7TIVBPTwzTc
qi4ucQFcGUgjO5CopCV/Dy9j3agG1iBioplzHHKKN2ikDiFL03xJ5s2TyAllCkHY
6enqJP4I1xBi6aVwuEuQUU0IBajHZBPMjK/4LpYBih1Q6KMQ+abb72C3vlg9Gvcb
4S95SEBc6mFhDX9no/Yxl/IolD5xfJpca6G5cHXZtHoGanlC0LZoCsd/rB2G2oq0
/g0nHiXum1bPJX8q85oNhPsVnoWbC+zAPzeoZdHSUnqpflXiQehUbc20NBEUXo3i
BVNu00niQu57rnOKsZHfMHda5RsTWyFXntHSRwgaW/BEm+5cyWR249EMuYH8EUNO
c1UvbUkueCGNNuvMqlYZPUDzaxCyrHypTPcDLExa0qqRoa1/T9vFPRdV15Q+79hq
TRbyrInxCigr36DvkZS4YLtW7ETPEGsg0QyU4INKo/x2mp17mhFF2CgZE6WTkAoj
YM2qsTOHyHl0kneFh/eCZi/NxNDGaTDIMpJl5Df+YSx8pneUhHTH2wI7T/rIxysk
oZRV9VYMeMHDp19y8s2C1qGajYZ9G3TpoWL8q2I1+5oZBTBiakclDPee0HR48kCj
gLCSkt5n9Z6NGK0n5P/cuPcyyKWzj9sQRygnwnQI9d74hI0mRJeRdYJRxkARqvBX
lDOv+xFGT99ATmplr65G
=HrFR
-----END PGP SIGNATURE-----

--e4Ac2VUIqaLF2Uxx--

--===============4617568091742090951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4617568091742090951==--
