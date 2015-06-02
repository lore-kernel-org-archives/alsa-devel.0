From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: DAPM: fix snd_soc_dapm_new_control()
 implicit declaration
Date: Tue, 2 Jun 2015 18:18:30 +0100
Message-ID: <20150602171830.GZ14071@sirena.org.uk>
References: <1433195873-29889-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5887924973396194919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33CC2260560
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 19:18:40 +0200 (CEST)
In-Reply-To: <1433195873-29889-1-git-send-email-vz@mleia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5887924973396194919==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lUFOiBjYbj2M+tdK"
Content-Disposition: inline


--lUFOiBjYbj2M+tdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 12:57:53AM +0300, Vladimir Zapolskiy wrote:
> The change fixes the following compilation problem:

Applied, thanks.

--lUFOiBjYbj2M+tdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbeVlAAoJECTWi3JdVIfQEmsH/2blXsMCcRMX2aRQfhrrBkUz
JKXtGDTlm293DJyFwgsLWa6NNJA3pYep8suIPE8oh3tBzlsXc08Rz1KtS75GgkU4
DzL4b26tMNa+chLM9GerBiP84DPwCxWZT1HDOvOqBvDMkUJxUsrXZMf8bBX6SNLa
sKe/bQozg2e95ChEiCvxfyXt74qiTadYzGQTWVqAy/3Ss5GXJclaEnQhIm7De0po
yb2JzAg4Lpcihqr7NOFf1fidrjKMDx7DWSMZJ6uKCGmIukKkVljM710PWMJZjdvK
ZeMIhLys4hDVyVxZxcRFWlD8T6zkk+3oJpkXiVjhX+j20CgfhK/wWzJecNw4PvQ=
=eokl
-----END PGP SIGNATURE-----

--lUFOiBjYbj2M+tdK--

--===============5887924973396194919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5887924973396194919==--
