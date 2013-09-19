From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: imx-sgtl5000: Use
	devm_snd_soc_register_card
Date: Thu, 19 Sep 2013 14:57:07 +0100
Message-ID: <20130919135707.GU21013@sirena.org.uk>
References: <1379391168-5220-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2623051253329109136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E210A265342
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 15:57:15 +0200 (CEST)
In-Reply-To: <1379391168-5220-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2623051253329109136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lpBPog2+b3WGyJY6"
Content-Disposition: inline


--lpBPog2+b3WGyJY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 09:42:46AM +0530, Sachin Kamat wrote:
> devm_snd_soc_register_card makes code simpler.

Applied all, thanks.

--lpBPog2+b3WGyJY6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOwKwAAoJELSic+t+oim9ckMP/2ZHH5yiwkKNvQVvCqGBzWpQ
m3rU1offB+9Msggh0TpR5Xm9L2I6qku088vuPyaQ0qd0bDeNiKJr4P4nahQc4kbQ
oGUIzcadvd2EHOZsFCxM4slT0CNe4He2Co+dd4juNsyGMAiWjtUGF59v0at6TonM
DnWeAO20k5KfRDiXzKSDVYgGHstcZMzv8Ysi5oYem+75T1P76VUeUPyK9RFBJsbz
GGeEz9/LY9QNTckJyj/RphnF1Brv4ZO3pCWmw6QupxmHBkOjDZTO89pMKHxnKzzT
8Q5mbQhWTmPA+t5YJZOcfASnB6c1lanFModkR35Xua8dhCWgcNYNKUZKXGHjn5FG
yMCKVNZXYLccCwWk2NxoQAEItUzwdRZlgXfTZGJc233fPWaRDCmPEzEU3RJN+I93
yP152Kxa33sIHUPN+2MK76WvX+XVAccI/y9aAu+ornC3pkrD0mRp+gu7Jb4nQAUN
VdSd7+k9OPkp2vx81tawYX1rctM5wMO4G4fGQXhLX+StchhxLZaeAvZK4Lclrshv
tiY39CKTelMv1nGThWoPsGFuW8m4sL52wJAjEeWuRCSaQB1JnYbQCHqXRUM5TIPS
MPsT7HqBDlLw97JqITbXTpQuftpmTuriBvdCI+94Ltxx2IkZLXBXozue4NAHmkDn
1hHEh4FDhuRgm91XIXkp
=cfc7
-----END PGP SIGNATURE-----

--lpBPog2+b3WGyJY6--

--===============2623051253329109136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2623051253329109136==--
