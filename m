From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: dt-bindings: add dt bindings for
 WCD9340/WCD9341 audio codec
Date: Tue, 2 Jul 2019 15:02:52 +0100
Message-ID: <20190702140252.GO2793@sirena.org.uk>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0750215909845492992=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E525F80058
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 16:02:53 +0200 (CEST)
In-Reply-To: <20190702080920.22623-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0750215909845492992==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ABYnUdqoGSokwVM+"
Content-Disposition: inline


--ABYnUdqoGSokwVM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2019 at 09:09:15AM +0100, Srinivas Kandagatla wrote:

> +- qcom,micbias1-lvl:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Should be voltage in milli Volts for micbias1 output

milivolts

> +	Supported values are in inbetween 1800mV-2850mV

in between

--ABYnUdqoGSokwVM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bZAsACgkQJNaLcl1U
h9BVIwf/ZrtpTqroAjSIn8T3sZSlepCMggF2K9upRobeq7jZHedZ6kcBQpAj1Btx
8RAy15YOLrH16f8ANuYCU9lVEzXn+iwx7yURRlBlt2WJdJah2JjQfLHsIEtPQv8a
wTpKdzieubMK0F0goPA8LYKoX+biHEwZlj2Ud/nUGtW8Ay/n5ZcGFE0ACI2JREXb
N0AT32HtYpUmO1AJq93jo1J11nzezCvc9v0IxVWDHtGoD3iCuao/9n59JNzcLTBb
q+DvYVXqlYWTf2SZTln8e7DLS6Phl4Spte94fxn/d5YVQN2qXGHWNmEAlRPm8VCs
/vR7rdWcd5g2ZBJRa+ak8cJJndmW3Q==
=bP+8
-----END PGP SIGNATURE-----

--ABYnUdqoGSokwVM+--

--===============0750215909845492992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0750215909845492992==--
