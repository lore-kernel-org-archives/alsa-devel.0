From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Rename the pointer to
 davinci dma_params as dma_params
Date: Sun, 9 Mar 2014 08:34:58 +0000
Message-ID: <20140309083458.GQ28112@sirena.org.uk>
References: <1394197435-32529-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2432839838504544880=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98592265555
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 09:35:04 +0100 (CET)
In-Reply-To: <1394197435-32529-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2432839838504544880==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xTIjn5hxPb/+Ta8q"
Content-Disposition: inline


--xTIjn5hxPb/+Ta8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2014 at 03:03:55PM +0200, Peter Ujfalusi wrote:
> It is quite confusing to name the pointer to davinci_pcm_dma_params as
> dma_data. Rename the pointer to avoid confusion.

Applied, thanks.

--xTIjn5hxPb/+Ta8q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCevAAoJELSic+t+oim9gu0QAIxLXZPzJnzdvaOVBZsq3WHX
7kJwpYtKYIDZc5rfwqktCB/lUYAhkxmWKTIjXTGrJJ5DWbjtAygDs400Cq7gZkOG
BkDVb9q7MZzaBQZ7In5uu9MxuNKCaYJlZjqw5pyCqy+sZqEq7B44JL/WCxaTtQxU
0UpJfEMdRz8mJWZ+pXWnzNJ9Js56+Ddw9Ltj4nGxMajtNHc5y4JpMg5tKV/x58O/
LT2Ag7DWpV6pRqn3j2XZRNlD/kWVEuM5KGLy3AvLs9equBe4vhSKJsvfiqXxGEWN
x5YIzKAdULIkkrxDFhNiuPr+KeYx9e8KBB03lCu2ehcL2ZFCLHc96POe290/pD7s
CYw0dPEqhuQzbJJTkX+hLbx+XKPESDDgS4TaZCi+OB7+gweP20GNM6gUiYgeLLMx
Quok6l43u0HsecIeZ6uiWFuFWM8x3SUIU+I2RSlUisckhCUEP+Un769TiE9k8Vjf
eeKgZDxuEQ9pyD5N3Le6sgjplZsSQ7ORBlJl4NK4ZKgCQpHOJznJF1rbXw8Y2W5o
amqyg5ws0uS+EZJ0LoUI6fTJ9rUwf4K34CCOS0XKBJiivAbQ9MTrK5YyAA+ahHWS
jQ98djROkmg3tFKJPYqangaI8UbR9wWe+0q5YOuiiW9JwPJJ0x+t8V+Ltsh44F6N
jlh+Wr4cSIrZ330L/Jqo
=+uR/
-----END PGP SIGNATURE-----

--xTIjn5hxPb/+Ta8q--

--===============2432839838504544880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2432839838504544880==--
