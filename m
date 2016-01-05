From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2 3/6] ASoC: mediatek: Add HDMI dai-links in
 the machine driver
Date: Tue, 5 Jan 2016 12:46:03 +0000
Message-ID: <20160105124603.GB16023@sirena.org.uk>
References: <1451934551-21333-3-git-send-email-p.zabel@pengutronix.de>
 <1451934944-24588-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7849707838631682517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A152606D3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:46:21 +0100 (CET)
In-Reply-To: <1451934944-24588-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============7849707838631682517==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="upHqgONuYbTeMWr5"
Content-Disposition: inline


--upHqgONuYbTeMWr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 08:15:44PM +0100, Philipp Zabel wrote:
> From: Koro Chen <koro.chen@mediatek.com>
>=20
> This creates pcmC0D2p for the HDMI playback in the same card.
>=20
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Please don't send new patches in reply to the middle of an existing
series, it makes it very hard to tell what's going on.  If you need to
send a new version resend the whole series.

--upHqgONuYbTeMWr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi7sKAAoJECTWi3JdVIfQd8gH/3i4VXFcM7aCWuovYanxYKz0
1VnDevaWiabBdLsTma0a55cKFyl1eWKjJI2DTU2EP7E5/cTMteRPzQgXOTegmeH+
4UGRaMw/yopUtXAJHTulWeAcbLTcIjsA65zBJgWxTx1AbPSYU+vctZcw6dIMnxmO
vz1sU47mggPBK7GVDxrPy0aFOfZVYcQ1O5o8fy8W+mk55L/x/w6rOc6rezB6ADIV
4Jnus62h09I8+AI30WLDoNenJoBSnqj9k0c9xksZWah486WGO4Bss4j7Jpdcb276
1ZiXQ+wBSyuUJ44HBjJTSW9FYYxcdIk6lCdpUNl9Ya/Lv1uTk0lyXiKWTW5dtRc=
=ktHU
-----END PGP SIGNATURE-----

--upHqgONuYbTeMWr5--

--===============7849707838631682517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7849707838631682517==--
