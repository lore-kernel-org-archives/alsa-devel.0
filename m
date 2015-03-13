From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Remove adc stereo2 filter
Date: Fri, 13 Mar 2015 11:13:26 +0000
Message-ID: <20150313111326.GD28806@sirena.org.uk>
References: <1426215026-15550-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0543204650464511186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97CF3260461
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 12:13:33 +0100 (CET)
In-Reply-To: <1426215026-15550-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, john.lin@realtek.com, alsa-devel@alsa-project.org, koro.chen@mediatek.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0543204650464511186==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g/2gxic02LijnRx4"
Content-Disposition: inline


--g/2gxic02LijnRx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2015 at 10:50:26AM +0800, Bard Liao wrote:
> Remove adc stereo2 filter since it is not in rt5645/rt5650 codec.

applied, thanks.

--g/2gxic02LijnRx4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAsZVAAoJECTWi3JdVIfQH6sH+wV1VD3PF66bxN+oomSCewIq
sFnR8Q8zLy0XlO7AcQSjETTnlJMN6osvzI+1K4zegiglsumaqALWd6Wp7EYFbzT3
ni//qL1gR73ofqflbsD+SRJJl9jQlF8KyP1ary8V0ocGz0Th58Grolivua7fevAA
6gfXxbly2KlZjKAyZR/MGbOlKJ/kGouomElPo1ltZY+s/hLQJUj/DffuWEusv8Io
7WJq/VYmDfT4JvO/D4ClUgHviECSNSneHqOkYkUClGFSpsQrLym5n3VECczPa5nT
4JuBsSuNSZGLbciariDtv+6+i4PY7D6ngLvO8ATjfSoCDonINEDHPhs0IiaSXgw=
=aUPT
-----END PGP SIGNATURE-----

--g/2gxic02LijnRx4--

--===============0543204650464511186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0543204650464511186==--
