From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: ak4642: Remove redundant break
Date: Tue, 17 Sep 2013 00:53:26 +0100
Message-ID: <20130916235326.GK21013@sirena.org.uk>
References: <1379067650-4362-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4316870322495530723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C779265074
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 01:53:36 +0200 (CEST)
In-Reply-To: <1379067650-4362-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============4316870322495530723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 03:50:50PM +0530, Sachin Kamat wrote:
> 'break' after return statement is redundant. Remove it.

Applied, thanks.

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSN5nzAAoJELSic+t+oim9StMP/2/pyH89Clo7ALnNakmtVISO
rCZcFGbAL0hXZpoYJkGlC6a7aKWT+B8IL3LX3GDDnUZIHiiBEF9oAvsQ63KoUbN+
AHkRHjaDA1luBxg/amsoaEHwN4T9zVbSH1AnEHNMDleOL6eKSjlClPhoX7PHj2jv
Aax66NYAb/SwyHbUDa+wfNDGtWsfAwZEA2JxukCVy4FGQZN5h+frTzvDsCKtbQTs
7gjuSf/jZM6mPdSCteJtgo01Z2ok2mInb9woZao1OWl97FFGaLTajd9RSGeGYpoC
vPWXsr0gU17QRrMxQPibgQF55sZJ49XUm/UZoZC6GNeUMkKY8TCHdMHBhUP8m+92
z9tIIKSMlBSPCh1g1z4uJG4L50J5RkSajbNbs7cqM8mKraEwCmyG0F4BH8GQGv51
l0Waeh0pLHKQaweS9d06Te7yHopjvmAQXWq2u3a6HeBDTX9grolGFNVwVz5VgVZQ
KbD4ioxOr/KErFtAaeeUSg19gMDFJ53TENWU1ymFENIVZ1L46nLwM92FjlWMdaeo
CTLgTnT+zN9wevPiW/EA46UWKdkMDRqBXDbjVd2fi8wOhpVZi67dv8tWi1/ty0u+
g5ob8o8PUEUwmKQyvHSAPZ+KvBxxAe+ziJL5NfC5wqnbWmLBkvmKi+l/Vsu9l3GN
vJzGEmq0mTCKCVFLX9Wj
=vNtU
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--

--===============4316870322495530723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4316870322495530723==--
