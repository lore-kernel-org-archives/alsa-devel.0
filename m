From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: spear: Use generic dmaengine PCM
Date: Mon, 6 May 2013 20:41:58 +0100
Message-ID: <20130506194158.GH7478@sirena.org.uk>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1372273279226376283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1E7261B1D
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 21:42:05 +0200 (CEST)
In-Reply-To: <1366478947-9377-8-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1372273279226376283==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:07PM +0200, Lars-Peter Clausen wrote:
> Use the generic dmaengine PCM driver instead of a custom implementation.

Applied, thanks.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiAeCAAoJELSic+t+oim9iNgP/3VlZ//byWQR+bMXGudSqJa7
vgsxMKf0n8hyj5GXuGLi8MbyD3un4h/mH7NN9+Ulr/axgg6jzRoKKVWNrPVfOU/g
7tDeWSM5mQ0gtavpzj4+lsP25b8ROBGDCsvglXIXvt6LIhY2VQpS2yyoTEEClrib
s23mywathIWUOjn8a99mrRAcBhOUn7P3YbsIqyLCcJuFAF3ri0T425lPyiD6ZdWt
i4kr1X8cX/S4PEYkvJe4b5I3yEayPkLxynaYbvTwyR1xKfraZEeOniJ2mFhm8F8w
mUqIy9jufh3Ff9OYc0fuk+EikkNUkjoQde5RH7ru+ehk6RlmkdPZVqWWCN7Of9yU
Qa3iiwCHSU9CMU55WzcFVcJSFOfurYxDyUGb5kl2vigo+RTAQHp6+ZXM8czdF4pM
r8+oWu8zLxfFELlexC2EAJ96LJVf1fDzZeLO0tK+Pqk9iwlfaH30kT/Yu5u5BCUz
xyaQ3OoK3OORgNgoK4evDkuZAVn7ypSpxwu0q3GU34uiKtwAIKdVRL/n402G8ePl
jyoWxsAWO6BCDNr7iT0KKneMQc0tOkwwxj2MDzAY0x0du8W1uA+RjGQpYIlFLTsx
SHvC3cm9E/CYS9EWruG0/yU5qI5J8kKR8lXuhmid3jEJznWyLPz94Xh/mz7cQZz6
9XrcKPm6yRHwK5kzhz6H
=8+nu
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--

--===============1372273279226376283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1372273279226376283==--
