From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: SPEAr spdif_in: Use
 devm_snd_soc_register_component
Date: Wed, 18 Sep 2013 11:42:12 +0100
Message-ID: <20130918104212.GQ21013@sirena.org.uk>
References: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4081218621706733188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B711D260857
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 12:42:14 +0200 (CEST)
In-Reply-To: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: vipin.kumar@st.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4081218621706733188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6nFlVIU+yrLqGt6"
Content-Disposition: inline


--P6nFlVIU+yrLqGt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 10:41:36AM +0530, Sachin Kamat wrote:
> devm_snd_soc_register_component makes code simpler.

Applied both, thanks.

--P6nFlVIU+yrLqGt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOYOAAAoJELSic+t+oim9O3sP/1C69suHXmwVIzPSVTFnoEbB
a1diSz4nwBybh4BDcljNaFzQ1XKMBGH7IDH5l4mvefMaSVwCVH2UoTnTczaR0zNm
ZrMNNLXySU09L1BAGgkbdjKVUq58lAw16sOa7y4hebqYDhKi8JvZMwmMRTYBOcs4
ZBnFCAjFwqu4FxrAMMC17PV2hHWZZwOqptq5qQvJc8Zg/VWvtO/nCV2sY1Z6BjEC
MsyAVEXVdNuB9L2eJ4tvHjlg/Z4FwUCtRiV0NZ8kYIgoh3QOxgPJDSoj7Riv2aBJ
lT8BkHLh1s3NRyZczrIE1nyQ4VKhVIYaFwg/OzK6VQIQZA/ASZyN1MmCtUsDHa7d
/H7ibbXleJBcHoD2polWPVcbTTa76i306GPI6WJnxtOkCH74IKV2pRPylglFu+R2
5icRUe3LJK3lOjomOgeaGBa3KHTLggmHjGQgpyVkzaStL4vre3FGpFaPNd2NB3I8
9V8Nscie/uAbXmJKMmpPFIX8X15UdcjZNmwubheqgqvEv2AAyyyrhK+Ae3C1yXw1
OPthSkdhTMrbpg2laBZQKurWU+gbKXJLRXwLYdtbm44YehKES5X4OjXdDM5E40VX
rxUedvyL+r/YNRVZn2VKX8EbrIAt2ZjwZrAUi9CXgjlrRoWqPKmNWC36uURdm+UO
dhAtQNvgbjGUJrdpIkeq
=l99J
-----END PGP SIGNATURE-----

--P6nFlVIU+yrLqGt6--

--===============4081218621706733188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4081218621706733188==--
