From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: Samsung: rx1950_uda1380: Remove
	unused variable
Date: Wed, 22 Jan 2014 17:13:01 +0000
Message-ID: <20140122171301.GM17314@sirena.org.uk>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
 <1390392043-24387-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8485775535600568477=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB1722619D9
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 18:13:05 +0100 (CET)
In-Reply-To: <1390392043-24387-6-git-send-email-sachin.kamat@linaro.org>
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
Cc: sbkim73@samsung.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8485775535600568477==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rci9/ELBNj9eCHO9"
Content-Disposition: inline


--Rci9/ELBNj9eCHO9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 05:30:42PM +0530, Sachin Kamat wrote:
> Fixes the following warning:
> sound/soc/samsung/rx1950_uda1380.c:228:6: warning: unused variable =E2=80=
=98err=E2=80=99 [-Wunused-variable]

Applied, thanks.

--Rci9/ELBNj9eCHO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3/waAAoJELSic+t+oim9tfcP/3gi2HtdQh31NAEnIXZxunDf
IG7w7DX2miFullo6IcxLsfSIb4jwwLd/Fgize28OJff2+Y3rSxxuuRBJ6iKtevfe
s7/ap8Y0uL4gp9ijbEjiXg1yFdAnPBtQLElKkv8PnArl0GkCCfgyZSeLIZKr7+dq
YKvCKZuBd+O+r77cBr8KGVyhZ8uZJHSQpDB9I7zk+kdL6bVkuerbDD0NeAP8WuRp
4bZrMV4zxpVapfgEYbNyCj5jkHdV1QAoIi/OJ8pvnE67TB9BNHoIpcEvWC7kmQdn
zZTcyzJPNlU2V6RTFTO4uxx2pB28TMvkfq8vgN6JcvlXTIwA4rL3BwM7SA5vy22P
7ba2d071eOq96qEocEZZ4L5LVOfqiECmsAdKX/45+Ze1HHDWwuOV6m8D5x9is8JR
OopZwWHgRocwJ8uun63qdS7o+xUxPn3eRgwGz9ulQTBfae4smg4r3eps60841+c+
Y2kznuBll9jb0dFmekc3sE7cHu/l0V/oLF9rEbFAyHFLEwfFKh3T9FntNUAunt9s
vVyVs2yPeltMI7GQC0QGSrC69Y6MGBkBJm2v5QCLYPavXuYUUfCEVfuCQwAfWx4N
NtY0ePw5FmWiu5/wntbUiClFX4uxlrzxeaPzwX7aQjoRzAFSsWMnB+MrTRUrN6tL
M7aFdaOCBThqKQ+AklDc
=C/oH
-----END PGP SIGNATURE-----

--Rci9/ELBNj9eCHO9--

--===============8485775535600568477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8485775535600568477==--
