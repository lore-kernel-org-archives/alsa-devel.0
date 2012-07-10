From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add input clock
	selection
Date: Tue, 10 Jul 2012 14:42:39 +0100
Message-ID: <20120710134239.GC9409@opensource.wolfsonmicro.com>
References: <1341923818-8406-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0189917456589074127=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAC5824332
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 15:42:40 +0200 (CEST)
In-Reply-To: <1341923818-8406-1-git-send-email-jiri.prchal@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0189917456589074127==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2012 at 02:36:58PM +0200, Jiri Prchal wrote:
> This patch adds input selection of main codec clock - from what pin.
> Both registers set same value since codec uses clock divider or pll at one time.

Applied, thanks.

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/DFGAAoJEBus8iNuMP3dUU8P/26xQ/cN59FU1ruP6g4nOClK
6pWVNTCAd/ysSKXa9UjdVsOrLWxFEfZEF9quKfZNs8nGvYrl1qaNg9lxWBH+WvYn
BdK05QGcQKaD+IMkKKIfOHophMF0wsy0NG52jvz24qFgveZ/RQH7Tq8zK+xvE0D2
+4kWzCxI59utyMkdr8gp+p8EyX9jNLod8QByxIieUn9/5cVwyuKPbKMPzFuWjZTT
qqvr4E5S+OCfJLefkaMGpzUpbu1bqUWHGam5H8ZOgzg4/jNYZRBzaqC02B8kMJy7
CtVCggxz83OsWy/dYPphb2azdfdQqfB0iPf4Yu4CYD7vI3YSI73FGBxXSo8GqGZM
WBQtacyykojiuZLjd/WW2OwVrCrYz+aqKk1HGjdKnqCUVjrHAYFlgRhIymVzl6Hw
04pKJ8sOM1+vS8EEyZ2B3ksWBLoYerLFHGzKkmbfS/rmx7pQLZfalQictYZtq+u8
shRQrblLb+rdOqpVX9SZ1UbYpgdISiSZS0NAoXzYlakUss07JFfLQlfUpM7ohJdq
eKBtjOBb0UiD6vv1e8imJtVrEMY17broOV/IDLvrV3SpbPAmRdfWnWI/oppTnLmS
xbuNmxlk7IyjY1+jiSItmmeNoiDJZmK5hXCuQzi/eCxnF0hQGwLMMzSjDUznk1cG
UrEQxkaijoc4kMZGhrbS
=Gw5f
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--

--===============0189917456589074127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0189917456589074127==--
