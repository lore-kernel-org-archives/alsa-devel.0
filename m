From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv5] ASoC: Add support for BCM2835
Date: Mon, 25 Nov 2013 17:17:48 +0000
Message-ID: <20131125171748.GN14725@sirena.org.uk>
References: <528F7718.5@koalo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3062391100104055097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EAB261AF9
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 18:17:53 +0100 (CET)
In-Reply-To: <528F7718.5@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>
Cc: devicetree <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3062391100104055097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6AFz5yWxU/FsGPwt"
Content-Disposition: inline


--6AFz5yWxU/FsGPwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 22, 2013 at 04:24:08PM +0100, Florian Meier wrote:
> This driver adds support for digital audio (I2S)
> for the BCM2835 SoC that is used by the
> Raspberry Pi. External audio codecs can be
> connected to the Raspberry Pi via P5 header.

Applied, thanks.

--6AFz5yWxU/FsGPwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4Y5AAoJELSic+t+oim9xTwP/2H4HxBqj2l3uI3ZECB/qS7X
vA4P7R2Z78t8wol9zSl4RSxAOUT+qxgrVJmgTG2O1g9wA1MXrD+n2HU+VDzhXyAM
gM/fKCCmfMX2/5X/QXyA9h7N561Gu8OK0z87Plu+V6sDPgN4UKYNrggR7m/rZjaN
qVOPu8vQyNGyOwheh3uQRz2qcyFvubdPImhztpj5FYar6FQfCbnhXzBLSI7Eqh96
14ZU4k3GD3N+8C6bWBTPr0zRr6RTiDcNXqgKzyJ7QCQTK4FIZ2DRihumGRs0GMCi
ckAStfkEA7Axlrl87uP9U2K3Its0PKS7Ccrg/nHZpzymj54axTNCsJB7CJDcEyzV
tnTH1WixGE/a6L3KafSbmOGPJC7B66Va5+BioKwbKTO9Df0ouxlH5L403ynlu9/A
0u4OLlcVnpbyAiiu71jZCy1nzig66jr5twfOHG3C3rww5MJw+aF4UoIxdMA7R+ge
ILggcMowf60h+apV966yXpeymqnFZ5G16QlPVYMdYQJMnkleeEXFn6Ufmjy0YhY+
mAlFAjpoZydnHSpYAvgJU3VjIe6HpH9Mx/jhScn1c0Vlbnl+Pjr9Dn/pK046Xdit
7BPhAxXCLQEa5K5MXPD5q30T6eND666pEJEUOc0uJqSODWHvjZMJ/ks63L4ZuhFI
3U0BfyFugiwfg9pRgRsk
=yKcQ
-----END PGP SIGNATURE-----

--6AFz5yWxU/FsGPwt--

--===============3062391100104055097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3062391100104055097==--
