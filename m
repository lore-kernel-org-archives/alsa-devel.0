From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 5/6] ASoC: qcom: apq8016-sbc: Add support to multi
 codec.
Date: Tue, 6 Sep 2016 12:27:20 +0100
Message-ID: <20160906112720.GO3950@sirena.org.uk>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473155865-13361-6-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Aq6vH1t1JS3Uc7g3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473155865-13361-6-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--Aq6vH1t1JS3Uc7g3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2016 at 10:57:44AM +0100, Srinivas Kandagatla wrote:
> This patch adds support to multi codec, as the msm8916 codec is now
> split into two codecs, Analog and Digital.

Does this not break compatibility with existing machines (and require a
binding documentation update)?

--Aq6vH1t1JS3Uc7g3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzqgXAAoJECTWi3JdVIfQc8oH/128vgSJCuDNdaJC/M2clmpr
UHdsSEoKWsCF9Zoli3Enep6k+c3ow9UFcKQPf/4j0N4dvwZYB5sXaZjRWjE84mU9
BOGd4DdMvKKkL9FrqgEj0wtYoxhMWhybQexul11NOtVTXiIVeQAtbAtYNE4rY/x5
fpRLcWv62ahpYbNyr0AoQJ/fF4xMm2Pu3xyHimN/CBBr+cYk/W855RvuJh5ZvrsD
sWqY6Ml7mmt0olp9XZ2AXN3jRPvtW4sAtSczZDeI6ji80wUgQFjVtl9s5DVqm1zX
0hIgyKzA5SJgBcXPFNCcTLq6E+BPnumPI1hXexo5PkRl4o6WF6BQXJmwuO624MQ=
=x9Jl
-----END PGP SIGNATURE-----

--Aq6vH1t1JS3Uc7g3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
