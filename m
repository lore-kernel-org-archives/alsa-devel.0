From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v6] ARM: DTS: imx5* imx6*, use imx51-ssi
Date: Mon, 17 Feb 2014 10:27:48 +0100
Message-ID: <20140217092748.GA9197@pengutronix.de>
References: <20140118083840.GD3430@S2101-09.ap.freescale.net>
 <1390220023-6423-1-git-send-email-mpa@pengutronix.de>
 <20140216220827.GC31006@pengutronix.de>
 <20140217012643.GA9879@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7997691955969283971=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0BB9A261A8C
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 10:27:56 +0100 (CET)
In-Reply-To: <20140217012643.GA9879@S2101-09.ap.freescale.net>
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
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7997691955969283971==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2014 at 09:26:45AM +0800, Shawn Guo wrote:
> On Sun, Feb 16, 2014 at 11:08:27PM +0100, Markus Pargmann wrote:
> > Hi Shawn,
> >=20
> > On Mon, Jan 20, 2014 at 01:13:43PM +0100, Markus Pargmann wrote:
> > > imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> > > reconfiguration and needs this for correct interaction with SDMA. This
> > > patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> > >=20
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > > Hi Shawn,
> > >=20
> > > Sorry for that last patch. I fixed it in this patch.
> >=20
> > Ping. Should I send this again after rebasing it onto your latest branc=
h?
>=20
> I believe I've applied the v5 with a minor fix [1].  I split it into 2
> though, one for imx5 [2] and the other for imx6 [2], because I have to
> make my imx/dt pull request small to please arm-soc folks.

Oh thanks, I didn't notice that you applied v5 already.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTAdYUAAoJEEpcgKtcEGQQMa8QAJx6FMzlL8ZT2aw1VZvys+JW
R5pcIRvtWu5cuNj8DytsTxQj9l9z/wd/aiU6+tJsLC2NFCQMDd7A1FCnOyRBrRQ/
595Vj65VDE1D3lQpW6bB+tmxpUAHIgHLeaIfiqEhSWJOc+elFwIWhLOvp3hRw+q+
kosh4aCHE9k4HyAw8yv9YK0dxeNdKHEWnofDCwPd6WujRz8n/NQWPzlL81Iomctt
NesZJdcekDg9sXp8uk3YD/UuivfM3rvPqJ0d4hHqahR7sC2h0UI7FgTGluV7ZzVv
kXV1SEy63nNJqUP6UQwGXR/HR6jSyOYxxtw6IoAtB4uth1gdB/dyVqC0eSa6m20F
RlR2oUEuzX6o89AUPRF6Az/rDTRQUItUhqumfNodzQ4pbwlnJu6YPFzgb0j9y+dO
0uIZVZuqjzeqW+nSCzMm+5ApGBJ32u62/FgOHHRbEDO6xf+oRu5CQ/UokT+8Db+v
IXzqX8uSC20sK9h4dv+3aMxAQ7B+ABzqcnhqF9rm7EF2qFb3BEirZ7ntDWgnI/Cy
wJfeA6HUNx8W2wCCaSV2KvOfF1I/76rU+bao5NhOyrV+RHJkQNETGPgKJ6wpbvrp
iEtB1KPgDPB/8ayWM1P3zkQ+Y9s0iwzIN/iCVRt4ae1l0finNJ/y4Cw0Vmak7w5w
78jN3xtsJuQxrXLgqZfW
=bdFZ
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

--===============7997691955969283971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7997691955969283971==--
