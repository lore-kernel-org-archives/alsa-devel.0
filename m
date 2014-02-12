From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/24] ASoC: core: Convert to
 snd_card_new() with a device pointer
Date: Wed, 12 Feb 2014 13:04:07 +0000
Message-ID: <20140212130407.GN28112@sirena.org.uk>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
 <1392201340-27113-19-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4006857525407318971=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B01264F06
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 14:04:23 +0100 (CET)
In-Reply-To: <1392201340-27113-19-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4006857525407318971==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 11:35:34AM +0100, Takashi Iwai wrote:
> Also remove superfluous card->dev assignment.

Reviewed-by: Mark Brown <broonie@linaro.org>

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+3FEAAoJELSic+t+oim9gd0QAJxqRh5+5hGo0Op4ieIAOPQH
gDVbLLd7V9Il4vwHXN2a0JFXUIsWXKWlOpnzlBVAiGCus8fkknys8h2qNDTkYKTl
BrwSIJw1O7fYuYEPXuLeVL6m9rh7rhAH6btqIxNvh7oggjhBqyBaHF0fVaCxWbSX
wyKzEpnI0Rdl36KQEmBm/FkwOKmohkCXXoJT3GQhjCFCzdMQn8jqMi+lFBxxQ/mx
Y5sGQlSlWanje6+/ye2zQdJRdxAwayECOnRWVeLpwz5gDVQJ1Rgd+I1JGbr1SNd+
Z8MiPU2ncjp/lxsvdiy1S26qtdgJKmxPrtW241VNpC31B/7Q8hgdAdnrB9umjiBG
VHpoTvCEx7ajo4q4rK7QrZosMVnia/FONP9K1g9wpu+OovP+WLucU5eFiuV6rcUf
tDqGQR3VrOTC1Nt3eQuLHU0HzVQVm9W2jx+K/IxkvQypC8go9tnlDhnVhwvVwm2n
T3B/7h4w7vDUk1Fsch/fJXs75f2YSx2Gmo8gMDv1J7Ebmme+70iTpb3Qc0315wG/
KjoEVFdNO/0S89EgY0uWd/30Arq+7C3BaZF6EuRrfGjasxCw/HqQC7SQtoN1Lc25
H/hQSdozcmt/yxFiJOQ84L/ZLPeSEFuPVBsWkgMmJKhvWTBZadKL/9TkJO7H4mzf
KEUr0/NKpbA9dyXktSOR
=05n0
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--

--===============4006857525407318971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4006857525407318971==--
