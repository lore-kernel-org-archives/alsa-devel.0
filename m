From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/4] Revert "ASoC: codec doc,
 tlv320aic3x: Add tlv320aic32x4 as compatible"
Date: Tue, 18 Feb 2014 10:28:48 +0900
Message-ID: <20140218012848.GT2669@sirena.org.uk>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5215452525972605412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EEF6265086
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:29:19 +0100 (CET)
In-Reply-To: <1392631460-32002-5-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5215452525972605412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="flpRHSNNLnUanxKW"
Content-Disposition: inline


--flpRHSNNLnUanxKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 11:04:20AM +0100, Markus Pargmann wrote:
> This reverts tlv320aic32x4 as compatible for tlv320aic3x as it has its
> own bindings now.

Please use a normal subject line for this ("ASoC: ...") when you
resubmit the series.

--flpRHSNNLnUanxKW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArdNAAoJELSic+t+oim9xLEP/jz3Osy1msX+b7nhh3geNpvc
VMx+D9BNQ4yqfgaeodVliv/MgDX4tvcXd2Zsqohlac0n3OR6D1WQmUXDbR1cVBSl
psYTi1I2jagC/BBw7+WDzpkpzAgdxb46kjrEj8XWsfAgvO7si6mLW7u4mCyWnKzm
BgVokH0XWXBestsu5tK9O0e85ExUUG/XWXTnapOaFDtrcagWWbeh1Kjs3V9WB3RP
jZb7WSUv/hhfn+d5u0uO7k53mALzaoDr4FtoHlhHIir3Cp/WZgtBVCUb9D3R+QT+
YY3grtAmrTvfnzzVaaPpsyVDHpQYs8FwMtNKBmsX77SIK5OydfWc3WxWVcYi8lHr
wnO4mid1gG5HGNOi+kGF+wm67p7DakMdKzN2tDo3mtw64Tjbr9tldeyusYG6Aost
VFAmMgztR95fQF4WqEdmiEb7oaCgx95ZHLgsYbpXEnB5/jZDRXX+x0/UvSkPkNcw
X6YFBPuG7SI+aVqnQQf/AKgl57dRBVRSg3ntIk7WYpsgaKCxDi4A5Af177QuNwFl
e9jp/ez9etOyWP2cSVgSML9soNZ9so8lh9ergIQWgIusLvv0D4sL6zpZ3U5IaAgy
2GET4ahPkpis7+PY27AarvWGqnGCDWKg4j9/Co2Gva1SrRn8g2F2bcF7cP9TXtsu
vd3CNm5/9jdObnAh4USV
=lZXY
-----END PGP SIGNATURE-----

--flpRHSNNLnUanxKW--

--===============5215452525972605412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5215452525972605412==--
