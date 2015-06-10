From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/3] ASoC: rt5645: add device tree
	support
Date: Wed, 10 Jun 2015 18:32:30 +0100
Message-ID: <20150610173230.GM14071@sirena.org.uk>
References: <1433917678-13166-1-git-send-email-oder_chiou@realtek.com>
 <1433917678-13166-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2270916826157251454=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1B7265DFC
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 19:32:34 +0200 (CEST)
In-Reply-To: <1433917678-13166-3-git-send-email-oder_chiou@realtek.com>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2270916826157251454==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="31SVYaQYwlkHQLrz"
Content-Disposition: inline


--31SVYaQYwlkHQLrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 02:27:58PM +0800, Oder Chiou wrote:
> Modify the RT5645 driver to parse platform data from device tree.
> Write a DT binding document to describe those properties.

Applied, thanks.

--31SVYaQYwlkHQLrz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHStAAoJECTWi3JdVIfQ9c4H+weeCdtD5Vroi/0ANWAeDrqY
4piol0doH0bgZV36yvQ+YrwDRj5fC/kf5oB4TasrZ8G3gYbzz7zHysya0W5KUMKb
MJFb+DrrHuvDs8iLTVzExLX2gS77MbiMAxubiZ+/T47lqM0NUBJmQI9kUIcnxfvw
ieG7J5srcVr1GYlE2YSaCypnJsPD72K+Xv+fjiKttEFFICHIpUAbj05hAdhXGjCl
eeVc+XaAfZT1QeCmh3sJsGJHfIOp7TyOZrFoomxvBzMkMB5UmKzRIfNAoU+gedZt
9/N55a5v9yxk2LGFz3Qi/3rnIHZWrTiEICh0iKmbTB/t2ywDLkSqOgvrbvBur5o=
=ri5K
-----END PGP SIGNATURE-----

--31SVYaQYwlkHQLrz--

--===============2270916826157251454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2270916826157251454==--
