From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: Change the setting method of
	idle_bias_off
Date: Mon, 31 Mar 2014 19:29:19 +0100
Message-ID: <20140331182919.GE2269@sirena.org.uk>
References: <1396232470-11979-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9076578769617580929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81695265176
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 20:29:32 +0200 (CEST)
In-Reply-To: <1396232470-11979-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============9076578769617580929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tk7bxryrhVQGv1nz"
Content-Disposition: inline


--Tk7bxryrhVQGv1nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 10:21:10AM +0800, Oder Chiou wrote:
> The patch moves the idle_bias_off setting to struct "soc_codec_dev_rt5640".

Applied, thanks.

--Tk7bxryrhVQGv1nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTObP7AAoJELSic+t+oim9xoAP/0EA5YMen8gXOcXGmeTnuxTI
UPuMQcv6hce+ViQWMIWuDTp9Oyp2GNEeMseFnrURYZjHgDRwfOxkLiEPb+9wA3mm
P66G0hdrHiUST47dYgVWhDDzifFAKt5RJrqUxPcPg4P0l8jfvk9y7PJra6aP8Q42
aNO/u3UqiziXGJTQDlUCuPRUCuZ8HUD/gKaiQeKuASw1JjD1rJiAeRe4VM+e92Iq
NssB1l3Yy9p3OAbu0x8YKqLgHSuzkH2/MLXxFiF9feR2mwpl6p4ZjAO6SLIUuyvm
4ixRtBHLna1BGr9fsedL9nauOtHsKaUy0CYDzjE7ykvd06ZcowAq1iBmevl1QaBf
R8zxUfBhxDRDCYzFxuu3XMcDO6fz+KuwdSrxeNU+C/uI4VQmGycd2S11NGr/SOfp
C28xCtUVVHKbVnGBWA+u/tPPl/f1B/N3ECq5yzKmDfd1yKX8Gsqj9RO4gN4WZRkZ
d48nq6C+P4oxUZxGlVV93WByl0/48iR0ooxLQ8r1qLoWwGpLiRhKjeuOCjEZ8sUC
zX25sKhfh1tPr/FwI7ZQi06sGrzH3AbeIOqgRusLj+KH0lvDw+W7IACz6XrDHjb2
VEiLyu5al8vat2hS+M7u0xHCz8S8jxSR6F9a1wVCAi4p48lteR3QPM6xN25CLNMe
PJLyAILJm8d4rIGyp4D5
=A86x
-----END PGP SIGNATURE-----

--Tk7bxryrhVQGv1nz--

--===============9076578769617580929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9076578769617580929==--
