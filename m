From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] ASoC: rsnd: remove compatibility code
Date: Thu, 8 May 2014 12:18:33 +0100
Message-ID: <20140508111833.GD12304@sirena.org.uk>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
 <87ioqc20ei.wl%kuninori.morimoto.gx@gmail.com>
 <20140414190327.GE25182@sirena.org.uk>
 <87bnv9nn19.wl%kuninori.morimoto.gx@renesas.com>
 <20140508052821.GY12304@sirena.org.uk>
 <8761lgodfc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4742611805812165152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56AB72652AC
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 13:18:51 +0200 (CEST)
In-Reply-To: <8761lgodfc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4742611805812165152==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QphOdKld0oqDwxc9"
Content-Disposition: inline


--QphOdKld0oqDwxc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2014 at 01:57:50AM -0700, Kuninori Morimoto wrote:

> > Please resend any patches you want me to look at along with a pull
> > request for their dependencies.

> These patches removes old style clock / compatibility code from driver.
> These are based on platform side cleanup patches
> which are already accepted by maintainer.

Pulled and applied, thanks.

--QphOdKld0oqDwxc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTa2gGAAoJELSic+t+oim9WI8P/j9OBupSJQfnrbRanFXaUr0y
j5KQJolJmW/Htj89UpLF9IYjPoEJH6014OM019pTnmpbam53oudmnTvPpMiWKVaM
1Yqrl9mslT5Kg63RPRJuCu6WryMtJzOwQrrEGBGDqlN7/6TdGNjHG0i/fIn0lT9l
MmFO//8xF1rQFmZozFxbGWWQrv5Hua5vMsYCPLUlmMQ9TGe9dg/drVtWKBoCX87g
9CltnhCqMCwWtY76eC6OOB9V66uSS1ROkFW+xpyX6SxCptt9VHGiis2yKxypMwIP
8yFVCA+dhEZh7cVrdY6CC7gdtfUCymW2Lo2+2Ez1P7RicfdEkX1pDzTpEuyRtPjw
1aTslQkn380MAhY0Pq9EwGKwZ7awIjnqP1keVjAFdyZsS/q+9FbkfJ3lyKpwoL+c
feacZxAQcAAR5VxZeZSmuLDeqgShTSjCymqm4urK+2RDIhwxnJVzmPRZEV2Fa1gI
lSsp4Zt5WZdhKFsXzoiLovrVsjgRQS9XTf06wyyJlgC3BPhF53CBQPpB5WJfXoKz
XoVHM7kuOVkHhjwbTogPcQ7iKj4WLMkCKwamnnPGhZw3DNLpGnGlXxNlGFkAB7HG
ruvPwpNgggRsoUWpHOqRi5zGazWu5kq4pukgZhRHqO8+Jcnud3c6UFI2n6UsSZpQ
ReNC/lfxxEvNNJvFGZXx
=XOgT
-----END PGP SIGNATURE-----

--QphOdKld0oqDwxc9--

--===============4742611805812165152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4742611805812165152==--
