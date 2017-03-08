From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: rt5665: move set_pll to codec
	level
Date: Wed, 8 Mar 2017 13:46:14 +0100
Message-ID: <20170308124614.v3s6b4jx7wddr443@sirena.org.uk>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
 <1488971136-19100-6-git-send-email-bardliao@realtek.com>
 <ABFD875FF5FB574BA706497D987D48D701C36CAA@RTITEXTEMP.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2825711513175301560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C82DB267173
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 13:46:28 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701C36CAA@RTITEXTEMP.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "xiaoxiang@pinecone.net" <xiaoxiang@pinecone.net>, "zhongan@pinecone.net" <zhongan@pinecone.net>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2825711513175301560==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u5gckcl66kgmdd5r"
Content-Disposition: inline


--u5gckcl66kgmdd5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2017 at 11:19:52AM +0000, Bard Liao wrote:

> This patch doesn't use lower case of 's'ource in the function body.
> Could we apply the first 5 patches if there is no comment?
> Or ignore the error and I will send a patch to lower case in the function
> body?

I'll skip this patch, please send a new version.

--u5gckcl66kgmdd5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli//RUACgkQJNaLcl1U
h9Cn3gf/f8WWDTkhm+1e8CQ9zq0Io676iOJQbq0dLpKuCoWAWFTR4g4Jw17KD7Rs
4IXSnazjbFxvwK7+rWFpKeYXhPm98t7gPwVbxPu0GXFNQbAIcVQBayulizLBW29j
xxcm9m74CnJ2QRpGp0f0jDnJuB+zZveAlKQgACavUcFiArYHQrddxD4QGJhSEze/
gdDtcpagS8RB630COMCGmsHP9BH40QZEw6uuK+hFZrVR/lRx87Ag0qQC9RfF1IwL
EqTukaDHQjzcYHbxFoxo7nNdZBAUvcTVtxrTemplQ502juQkmVaRNuORvopggK1e
LnhFUCXXz0NjgiRmDuAXkv9q1rnYhw==
=jOAk
-----END PGP SIGNATURE-----

--u5gckcl66kgmdd5r--

--===============2825711513175301560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2825711513175301560==--
