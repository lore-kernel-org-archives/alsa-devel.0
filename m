From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: delete dapm_kcontrol_data
 paths entry before freeing
Date: Mon, 4 Jun 2018 12:00:15 +0100
Message-ID: <20180604110015.GD7536@sirena.org.uk>
References: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
 <20180604104541.GB7536@sirena.org.uk>
 <e37bf559-b040-db34-6273-d4f8ea1e2284@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7229816102953665368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DF04267892
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 13:00:17 +0200 (CEST)
In-Reply-To: <e37bf559-b040-db34-6273-d4f8ea1e2284@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7229816102953665368==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2018 at 11:55:10AM +0100, Srinivas Kandagatla wrote:

> I agree, Do you want me to resend the patch removing irrelevant sections in
> log?

I didn't actually apply yet so yes please.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVG74ACgkQJNaLcl1U
h9AQ1gf8DBYRwcKrIj7qssKEass48R9qjvB6z6chkFIwZS31AYXNPBvfFxIqNpbP
N93H9yvYaAwCAuXIca9gsquvByz427etse9yOWqY11HVnJ5Jyby1KtTksc4N9xib
so/C/64xKWeA1y2CFgwg8drPznjEM8hs/8ptgKxsVi6gNvmt56H3+xJzxw8A7M0A
wpizIOgQyLFnsKJzlf/rFby/AldR4evSwNhsfRwBuOSNxcWVHf9EGFlP/TMG8w0z
gb1HkKaH40x6nns6Xpu74gwbudznofP/qvkMYSM2VWlBZQreZK8MM7ahyoGEt8h+
PUp2Ner7CDP/5OU0AnTkb6+AJlHkVA==
=Frk8
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--

--===============7229816102953665368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7229816102953665368==--
