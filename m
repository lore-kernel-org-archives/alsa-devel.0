From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/12] ASoC: apq8096: Add support to Analog
 audio via WCD9335 slim
Date: Wed, 25 Jul 2018 17:24:55 +0100
Message-ID: <20180725162455.GC6315@sirena.org.uk>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-13-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4212930171213953266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E901126774A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:24:58 +0200 (CEST)
In-Reply-To: <20180723155410.9494-13-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4212930171213953266==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:54:10PM +0100, Srinivas Kandagatla wrote:
> This patch adds support Analog audio via WCD9335 Codec connected via SLIMBus.
> Tested it on DB820c.

This looks good as do the other patches I didn't explicitly comment on.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltYpFcACgkQJNaLcl1U
h9AYRQf+MlUMS9lvwVmMrSYMa3FS+HFCLO01K7ckUMy9KOIoYIzpEnhXlK7NN2dH
aIjGIBNJcYBrKlzQTg859xt9XX2LE+lnxwVPIF7lPz/czeIPsYkCdg28GtzEDF0q
RGK1yc6yBoNjIOpQtpu7KSdGlz08Ve3YcfOqZvT3CLyvHqwol8ath8MJuBKOsIu5
susi5HEu9xeLH4/MSviqja5VDmaqQGIMes7mlJPa99GrjWWNCbrabv1MVc3JGwzF
4qgv+xS8wjnQxvXRY6hWQGBOK0wMRHaECdLVS2aZZ1Qjrp86TGFSvsHnIWcK83Kh
gcaNIBmlVZxTmUgObR4oCrXErF8I8w==
=uYAY
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--

--===============4212930171213953266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4212930171213953266==--
