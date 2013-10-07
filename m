From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: twl4030: Use virtual DAPM mixer
	controls
Date: Mon, 7 Oct 2013 11:50:51 +0100
Message-ID: <20131007105051.GH21581@sirena.org.uk>
References: <1381059831-16074-1-git-send-email-lars@metafoo.de>
 <1381059831-16074-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6858148940496112592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B5E72650D7
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 12:50:58 +0200 (CEST)
In-Reply-To: <1381059831-16074-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6858148940496112592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Content-Disposition: inline


--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 06, 2013 at 01:43:50PM +0200, Lars-Peter Clausen wrote:
> By using the new virtual DAPM mixer controls it is possible to remove the
> twl4030 specific implementation of virtual controls.

Applied, thanks.

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSUpIIAAoJELSic+t+oim9OXoP/2iv7QPH7Ybf9AEGuUalG6vB
eY9sDjkF8geR809NSWFchkjwh0isCWW5QWt3v9uR2Cl87m8sNHhJp7B9Yqsck3mo
+NvhDXaDvF0lnhwssr4+PWabNJ7vaSAi+SdjJEp9gfBsfn7fOmOaig9NetgMawfh
PKUM2cmSA2b7ysVKc3aZnd2zMVnDlRywvsLeKcW+5xiU3qAg7DQLs3bx2z9olH5v
qMtsZB0opuTHLAl5wg24pxYfixw2SvbuhwXnTk8bibIGQ4QMK1PjKxO9iFkyt3Xe
ytk1QRif4bjx2/EX/TWWdRT2AkWLd83nMnW0mwrB6VVX7pNpTwWboUovErzJcf8S
vvL6QfT/7JX5ERN4g9P1I6svi5RsuX63OaFDQ93Oygf8JCAM0d5SmZN8EHiu/fog
SszdrpPrtUNcrc21jadlHCTODqf4GqMtufiHXuydtBuBb0MdwYKhZmnL2HPAoNKu
j+uJgJFWGIrJ7Zf6FurVSKGV+npJyTK54wtSv+FGsRIamb80MHXWscVcfZTxbYx3
BsZlbBqgbW31T9e6xMFAdfKn/yss5kWu7VPb0nuHp6+OfKx3F2mI1YbCZk5XprP7
yL2TI1/1mw6AhzTGgnld6w2vL8EVVvmNHvXlyolfCyEt/pTyXM7op3yVzUywRns9
ljxtMqFGdbKMN0Avn6CY
=gXZ3
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--

--===============6858148940496112592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6858148940496112592==--
