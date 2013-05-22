From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] cs42l52: fix bogus shifts in "Speaker
 Volume" and "PCM Mixer Volume" controls.
Date: Wed, 22 May 2013 13:39:06 -0500
Message-ID: <20130522183906.GY1627@sirena.org.uk>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-4-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3469933569838609663=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C42E2610C3
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:39:18 +0200 (CEST)
In-Reply-To: <1369243167-28700-4-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


--===============3469933569838609663==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cy0BeJHB1CR/AQ7b"
Content-Disposition: inline


--cy0BeJHB1CR/AQ7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 07:19:26PM +0200, Nicolas Schichan wrote:
>=20
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Applied, thanks.

--cy0BeJHB1CR/AQ7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnRDHAAoJELSic+t+oim93e8P/0WZ4iCdf/RYqZlW6VATH8IM
9scp4WolBdo7RrM5pwmqboRfaZWwdS1lnjKJG+GwDL1LwjKGqiyfIIyHtopxOEQ5
isNjKd7BosrFTrU02sjKf5HsqlhUJEjft5KPUXenktA18vQgX+vWfqmFfBIvWTc7
zNNYrKMMIW7NjuWqc2K+4NSUA2maavaw/hj/pBtJaNOr5qXz8U3krkuRmUpEvf4t
+X5zOeenzdDhzygGef3t0TJb94zpf7mrm32Xt9JY+FAJAhuXoVaAgQf1cn4/XV3w
NznIe0cb5CKhrlNI2v3zonwGpDlm5tHb1wMjtGgc/2396xWwPJJZO2v74CvZUtKr
xhCrXN5H4rMIBzUqAtJsiD6XfxpVpEiHCHBQRJRWF6/lqadkEkH+A3wOmMFpJbBa
D562ciPMYLyegGlppeWAQMFyGvfmRPVLwWce4ycq92ejTR1C0d63c57+p3lbhXgT
/gfmQuSK4Yy2gV0OJ+I4yJqLazQwc6rb/c0YnRJ/1zt9RMyuG1RIFd+ZRd/WbGzj
wSdnnyKj1GqSlcx+AdhyOdfOWtpdL6V0zhZDXOKAbMUh+FAnsufNptKSPzSbkKXL
p5JHzQz8Chrc7qeggyWIZvgy3aM46fb3+vNSdFnA9snC89e8SpvtICRk9ib+T2ZK
VkzLchOb0DIq1KQpqmWH
=JMHQ
-----END PGP SIGNATURE-----

--cy0BeJHB1CR/AQ7b--

--===============3469933569838609663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3469933569838609663==--
