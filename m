From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused 'r' variable from
 dapm_connect_dai_link_widgets()
Date: Thu, 17 Jul 2014 12:34:04 +0100
Message-ID: <20140717113404.GV17528@sirena.org.uk>
References: <1405581334-18158-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2443148145304361019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ED5B2654FF
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 13:34:24 +0200 (CEST)
In-Reply-To: <1405581334-18158-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============2443148145304361019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lYtTbTuCUQxZgETo"
Content-Disposition: inline


--lYtTbTuCUQxZgETo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 09:15:34AM +0200, Lars-Peter Clausen wrote:
> It was accidentally added in commit 44ba2641 ("ASoC: dapm: Add support for DAI
> multicodec").

Applied, thanks.

--lYtTbTuCUQxZgETo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx7SpAAoJELSic+t+oim9VcAP/jzu1rUYk/8miFHPw2PPmQpt
q912nLbmjnllgjp8LdfDRlHq+KrFc1z9EprM2VTjsp3OwJQAL5/xOvJRUMeHmgmI
JAZH9LGLi/KuNm0GHr61WUr2JFYbte7zhO12M4fWtXGRmdgGSbbe1cHN9rHQXub1
f9p80F+xymOfhcxRxpG7U/8E31Y9wS57pPPEU4XZdCmmAlUQLpo8vXWsqk6ze7cl
IJXVye1/LBpI8jUJ9DsSQhDPae4c+hLwdNveKUW6uyVRkvhsG5o1TXEOL1cKVvJB
lkZkMXk6nsAEl8wvH9FMlqGy11lbC1m9UrJbnoWfGMjwns4fri8VNW0LoavHF6ES
YGkeXIscYTz0elSfFCqHyiKxu6xBK4XBQvj94QQq/B7Kdx96GVstuJD+p9L187qA
FGe3WRQgCypWajCgJ2VOQcvDPJZBMoZRPZJWikzxuZOR0k/P3rUnOYFkM6dy8fVh
A3C8bifN7b0semFGx7monWkIvqY9ybNPq8FFMUhgve00Jsd+iYNTHhYntxeE49Uo
ecl/wHv9zsuMF3plmZUCpksjAsafYDMlYPTdOzRpB5ghIf6itOpAUGyR8Rb/BT6l
JDEVnQ9yrlUmkGsokLAxJ1oSexH+P/Twl2SVhTJk9ojZS3q8rhm3fHht9CUBNzSn
xK9qp6W+2JfTgPEg62Mo
=2Vk4
-----END PGP SIGNATURE-----

--lYtTbTuCUQxZgETo--

--===============2443148145304361019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2443148145304361019==--
