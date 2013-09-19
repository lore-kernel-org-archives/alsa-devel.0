From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: mmp-sspa: Use
	devm_snd_soc_register_component
Date: Thu, 19 Sep 2013 14:59:45 +0100
Message-ID: <20130919135945.GA21013@sirena.org.uk>
References: <1379394168-18507-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2511008768926183622=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B68826535B
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 15:59:53 +0200 (CEST)
In-Reply-To: <1379394168-18507-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2511008768926183622==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aa1lHgJENwUhkhu9"
Content-Disposition: inline


--aa1lHgJENwUhkhu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 10:32:48AM +0530, Sachin Kamat wrote:
> devm_snd_soc_register_component makes code simpler.

Applied, thanks.

--aa1lHgJENwUhkhu9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOwNOAAoJELSic+t+oim9AuQP/0BN1CWgM4pYzswLxeqHKXgb
ZHjMNjxLFFwFvczlEW9ziEVZ5OhrHT8ZAimF3/pAy9NBEZrf68Lzg/4MAmBYz88S
sKk/bmlIji5Wu/FfFo4ia+0r7NpwnoyqV+l5KSUM1OZd7VDoQfyz8yDoBk4fOLuN
IbXtD19eb4iL9BFNaCCjd0nttX+5xAY1n9cPJCxMtBdI8uTM5jwn3lNcPgFXBEgl
o4dL5ZTRcDJHC37druxtS5UbCo97lmH5lMxGYEmzTxJVLbs+Af4tpwlYhmjRif20
1fjZ5VlepVel+ay8ud69ZMJ7enlY4XZ8yZ2qRsuVQyaiRJQBN58a9QXt90g89cfc
x5NcWhu6m/9OGHOspzSoNbGD64TDg68VROoE1vxKMcgeqsfubRgsWEfkCho9W9uI
rzdAu/M1ui+/UxUfsUrUfnY7O8UFAkWFdYVj1cf8y+uPtRnWnaT2Qn/gx8C8dS3F
v00y01BIfIJhKSIF7yrtFN1wT+FOgU1BcvdcUj4g3lwlnijOViUQXLVXnitJFwHc
lJhHgQSiCdfc641JAHnOGfJKHcFM8kL79jQ7qWeiVp+Jd2peVp4WVVFMrJrHLMv7
cPTvYYJrXp+QvQJV8gMCsEzu06QBNW00gJ08s+kJYlt76Ao0Vvs5e6UoLVRhYvcm
LqHeDvCxNWB8bmSRSjNo
=iMae
-----END PGP SIGNATURE-----

--aa1lHgJENwUhkhu9--

--===============2511008768926183622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2511008768926183622==--
