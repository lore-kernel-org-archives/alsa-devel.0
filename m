From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: fsl_spdif: Use
	devm_snd_soc_register_component
Date: Thu, 19 Sep 2013 14:59:09 +0100
Message-ID: <20130919135909.GX21013@sirena.org.uk>
References: <1379393029-11711-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7423626727561067440=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DBB5265472
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 15:59:18 +0200 (CEST)
In-Reply-To: <1379393029-11711-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7423626727561067440==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jrD2fTATTFYrkNk2"
Content-Disposition: inline


--jrD2fTATTFYrkNk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 10:13:49AM +0530, Sachin Kamat wrote:
> devm_snd_soc_register_component makes code simpler.

Applied, thanks.

--jrD2fTATTFYrkNk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOwMqAAoJELSic+t+oim9Vu0P/j0K+18QvUPNyiRj4rY9ipkt
3SxnFR6AfpBwecV/sYGHF4gl+A7wSiy6PhuO6tLAfw9G5naa3mvU6beIiWuC2SrL
bxRQj7PVrzX6OWnTxHY0vX+lvlPQCMGjJGkln3nHmlqOJdD+r/8wqUzZM88ko6h/
1c6tiSf83BfW+mCy4cSl8tC57EL5Av4NLKEx61gCjNcCCJeCRBL8P0UfON09Muhr
3WwHxSyb+0MGDUgDWXW6K2vSK7TupYU0k33UomMN87wjnzem581s2+/hV5eAvXhw
93CptrV6SVE96BEKZz4UWAdBFtV3OXXCAlOiSiLDaeCGKCenvEY/D9AZ9Yzr15Yk
kZjLvhNY0/0GmfNrxm0ejSnAbx19vyytoQ4ikLCJOzGJTBC5aGoHbHKCSNQZ0YVB
dToG3cHu6llCg6qD+5cIqnyzVyQFmDZOFYTXXKUNfhLLQNus2wzcklRof1bVxzrk
4qSnKFB4akBidi1HXyBr79I9pSOiGWeoh+7n/aUG34CXyDdYIsEiL+Wyju4Orp89
G9uXi6jREbG1WmzXOexUf3TtAne5h2BYnPbS1otaWki/hD7VKhj4CG3AQrxpgMr+
D71GySHLgh9kk0uK3f+lj+pRdYIim6HzULL8BbnttrG5GXW5XT4Sd1NAttjJnIEP
3GLEEel0kuuqYRcrgGED
=Az8z
-----END PGP SIGNATURE-----

--jrD2fTATTFYrkNk2--

--===============7423626727561067440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7423626727561067440==--
