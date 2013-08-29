From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v12] ASoC: fsl: Add S/PDIF machine driver
Date: Thu, 29 Aug 2013 13:15:41 +0100
Message-ID: <20130829121541.GY10783@sirena.org.uk>
References: <1377662686-31696-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1142376355657699056=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BA62E26550F
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 14:15:50 +0200 (CEST)
In-Reply-To: <1377662686-31696-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org, s.hauer@pengutronix.de, tomasz.figa@gmail.com, rob.herring@calxeda.com, p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============1142376355657699056==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dlFvqfizQ5ooaSx9"
Content-Disposition: inline


--dlFvqfizQ5ooaSx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2013 at 12:04:46PM +0800, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

Applied, thanks.

--dlFvqfizQ5ooaSx9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHztqAAoJELSic+t+oim9qEQP/jFayl5Tl6OcYz0p/4MyMs2G
zbTHT2TMdlP6AlyVI/JYgNpcQbVLwdUppL51xtW3WF3G907ymD11FxV5lunj7JsW
QHJ1OQISn8yiyECma/fvhtSbzitsdz0XR64L1b1GTJvcXmaMBLqx+m7xlYlG1guY
cEcg82RoF6OkGUtC6hEIXvzjWidGTF3NQk8l/0NpHp14mfK89WJdBGNihmcflM9U
BvqvV94Mz04EW9+6BpKdBoyyZ2XaqmtA/07+tK1CIDJF279bBtUm/TDNwdj5F+l3
e24nprKj4kP5gdNrBTfpU29ub6l7lPK/l7grH8o2tmv3icn3VI4JbMH4LnhxqvC5
+7xTVCKKHFNGl6BBEZk/9NEcUhqTuyurOApsez3xxaYxsZrY03wiv/JFQSUjYlrD
QZtruaF9XrBuNX7GjikDt4CYRBN3V2uWBYRFXAO3/evKzpyDk3RSlX7iy80ZEZUu
SSSOFjjtFWdXyQ72qho8W1LcO0K6hlHghljzlnpOgxbNhIwnt+3UCweZ98mj2Wn3
QOi84neVP6GA3CPY8Mf7dZKL6ROg0QlrNWXHsypdnMDSLBq8mWYWl+DG6X0Nd0W0
UmFzjrOs0rSFQoGr2NkoIGgIZkw3ywHy7tAT1qftESzwz69KP4t/AVlLDBo6ayZM
ZQjXAskUVp1N/awbZzvx
=vaI1
-----END PGP SIGNATURE-----

--dlFvqfizQ5ooaSx9--

--===============1142376355657699056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1142376355657699056==--
