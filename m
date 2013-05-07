From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: fsl: imx-pcm driver cleanup
Date: Tue, 7 May 2013 14:41:19 +0100
Message-ID: <20130507134119.GS7478@sirena.org.uk>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
 <20130507085358.GA11012@S2101-09.ap.freescale.net>
 <20130507102701.GA12650@opensource.wolfsonmicro.com>
 <20130507111620.GB11012@S2101-09.ap.freescale.net>
 <20130507113441.GR7478@sirena.org.uk>
 <20130507120638.GO1749@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8812511093962365863=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FE826505A
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 15:41:26 +0200 (CEST)
In-Reply-To: <20130507120638.GO1749@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8812511093962365863==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b2ktwntdbf0dPnbx"
Content-Disposition: inline


--b2ktwntdbf0dPnbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2013 at 08:06:40PM +0800, Shawn Guo wrote:
> On Tue, May 07, 2013 at 12:34:41PM +0100, Mark Brown wrote:

> > The important word here is "contentless".  Your mail contained no useful
> > or actionable content.

> I'm asking if the series looks good to be applied (presumably for 3.11,
> since it's quite impossible for 3.10 now) for applying, or there is
> anything needs rework.

I'm certainly not going to look at it till after the merge window and
given that there's at least two people trying to work on the code at the
minute I'd at least expect some reviews.  In general if you think
patches are being dropped then resend them, if things are lost they've
probably actually been lost.

--b2ktwntdbf0dPnbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiQR8AAoJELSic+t+oim9xwkP/Ak3jOwdpMahcNKHfil73+2K
8+Q/KC9L11y5i25nXrGANy9J6N7NQ+S7+b0TcCDRRrZV4uKbu0nE0cENJy/0/m7X
NH746vpAU/eH+S59Teap9/5l4yVjlMTQCdE/TffdC4gfOknUo9et/IxU0H/wW8C0
upDo50nviszrrF7pTNK70kQbLYt9EobGlPfxFAN5r6vhTlOv8chinuGX+XEwgXbI
vnA3273X7TA8GmBXDGe5XVuGvZu4DkJ2bLoOltTmp+Kb6/F+xRCeqcqAj7K4iY3c
w4MYDOfzhIUcyja2xOJiOqFJWt+f8CodmFuNmY2/Yjd3HeD135XyitArCvYU8sNU
YqeRBSrWu8RfM+OwLnfnSsdta/s8D6LVjhzh6Hpg/+sczp9sS4FL8tRPbqSFSBTR
/afPRs0z4QYMloxHTgGQw7UL40X/yBbPNbaemnndpFJxKEpBRH8FJHOJq9jf68t8
xVxj9Om2cXCyz3kivesp0yARsDvvV9yn7fgypZWzM47LejYhwsLAe7+259V2OwAb
ryZad8HzNNq821ii5g09Vr9oX8S13YI9+Eyav7ei2SHZICV++3jQqSo7Nf7+eWBD
nEo1gNo52BB5dqPswPhzvXEbtts19dThK5VvS83PCqhjSEIF6pqqYDnHRNfGC9iS
v53hy/9v7AKyaL+0MC5k
=gsLR
-----END PGP SIGNATURE-----

--b2ktwntdbf0dPnbx--

--===============8812511093962365863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8812511093962365863==--
