From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Samsung: Merge two identical if-else
	clauses
Date: Wed, 29 Feb 2012 23:37:43 +0000
Message-ID: <20120229233743.GK8295@opensource.wolfsonmicro.com>
References: <1330168354-3197-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8180119151865357459=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92EC2104055
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2012 00:37:46 +0100 (CET)
In-Reply-To: <1330168354-3197-1-git-send-email-jaswinder.singh@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8180119151865357459==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 25, 2012 at 04:42:34PM +0530, Jassi Brar wrote:
> Saves two lines and a hell of a lot of embarrassment looking at the code.

Applied, thanks.

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTrbAAAoJEBus8iNuMP3drSsQAJ16HrYrJgRKR8g/dWnmATZ1
GEvsWUhwjYjMiJPWAjuD/jzsT660j347qzHd7bdl5ZYYJVkhijYsTa0Mg+Z0Us/w
KTAKB+9tKPUe8pTbw3+j4nZrrA6uAcXXySlA/3EJOcivD21iArU6jk2RgKAqq+mu
1J5ebmVvJLEei6/KdDa0nWJr2cG2Bi4O+JS67B1Ust4T0lW58ZZCYqbLQ0YyyRgl
m36AZ8uYlL2XwCN0TcWnVlXu8nyBD82Uf2Z/Hes7M5M/J+oNE8DG8O8tWc9GWCff
+WvNhTtYwSpfCyF4XKDHx1PW0X0tfunTGz9iyhBZI1vl4bNRUoUVbuAhpoFyJjQL
FvIGw/GmOKlvp4TVtqVABBsO+4Htpi7pwmf87hBEHG43/idV0znGe3JJxZmRuwEV
73Zasm/aDmEEim7GF//4fryKU+PsIv73HgYfEsp845hW2z6l0UN6wcmpF/mYXmUF
3cSqU7ARpqEqk3d38DeS2D0fqNWN1PSyee8XOOcHLbyXk+trzI3C4fl89Q5l5wRS
liY2KaSTPjCIytIkOpbiwyDHY8bFnltVGxOuKZy72lyGxs3Woqga5CME1gaj5/vZ
MMkXwQS+RbfNPsATwZ5Rx5+L3AhOtJBeAJx1Ab8RVEJSNdtJoZc1BgC31xtVwvzY
va1DevArs8SKpoKKGT+8
=VQhY
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--

--===============8180119151865357459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8180119151865357459==--
