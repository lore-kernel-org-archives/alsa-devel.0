From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: omap-mcpdm: Use
	devm_snd_soc_register_component
Date: Thu, 19 Sep 2013 14:59:35 +0100
Message-ID: <20130919135935.GZ21013@sirena.org.uk>
References: <1379393882-17769-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5575258692817320444=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D89926545B
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 15:59:43 +0200 (CEST)
In-Reply-To: <1379393882-17769-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5575258692817320444==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v3gsnnLXiLKXzTq3"
Content-Disposition: inline


--v3gsnnLXiLKXzTq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 10:28:02AM +0530, Sachin Kamat wrote:

> devm_snd_soc_register_component makes code simpler.

Applied, thanks.

--v3gsnnLXiLKXzTq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOwNEAAoJELSic+t+oim9S28P/2DwWRbVcWdkhdLHgfKI5VsK
Mz1/Xhh7yQWrxH4/lbpCVyhd/KQDTWINTeCauK13quV90TPFa1PKCsti8gUEu4Ei
h+eGJ4Hahcp5qtNz119nDn5kfLP52eth2WLuwQgRIg7s3B+46vI+mY1gH6kPhDbV
+yhARherDxC8lx0kIeQHik80aI5yLD3pGle6CCZOnVUHp1GxdXG9YyeRUTxWP7my
5QTSy49js6594sGZppXU0+SXUZZkdHindmfgQ7DQbkiFBq4Spl4MNDgVZoaS2sav
gAK99yTwPzpihSDp+GXsU8Bo6zKhSu1C1kyLtNz1ak33I0K8URuFLbV4qNQAG95a
sXqbTtWllhOGcHOY0wLt3y90qomsArsycgdh8S9nFDMReGcKCOsHxMG65+l18DUE
yViTuBcHTEJHqdLG2M98d2IHkxrcCyVplp/0Xqxh6sXFQQq77M3VFt1i6qYtGIdT
/qU9HJ46mipoGkg/tPa2+H8IV6oplKshHQgg9dlHJOU9kfbLkcT/ZTKcHI4T5ODz
Iz6G0125NwFM4725Rj/QIWgQT3QAMQlby/x/TE/HjPSOhyZAvCPwNV033CUY26mI
eZDKMDBN2iikcvpazqGTmnrMeIYsAtY2RSJbb1RY18ZJ+BdF3/L33RAtUqelmIvq
gtNAeyoFLD2qv/CSjVTn
=ey/b
-----END PGP SIGNATURE-----

--v3gsnnLXiLKXzTq3--

--===============5575258692817320444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5575258692817320444==--
