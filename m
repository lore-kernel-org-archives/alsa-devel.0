From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Staticize local symbols
Date: Fri, 13 Sep 2013 11:35:20 +0100
Message-ID: <20130913103520.GH29403@sirena.org.uk>
References: <1379065938-26728-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0238799758271044199=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9242608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:35:24 +0200 (CEST)
In-Reply-To: <1379065938-26728-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============0238799758271044199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m4G02V+VBfI/G6w2"
Content-Disposition: inline


--m4G02V+VBfI/G6w2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 03:22:17PM +0530, Sachin Kamat wrote:
> Local symbols used only in this file are made static.

Applied, thanks.

--m4G02V+VBfI/G6w2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMuplAAoJELSic+t+oim9thwP/1aahXlZZS2ywHRQZNDECiqY
rLR+qtbiRrcGiyt+tqeyPlb5FY9T/Lh1phfn6r1fu55+/kl83BKqqcHPBBddgpYU
0a7k8xVdMXzwirUIKNpopvTHMYx5a8AJuTukKTtc8E5WMKekfz6sXG7dI89RhIqA
Rni9LBCnooP1Dk08U6CA9FrsoxCucwmiz1OegK6jCkmCOql2Y3Gutv3ec5v7vSwy
8qJGLWpb5q7x8BbQ/uYyfqpvhLtJMWl46ysLH9oxl+Thh7Y3XTiTJtuG56PsJD7t
LFnkIY6BBJZsuuZnWEg7vPbNO6psNDy5YC6kd8umas/v8LY+zJqy/NCbb6ZIDIXk
GrfUG1Nfn9PxTq3vQ8orOKNZd2aIHIJZtt8cdLWKyEjP6P/r7Q5VhmEhTTs6Owh6
z7BvTi+TmA0kTp/HDvCB0WUTfkag2DchzNloLOIi9j8mzMHpYgLQq6kB21LjR1Uo
51POAxnmQlBaN7LDE/pkV4jtPULRjBvDH7o1rnaVmT7Ir1MyFlKDnazj2TaFun2i
H5dJVLk2Y86oO8Q2eBsVojgmkzAVjEwCXNPhO2L3Q8uKiyryYHdLUoaLJ/X0zoCf
Qds89s0MkuyWhQDr3D9eKQyVdjGFa8ikMip773crMxJaxzMi/Wxxp8DIlh9a6tep
KG9HgF3uswNhev4Ga1JU
=jooC
-----END PGP SIGNATURE-----

--m4G02V+VBfI/G6w2--

--===============0238799758271044199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0238799758271044199==--
