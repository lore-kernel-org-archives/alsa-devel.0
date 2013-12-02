From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: ep93xx: Use
	devm_snd_dmaengine_pcm_register()
Date: Mon, 2 Dec 2013 11:48:28 +0000
Message-ID: <20131202114828.GR27568@sirena.org.uk>
References: <1385625037-24973-1-git-send-email-lars@metafoo.de>
 <1385625037-24973-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8172461100453639963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 946722619E6
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:48:37 +0100 (CET)
In-Reply-To: <1385625037-24973-3-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Florian Meier <florian.meier@koalo.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8172461100453639963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4wttjDTPgtSCp2V"
Content-Disposition: inline


--G4wttjDTPgtSCp2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:50:34AM +0100, Lars-Peter Clausen wrote:
> Makes the code slightly shorter.

Applied, thanks.

--G4wttjDTPgtSCp2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHOJAAoJELSic+t+oim9gpIQAI1f1hDgUKFmFLSGgINHVkNi
hvy3MZQDCrs1TFV5SrLJh3iji+TmXBPqiYL2E3ONEATsEorTZ3LYwm3TopPvCMm1
BDr4A8ZMcxFQ/FMKs/ixxRw5Z/48u3TCyZwsE2JIhpFeKrb5wz9OLTPamCJBDt8S
/p2ASA1vtkoZFxMerXpXPnd7bU2wVBKvxYRGd+aQgY4d+HkvxNa2ivWBm6Nt9VjV
OsISKpFohhZtZLX4YH4WLXjeEI5u8gjR3WtVfkX4P7Cvg6su5GeC/iusksvFL0n7
P3lbzZd7CXUvr17RAsF3UDATCUaFS/xXgXCyZPTQcYVcyzmivGEZObZBOWoNScUM
zullEregOYDIHAprSWkgP/8CKYLmSC5PSCtMkNAeN2odAs6AZbKstLduVbkGMBMG
KDQbaEx9rESLSZBwIgRd1ZZslMNTNIHhhDZYiyi1aumRXFF7TbZyMQwxgIsmkivu
DiwqwzyBthzS7AnHOxuYaklPbb7fBLUOSS7YPQMhHhUGeXxkxGSW1r2Eb6Wl/5NN
68ggCHZpM/O9EW7QFuGNzjnJy3yhOTAcgnLyl6AhaTr1PfVzSnJy7HGwiI5w4bhX
UTqgBLbbpbZuKDvZfe5LGQoaR3aEJ+K7my5983HJl6MUucO0D8mfO58/UBTDR9/W
b0Wd40v0zPIsWVBoZwEK
=0iaa
-----END PGP SIGNATURE-----

--G4wttjDTPgtSCp2V--

--===============8172461100453639963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8172461100453639963==--
